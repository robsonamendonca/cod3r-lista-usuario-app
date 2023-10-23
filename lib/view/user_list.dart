import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usuarioapp/provider/users_provider.dart';
import 'package:usuarioapp/routes/app_routes.dart';
import 'package:usuarioapp/widgets/user_tile.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        centerTitle: true,
        title: const Text("Lista de Usuários"),
        actions: [
          IconButton(
            onPressed: ()=>{
              Navigator.of(context).pushNamed(AppRoutes.USER_FORM)
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: ListView.builder(
          itemCount: users.count,
          itemBuilder: ((context, index) =>
              UserTile(users.byIndex(index)))),
    );
  }
}
