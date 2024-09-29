import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "About",
              style: GoogleFonts.dmSerifDisplay(
                  fontSize: 32,
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                "Mini Habits is a minimal habits tracking app that allows you to create and keep track of your daily habits. It is a free and open source app that is built using Flutter.",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 20,
                ),
              )),
        ],
      ),
    );
  }
}
