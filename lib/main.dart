import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petize_challenge/app.dart';
import 'package:petize_challenge/app_module.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: const App()));
}
