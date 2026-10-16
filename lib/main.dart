import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(QuranApp());

class QuranApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quran Touch Reader',
      theme: ThemeData(primarySwatch: Colors.green),
      home: SurahListScreen(),
    );
  }
}

class SurahListScreen extends StatefulWidget {
  @override
  _SurahListScreenState createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen> {
  List surahs = [];
  String selectedLang = '131';
  
  final Map<String, String> languages = {
    '122': 'Urdu - Jalandhry',
    '19': 'Hindi - Suhel Farooq',
    '131': 'English - Sahih International',
    '33': 'Malayalam - Karamani',
    '168': 'Tamil',
    '161': 'Bengali',
    '77': 'Turkish',
    '31': 'French',
    '27': 'German',
    '83': 'Spanish',
    '45': 'Russian',
    '134': 'Indonesian',
    '39': 'Malay',
  };

  @override
  void initState() {
    super.initState();
    fetchSurahs();
  }

  fetchSurahs() async {
    final res = await http.get(Uri.parse('https://api.quran.com/api/v4/chapters'));
    if (res.statusCode == 200) {
      setState(() => surahs = json.decode(res.body)['chapters']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('القرآن الكريم'),
        backgroundColor: Color(0xFF0A5C36),
        actions: [
          DropdownButton<String>(
            value: selectedLang,
            dropdownColor: Colors.white,
            underline: SizedBox(),
            icon: Icon(Icons.language, color: Colors.white),
            onChanged: (v) => setState(() => selectedLang = v!),
            items: languages.entries.map((e) {
              return DropdownMenuItem(value: e.key, child: Text(e.value, style: TextStyle(fontSize: 12, color: Colors.black)));
            }).toList(),
          )
        ],
      ),
      body: surahs.isEmpty
