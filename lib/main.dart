import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:quran/quran.dart' as quran;

void main() => runApp(const QuranApp());

class QuranApp extends StatelessWidget {
  const QuranApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quran Shareef Reader',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const SurahListPage(),
    );
  }
}

class SurahListPage extends StatelessWidget {
  const SurahListPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quran Shareef Reader'),
        backgroundColor: Colors.green[800],
        foregroundColor: Colors.white,
        centerTitle: true
      ),
      body: ListView.builder(
        itemCount: 114,
        itemBuilder: (c, i) {
          int surah = i + 1;
          return Card(
            child: ListTile(
              leading: CircleAvatar(backgroundColor: Colors.green[700], child: Text('$surah', style: const TextStyle(color: Colors.white))),
              title: Text(quran.getSurahNameArabic(surah), textAlign: TextAlign.right, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              subtitle: Text('${quran.getSurahNameEnglish(surah)} - ${quran.getVerseCount(surah)} Ayat'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AyatPage(surahNumber: surah))),
            ),
          );
        },
      ),
    );
  }
}

class AyatPage extends StatefulWidget {
  final int surahNumber;
  const AyatPage({super.key, required this.surahNumber});
  @override
  State<AyatPage> createState() => _AyatPageState();
}

class _AyatPageState extends State<AyatPage> {
  final player = AudioPlayer();
  int? playingAyat;

  String getAudioUrl(int surah, int ayah) {
    String s = surah.toString().padLeft(3, '0');
    String a = ayah.toString().padLeft(3, '0');
    return 'https://everyayah.com/data/Alafasy_128kbps/$s$a.mp3';
  }

  Future<void> playAyat(int ayah) async {
    setState(() => playingAyat = ayah);
    await player.stop();
    await player.play(UrlSource(getAudioUrl(widget.surahNumber, ayah)));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int count = quran.getVerseCount(widget.surahNumber);
    return Scaffold(
      appBar: AppBar(
        title: Text(quran.getSurahNameArabic(widget.surahNumber)),
        backgroundColor: Colors.green[800],
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: count,
        padding: const EdgeInsets.all(10),
        itemBuilder: (c, i) {
          int ayahNum = i + 1;
          bool isPlaying = playingAyat == ayahNum;
          return Card(
            color: isPlaying? Colors.green[100] : Colors.white,
            child: ListTile(
              leading: Icon(isPlaying? Icons.volume_up : Icons.play_circle_fill, color: Colors.green[700], size: 32),
              title: Text(quran.getVerse(widget.surahNumber, ayahNum), textAlign: TextAlign.right, style: const TextStyle(fontSize: 22, height: 1.8)),
              subtitle: Text('Ayat $ayahNum - Touch for Voice'),
              onTap: () => playAyat(ayahNum),
            ),
          );
        },
      ),
    );
  }
}
