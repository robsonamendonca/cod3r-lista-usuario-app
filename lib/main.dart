import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usuarioapp/provider/users_provider.dart';
import 'package:usuarioapp/routes/app_routes.dart';
import 'package:usuarioapp/view/user-form.dart';
import 'package:usuarioapp/view/user_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Users(),
        )
      ],
      child: MaterialApp(
        title: 'Lista Usuários',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        routes:  {
          AppRoutes.HOME:(_) => const UserList(),
          AppRoutes.USER_FORM: (_)=> const UserForm()
        },
      ),
    );
  }
}
