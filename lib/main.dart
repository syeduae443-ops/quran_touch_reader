import 'package:flutter/material.dart';

void main() => runApp(const QuranApp());

class QuranApp extends StatelessWidget {
  const QuranApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quran Touch Reader',
      home: const QuranPage(),
    );
  }
}

class QuranPage extends StatelessWidget {
  const QuranPage({super.key});

  final List<Map<String, String>> ayat = const [
    {"ar": "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ", "en": "Bismillah"},
    {"ar": "الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ", "en": "Alhamdulillah"},
    {"ar": "الرَّحْمَٰنِ الرَّحِيمِ", "en": "Ar Rahman"},
    {"ar": "مَالِكِ يَوْمِ الدِّينِ", "en": "Malik"},
    {"ar": "إِيَّاكَ نَعْبُدُ", "en": "Iyyaka Na'budu"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quran Touch Reader'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: ayat.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, i) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.menu_book, color: Colors.green, size: 32),
              title: Text(ayat[i]['ar']!, textAlign: TextAlign.right, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              subtitle: Text(ayat[i]['en']!),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Touched: ${ayat[i]['en']}')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
