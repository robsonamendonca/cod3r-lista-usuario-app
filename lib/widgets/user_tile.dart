// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usuarioapp/models/user.dart';
import 'package:usuarioapp/provider/users_provider.dart';
import 'package:usuarioapp/routes/app_routes.dart';

class UserTile extends StatelessWidget {
  final User user;
  const UserTile(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    final avatar = (user.avatarUrl.isEmpty)
        ? const CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));

    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              color: Colors.amber,
              onPressed: () => {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM,
                  arguments: user,
                )
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () => {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: const Text("Exluir Usuário"),
                          content: const Text('Tem certeza?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text("Não"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text("Sim"),
                            ),
                          ],
                        )).then((confirmed) => {
                      if (confirmed)
                        {
                          Provider.of<Users>(context, listen: false)
                              .remove(user)
                        }
                    })
                //
              },
            ),
          ],
        ),
      ),
    );
  }
}
