import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

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
  final List<String> surahNames = const ["Al-Fatiha","Al-Baqarah","Al-Imran","An-Nisa","Al-Ma'idah","Al-An'am","Al-A'raf","Al-Anfal","At-Tawbah","Yunus","Hud","Yusuf","Ar-Ra'd","Ibrahim","Al-Hijr","An-Nahl","Al-Isra","Al-Kahf","Maryam","Ta-Ha","Al-Anbiya","Al-Hajj","Al-Mu'minun","An-Nur","Al-Furqan","Ash-Shu'ara","An-Naml","Al-Qasas","Al-Ankabut","Ar-Rum","Luqman","As-Sajda","Al-Ahzab","Saba","Fatir","Ya-Sin","As-Saffat","Sad","Az-Zumar","Ghafir","Fussilat","Ash-Shura","Az-Zukhruf","Ad-Dukhan","Al-Jathiya","Al-Ahqaf","Muhammad","Al-Fath","Al-Hujurat","Qaf","Adh-Dhariyat","At-Tur","An-Najm","Al-Qamar","Ar-Rahman","Al-Waqi'a","Al-Hadid","Al-Mujadila","Al-Hashr","Al-Mumtahana","As-Saff","Al-Jumu'a","Al-Munafiqun","At-Taghabun","At-Talaq","At-Tahrim","Al-Mulk","Al-Qalam","Al-Haqqah","Al-Ma'arij","Nuh","Al-Jinn","Al-Muzzammil","Al-Muddathir","Al-Qiyama","Al-Insan","Al-Mursalat","An-Naba","An-Nazi'at","Abasa","At-Takwir","Al-Infitar","Al-Mutaffifin","Al-Inshiqaq","Al-Buruj","At-Tariq","Al-A'la","Al-Ghashiya","Al-Fajr","Al-Balad","Ash-Shams","Al-Layl","Ad-Duha","Ash-Sharh","At-Tin","Al-Alaq","Al-Qadr","Al-Bayyina","Az-Zalzala","Al-Adiyat","Al-Qari'a","At-Takathur","Al-Asr","Al-Humaza","Al-Fil","Quraysh","Al-Ma'un","Al-Kawthar","Al-Kafirun","An-Nasr","Al-Masad","Al-Ikhlas","Al-Falaq","An-Nas"];

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
          return Card(
            child: ListTile(
              leading: CircleAvatar(backgroundColor: Colors.green[700], child: Text('${i+1}', style: const TextStyle(color: Colors.white))),
              title: Text(surahNames[i]),
              subtitle: Text('Surah ${i+1} - Touch to Listen'),
              trailing: const Icon(Icons.play_circle_fill, color: Colors.green),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AyatPage(surahNumber: i+1, surahName: surahNames[i]))),
            ),
          );
        },
      ),
    );
  }
}

class AyatPage extends StatefulWidget {
  final int surahNumber;
  final String surahName;
  const AyatPage({super.key, required this.surahNumber, required this.surahName});
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.surahName),
        backgroundColor: Colors.green[800],
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.all(10),
        itemBuilder: (c, i) {
          int ayahNum = i + 1;
          bool isPlaying = playingAyat == ayahNum;
          return Card(
            color: isPlaying? Colors.green[100] : Colors.white,
            child: ListTile(
              leading: Icon(isPlaying? Icons.volume_up : Icons.play_circle_fill, color: Colors.green[700], size: 32),
              title: Text('Surah ${widget.surahName} - Ayat $ayahNum', textAlign: TextAlign.left, style: const TextStyle(fontSize: 18)),
              subtitle: const Text('Touch to Play Tilawat - Alafasy'),
              onTap: () => playAyat(ayahNum),
            ),
          );
        },
      ),
    );
  }
}
