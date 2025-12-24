import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session9Classroom extends StatefulWidget {
  const Session9Classroom({super.key});

  @override
  State<Session9Classroom> createState() => _Session9ClassroomState();
}

class _Session9ClassroomState extends State<Session9Classroom> {
  final TextEditingController _controller = TextEditingController();
  String? savedName;

  @override
  void initState() {
    super.initState();
    loadName();
  }

  Future<void> loadName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedName = prefs.getString('username');
    });
  }

  Future<void> saveName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _controller.text);
    loadName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session 9 Classroom'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter your name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: saveName,
              child: const Text('Save Name'),
            ),
            const SizedBox(height: 20),
            if (savedName != null)
              Text(
                'Welcome, $savedName 👋',
                style: const TextStyle(fontSize: 22),
              ),
          ],
        ),
      ),
    );
  }
}
