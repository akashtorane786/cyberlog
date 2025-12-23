import 'package:flutter/material.dart';

class LogsProvider extends ChangeNotifier {
  final List<String> _logs = [];

  List<String> get logs => _logs;

  void addLog(String log) {
    _logs.add(log);
    notifyListeners();
  }
}
