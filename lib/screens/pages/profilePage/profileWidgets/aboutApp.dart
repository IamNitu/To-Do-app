import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Todo App",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "A simple, fast, and efficient task management application designed to help you stay organized and productive throughout your day.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),

            const SizedBox(height: 25),

            const Text(
              " Key Features",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            _featureItem("Add, update, and delete tasks easily"),
            _featureItem("Organize tasks with date and priority"),
            _featureItem("Mark tasks as completed"),
            _featureItem("Smooth and interactive UI experience"),
            _featureItem("Fast performance with clean architecture"),

            const SizedBox(height: 25),

            const Text(
              "Purpose",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "This app is built to improve productivity by helping users manage daily tasks efficiently. It focuses on simplicity, usability, and a clean user experience using Flutter.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),

            const Spacer(),

            const Center(
              child: Text(
                "Todo @2026",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _featureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}