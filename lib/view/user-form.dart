// ignore_for_file: file_names, body_might_complete_normally_nullable, unused_local_variable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:usuarioapp/models/user.dart';
import 'package:usuarioapp/provider/users_provider.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(User? user) {
    if (user != null) {
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = ModalRoute.of(context)!.settings.arguments as User?;

    _loadFormData(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulário de Usuário"),
        elevation: 1.0,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState!.validate();

              if (isValid) {
                _form.currentState!.save();

                Provider.of<Users>(context, listen: false).put(
                  User(
                    id: _formData['id'] ?? "",
                    name: _formData['name']!,
                    email: _formData['email']!,
                    avatarUrl: _formData['avatarUrl']!,
                  ),
                );

                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
            key: _form,
            child: Column(
              children: [
                GestureDetector(
                  child: Container(
                    width: 140.0,
                    height: 140.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: _formData['avatarUrl'] != null &&
                                    _formData['avatarUrl'] != ""
                                ? trataImage()
                                : const AssetImage("assets/person.png"),
                            fit: BoxFit.cover)),
                  ),
                  onTap: () async {},
                ),
                TextFormField(
                  initialValue: _formData['avatarUrl'],
                  decoration: const InputDecoration(labelText: "Url do Avatar"),
                  onSaved: (value) => _formData['avatarUrl'] = value!,
                  onChanged: (value) {
                    setState(() {
                      _formData['avatarUrl'] = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  initialValue: _formData['name'],
                  decoration: const InputDecoration(labelText: "Nome"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nome é inválido';
                    }

                    if (value.trim().length < 3) {
                      return 'Nome muito pequeno. No mínimo 3 letras.';
                    }
                    return null;
                  },
                  onSaved: (value) => _formData['name'] = value!,
                ),
                TextFormField(
                  initialValue: _formData['email'],
                  decoration: const InputDecoration(labelText: "E-mail"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'E-mail não pode esta vazio';
                    }
                    if (!isValidEmail(value)) {
                      return 'E-mail é inválido';
                    }
                  },
                  onSaved: (value) => _formData['email'] = value!,
                ),
              ],
            )),
      ),
    );
  }

  bool isValidEmail(String email) {
    RegExp reg = RegExp(r"^[^@]+@[^@]+\.[^@]+$");
    return reg.hasMatch(email);
  }

  dynamic trataImage() {
    String url = _formData['avatarUrl']!;
    debugPrint('trataImage: $url');
    if (url.contains("http")) {
      return NetworkImage(url);
    }
    return AssetImage((url));
  }
}
