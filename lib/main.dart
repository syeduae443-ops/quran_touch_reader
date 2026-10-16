import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(const QuranApp());

class QuranApp extends StatelessWidget {
  const QuranApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quran Touch',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const QuranPage(),
    );
  }
}

class QuranPage extends StatefulWidget {
  const QuranPage({super.key});
  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  final player = AudioPlayer();
  int? playingIndex;

  final List<Map<String, String>> ayat = [
    {"ar": "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ", "tr": "Bismillahir Rahmanir Rahim"},
    {"ar": "الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ", "tr": "Alhamdulillahi Rabbil Alameen"},
    {"ar": "الرَّحْمَٰنِ الرَّحِيمِ", "tr": "Ar-Rahmanir Rahim"},
    {"ar": "مَالِكِ يَوْمِ الدِّينِ", "tr": "Maliki Yaumid Deen"},
    {"ar": "إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ", "tr": "Iyyaka Na'budu Wa Iyyaka Nastaeen"},
  ];

  Future<void> playAyat(int index) async {
    setState(() => playingIndex = index);
    await player.stop();
    // Example audio - yahan aap quran audio ka URL lagayenge
    await player.play(UrlSource('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'));
    player.onPlayerComplete.listen((_) {
      setState(() => playingIndex = null);
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quran Touch Reader'), backgroundColor: Colors.green[700], foregroundColor: Colors.white),
      body: ListView.builder(
        itemCount: ayat.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, i) {
          final isPlaying = playingIndex == i;
          return Card(
            color: isPlaying? Colors.green[100] : Colors.white,
            child: ListTile(
              leading: Icon(isPlaying? Icons.volume_up : Icons.play_circle, color: Colors.green[700], size: 32),
              title: Text(ayat[i]['ar']!, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.right),
              subtitle: Text(ayat[i]['tr']!),
              onTap: () => playAyat(i),
            ),
          );
        },
      ),
    );
  }
}
