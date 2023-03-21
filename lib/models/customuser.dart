import 'package:flutter/material.dart';

class CustomUser {
  final String uid;

  CustomUser({required this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserData(
      {required this.uid,
      required this.name,
      required this.strength,
      required this.sugars});
}