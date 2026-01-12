import 'package:flutter/material.dart';

class SecurityChecklistScreen extends StatelessWidget {
  const SecurityChecklistScreen({super.key});

  Widget _buildCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF121826),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: iconColor.withOpacity(0.4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: iconColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security Checklist'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCard(
            icon: Icons.lock,
            iconColor: Colors.greenAccent,
            title: 'SCREEN LOCK',
            subtitle:
            'Screen lock is enabled.\n(Basic mock check for awareness)',
          ),
          _buildCard(
            icon: Icons.warning_amber_rounded,
            iconColor: Colors.orangeAccent,
            title: 'DANGEROUS PERMISSIONS',
            subtitle:
            'Camera and storage permissions are granted.\nReview app permissions regularly.',
          ),
          _buildCard(
            icon: Icons.report_problem,
            iconColor: Colors.redAccent,
            title: 'ROOT / EMULATOR STATUS',
            subtitle:
            'Root or emulator detection placeholder.\nAvoid using apps on rooted devices.',
          ),
          _buildCard(
            icon: Icons.shield,
            iconColor: const Color(0xFF00E5FF),
            title: 'SECURITY AWARENESS',
            subtitle:
            'Avoid unknown apps, public Wi-Fi, and keep your OS updated.',
          ),
        ],
      ),
    );
  }
}
