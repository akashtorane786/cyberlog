import 'security_checklist_screen.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'services/app_settings_service.dart';
import 'services/cyber_tip_service.dart';
import 'camera_screen.dart';

/* -------- CAMERA GLOBAL -------- */
late List<CameraDescription> cameras;

/* -------- MAIN -------- */
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const CyberLogApp());
}

/* ---------------- APP ROOT ---------------- */

class CyberLogApp extends StatefulWidget {
  const CyberLogApp({super.key});

  @override
  State<CyberLogApp> createState() => _CyberLogAppState();
}

class _CyberLogAppState extends State<CyberLogApp> {
  final AppSettingsService _settingsService = AppSettingsService();
  bool _isDarkMode = true;

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
      theme: _isDarkMode
          ? ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0F1A),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0B0F1A),
          elevation: 0,
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00E5FF),
        ),
      )
          : ThemeData.light(),
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
      appBar: AppBar(title: const Text('CyberLog')),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0B0F1A),
        selectedItemColor: const Color(0xFF00E5FF),
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Logs'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
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

  /* -------- CAMERA -------- */
  Future<void> openCamera() async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CameraScreen(cameras: cameras),
        ),
      );
    }
  }

  /* -------- STORAGE PERMISSION (STEP 2) -------- */
  Future<void> requestStoragePermission() async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Storage permission granted ✅")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Storage permission denied ❌")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFF121826),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF00E5FF).withOpacity(0.4),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "CYBER TIP OF THE DAY",
                style: TextStyle(
                  color: Color(0xFF00E5FF),
                  fontSize: 14,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                cyberTip,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00E5FF),
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          onPressed: openCamera,
          icon: const Icon(Icons.camera_alt),
          label: const Text("OPEN CAMERA"),
        ),

        const SizedBox(height: 12),

        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00E5FF),
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          onPressed: requestStoragePermission,
          icon: const Icon(Icons.folder),
          label: const Text("ALLOW STORAGE ACCESS"),
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
        style: TextStyle(color: Colors.white70, fontSize: 22),
      ),
    );
  }
}
/* ---------------- SETTINGS PAGE ---------------- */

class SettingsPage extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const SettingsPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  static const platform = MethodChannel('device_info_channel');

  String deviceModel = "Fetching device info...";

  @override
  void initState() {
    super.initState();
    getDeviceModel();
  }

  Future<void> getDeviceModel() async {
    try {
      final String result =
      await platform.invokeMethod('getDeviceModel');
      setState(() {
        deviceModel = result;
      });
    } catch (e) {
      setState(() {
        deviceModel = "Failed to get device model";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        /* ---- DARK MODE ---- */
        SwitchListTile(
          title: const Text('Dark Mode'),
          value: widget.isDarkMode,
          onChanged: widget.onThemeChanged,
        ),

        const SizedBox(height: 20),

        /* ---- DEVICE MODEL ---- */
        ListTile(
          leading: const Icon(Icons.phone_android),
          title: const Text("Device Model"),
          subtitle: Text(deviceModel),
        ),

        const SizedBox(height: 20),

        /* ---- SECURITY CHECKLIST ---- */
        ListTile(
          leading: const Icon(Icons.security),
          title: const Text("Security Checklist"),
          subtitle: const Text("View device security status"),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SecurityChecklistScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}
