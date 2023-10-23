// ignore_for_file: prefer_final_fields, unnecessary_null_comparison

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:usuarioapp/data/dummy_users.dart';
import 'package:usuarioapp/models/user.dart';

class Users with ChangeNotifier {
  Map<String, User> _items = {...DUMMY_USERs};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(User user) {
    if (user == null) {
      return;
    }
    if (user.id != null &&
        user.id.trim().isNotEmpty &&
        _items.containsKey(user.id)) {
      _items.update(
        user.id,
        (_) => User(
            id: user.id,
            name: user.name,
            email: user.email,
            avatarUrl: user.avatarUrl),
      );
    } else {
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(
        id,
        () => User(
            id: id,
            name: user.name,
            email: user.email,
            avatarUrl: user.avatarUrl),
      );
    }

    notifyListeners();
    //https://youtu.be/ViahqKZzZ7Y?si=GyVIvFQFd_3PJxyS Leonardo Leitao
  }

  void remove(User user) {
    if (user != null && user.id != null) {
      _items.remove(user.id);
      notifyListeners();
    }
  }
}
