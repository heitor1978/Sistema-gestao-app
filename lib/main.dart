import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sistemagestao_app/firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

