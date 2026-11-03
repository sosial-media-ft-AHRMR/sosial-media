import 'package:flutter/material.dart';

// 1. Notifier global (bisa dipanggil dari main.dart juga)
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

class ModeGelapTerangPage extends StatelessWidget {
  const ModeGelapTerangPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tampilan Mode',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih tampilan aplikasi yang paling nyaman untuk mata Anda.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // Pilihan Mode Terang (Light Mode)
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: !isDark ? Colors.green : Colors.grey.shade300,
                  width: !isDark ? 2 : 1,
                ),
              ),
              child: RadioListTile<ThemeMode>(
                title: const Text(
                  'Mode Terang',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: const Text('Tampilan cerah standar'),
                secondary: const Icon(Icons.wb_sunny_outlined, color: Colors.orange),
                value: ThemeMode.light,
                groupValue: isDark ? ThemeMode.dark : ThemeMode.light,
                activeColor: Colors.green,
                onChanged: (ThemeMode? value) {
                  if (value != null) {
                    themeNotifier.value = value;
                  }
                },
              ),
            ),

            const SizedBox(height: 12),

            // Pilihan Mode Gelap (Dark Mode)
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: isDark ? Colors.greenAccent : Colors.grey.shade700,
                  width: isDark ? 2 : 1,
                ),
              ),
              child: RadioListTile<ThemeMode>(
                title: const Text(
                  'Mode Gelap',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: const Text('Lebih nyaman di malam hari & hemat baterai'),
                secondary: const Icon(Icons.nightlight_round, color: Colors.indigoAccent),
                value: ThemeMode.dark,
                groupValue: isDark ? ThemeMode.dark : ThemeMode.light,
                activeColor: Colors.greenAccent,
                onChanged: (ThemeMode? value) {
                  if (value != null) {
                    themeNotifier.value = value;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
