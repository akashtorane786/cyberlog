import 'services/app_settings_service.dart';
import 'package:flutter/material.dart';
import 'services/cyber_tip_service.dart';

void main() {
  runApp(const CyberLogApp());
}

class CyberLogApp extends StatefulWidget {
  const CyberLogApp({super.key});

  @override
  State<CyberLogApp> createState() => _CyberLogAppState();
}

class _CyberLogAppState extends State<CyberLogApp> {
  final AppSettingsService _settingsService = AppSettingsService();
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  void _loadTheme() async {
    final savedTheme = await _settingsService.getDarkMode();
    setState(() {
      _isDarkMode = savedTheme;
    });
  }

  void _toggleTheme(bool value) async {
    await _settingsService.setDarkMode(value);
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: MainScreen(
        isDarkMode: _isDarkMode,
        onThemeChanged: _toggleTheme,
      ),
    );
  }
}
/* ---------------- MAIN SCREEN ---------------- */

class MainScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const MainScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}


class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  late final List<Widget> _pages = [
    const HomePage(),
    const LogsPage(),
    SettingsPage(
      isDarkMode: widget.isDarkMode,
      onThemeChanged: widget.onThemeChanged,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CyberLog'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Logs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

/* ---------------- HOME PAGE ---------------- */

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CyberTipService _cyberTipService = CyberTipService();
  String cyberTip = "Loading Cyber Tip...";

  @override
  void initState() {
    super.initState();
    loadCyberTip();
  }

  void loadCyberTip() async {
    final tip = await _cyberTipService.fetchCyberTip();
    setState(() {
      cyberTip = tip;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Cyber Tip of the Day",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                cyberTip,
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/* ---------------- LOGS PAGE ---------------- */

class LogsPage extends StatelessWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Logs Page',
        style: TextStyle(fontSize: 22),
      ),
    );
  }
}

/* ---------------- SETTINGS PAGE ---------------- */

class SettingsPage extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const SettingsPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SwitchListTile(
          title: const Text('Dark Mode'),
          value: isDarkMode,
          onChanged: onThemeChanged,
        ),
      ],
    );
  }
}

