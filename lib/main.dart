import 'package:flutter/material.dart';

void main() => runApp(QuranApp());

class QuranApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quran Shareef Reader',
      home: Scaffold(
        backgroundColor: Color(0xFFF0F8F0),
        appBar: AppBar(
          title: Text('Quran Shareef Reader', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.green[800],
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(12),
          children: [
            Card(
              child: ListTile(
                leading: Icon(Icons.book, color: Colors.green, size: 40),
                title: Text('Al-Fatiha', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                subtitle: Text('Surah 1 - 7 Ayat - Makki'),
                trailing: Icon(Icons.play_circle, color: Colors.green, size: 35),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Text('بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ', textAlign: TextAlign.right, style: TextStyle(fontSize: 28, height: 2)),
                  Divider(),
                  Text('Shuru Allah ke naam se jo bada meherbaan nihayat rehem wala hai', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.play_arrow), label: Text('Tilawat Suno'), style: ElevatedButton.styleFrom(backgroundColor: Colors.green[800])),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text('InshaAllah pura Quran yahan ayega - Abhi test build hai', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
