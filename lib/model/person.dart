import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Person {
  String _id;
  String _name;
  String _email;

  Person(this._id, this._name, this._email);

  Person.map(dynamic obj) {
    this._name = obj['name'];
    this._email = obj['email'];
  }

  String get id => _id;
  String get name => _name;
  String get email => _email;

  Person.fromSnapShot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _name = snapshot.value['name'];
    _email = snapshot.value['email'];
  }
}
