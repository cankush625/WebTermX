import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:mobile_terminal/terminal/terminal.dart';
import 'package:mobile_terminal/terminal/terminal_history.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MobileTerminal());
}

class MobileTerminal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Color(0xFF0f088a));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => TerminalOutput(),
        'history': (context) => History(),
      },
    );
  }
}