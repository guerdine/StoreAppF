import 'package:flutter/material.dart';
import 'package:storeapp/app/di/dependency_injection.dart';
import 'package:storeapp/app/main_app.dart';

void main() {
  DependencyInjection.setup();
  runApp(const MainApp());
}

