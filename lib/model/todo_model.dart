import 'package:flutter/material.dart';

class Todo {
  int? id;
  String title;
  String description;

  Todo({
    this.id,
    required this.title,
    required this.description,
  });
}
