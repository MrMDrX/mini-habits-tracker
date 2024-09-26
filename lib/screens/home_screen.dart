import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_habits/components/drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mini Habits Tracker',
          style: TextStyle(
            fontFamily: GoogleFonts.dmSerifDisplay().fontFamily,
            fontSize: 20,
          ),
        ),
      ),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
