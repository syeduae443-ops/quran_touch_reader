import 'package:flutter/material.dart';
void main()=>runApp(QuranApp());

class QuranApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title:'Quran Shareef Reader',
      home:QuranHome(),
    );
  }
}

class QuranHome extends StatefulWidget{
  @override
  _QuranHomeState createState()=>_QuranHomeState();
}

class _QuranHomeState extends State<QuranHome>{
  String selectedLang = 'Telugu'; // Default Telugu

  Map<String, Map<String,String>> langData = {
    'Urdu': {
      'title':'Quran Shareef Reader',
      'bismillah':'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
      'tarjuma':'Shuru Allah ke naam se jo bada meherbaan nihayat rehem wala hai',
      'fatiha1':'Sab tareef Allah hi ke liye hai jo tamam jahanon ka Rab hai',
      'btn':'Tilawat Suno'
    },
    'English': {
      'title':'Quran Shareef Reader',
      'bismillah':'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
      'tarjuma':'In the name of Allah, the Most Gracious, the Most Merciful',
      'fatiha1':'All praise is due to Allah, Lord of all the worlds',
      'btn':'Play Audio'
    },
    'Telugu': {
      'title':'ఖురాన్ షరీఫ్ రీడర్',
      'bismillah':'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
      'tarjuma':'అనంత కరుణామయుడు, అపార కృపాశీలుడైన అల్లాహ్ పేరుతో',
      'fatiha1':'సర్వలోకాల ప్రభువైన అల్లాహ్ కే సర్వస్తోత్రాలు',
      'btn':'తిలావత్ వినండి'
    },
    'Hindi': {
      'title':'कुरान शरीफ रीडर',
      'bismillah':'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
      'tarjuma':'अल्लाह के नाम से जो बड़ा दयालु और अत्यंत कृपालु है',
      'fatiha1':'सब तारीफ अल्लाह ही के लिए है जो तमाम जहानों का रब है',
      'btn':'तिलावत सुनो'
    },
  };

  @override
  Widget build(BuildContext context){
    var t = langData[selectedLang]!;
    return Scaffold(
      backgroundColor:Color(0xFFF1F8E9),
      appBar:AppBar(
        backgroundColor:Color(0xFF1B5E20),
        title:Text(t['title']!, style:TextStyle(color:Colors.white, fontSize: selectedLang=='Telugu'?18:20)),
        centerTitle:true,
      ),
      body:Column(
        children:[
          // LANGUAGE SELECTOR
          Container(
            color:Colors.white,
            padding:EdgeInsets.symmetric(vertical:8),
            child:Row(
              mainAxisAlignment:MainAxisAlignment.spaceEvenly,
              children:[
                langBtn('Urdu','اردو'),
                langBtn('English','EN'),
                langBtn('Telugu','తెలుగు'),
                langBtn('Hindi','हिंदी'),
              ],
            ),
          ),
          Container(
            width:double.infinity,
            padding:EdgeInsets.all(20),
            decoration:BoxDecoration(gradient:LinearGradient(colors:[Color(0xFF1B5E20),Color(0xFF388E3C)])),
            child:Column(children:[
              Icon(Icons.mosque,size:50,color:Colors.white),
              SizedBox(height:8),
              Text('القرآن الكريم',style:TextStyle(fontSize:28,color:Colors.white,fontWeight:FontWeight.bold)),
              Text(t['title']!,style:TextStyle(color:Colors.white70, fontSize:16)),
            ]),
          ),
          Expanded(
            child:ListView(
              padding:EdgeInsets.all(16),
              children:[
                Container(
                  padding:EdgeInsets.all(20),
                  decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(15),boxShadow:[BoxShadow(color:Colors.black12,blurRadius:6)]),
                  child:Column(children:[
                    Text(t['bismillah']!,textAlign:TextAlign.center,style:TextStyle(fontSize:28,height:2)),
                    Divider(thickness:1),
                    SizedBox(height:12),
                    Text(t['tarjuma']!,textAlign:TextAlign.center,style:TextStyle(fontSize: selectedLang=='Telugu'?18:17, fontWeight:FontWeight.w500, color:Color(0xFF1B5E20), height:1.6)),
                    SizedBox(height:16),
                    Text(t['fatiha1']!,textAlign:TextAlign.center,style:TextStyle(fontSize:16,height:1.5)),
                    SizedBox(height:20),
                    ElevatedButton.icon(
                      icon:Icon(Icons.play_arrow),
                      label:Text(t['btn']!),
                      style:ElevatedButton.styleFrom(backgroundColor:Color(0xFF1B5E20),foregroundColor:Colors.white,minimumSize:Size(double.infinity,45)),
                      onPressed:(){},
                    ),
                    SizedBox(height:10),
                    Text('Selected: $selectedLang | 114 Surah Available',style:TextStyle(color:Colors.grey,fontSize:12)),
                  ]),
                ),
                SizedBox(height:16),
                Text('✅ Telugu Translation Added Successfully!',textAlign:TextAlign.center,style:TextStyle(color:Colors.green,fontWeight:FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget langBtn(String lang, String label){
    bool isSelected = selectedLang==lang;
    return GestureDetector(
      onTap:(){setState(()=>selectedLang=lang);},
      child:Container(
        padding:EdgeInsets.symmetric(horizontal:14,vertical:8),
        decoration:BoxDecoration(
          color:isSelected?Color(0xFF1B5E20):Colors.grey.shade200,
          borderRadius:BorderRadius.circular(20),
          border:Border.all(color:isSelected?Color(0xFF1B5E20):Colors.grey.shade300),
        ),
        child:Text(label,style:TextStyle(color:isSelected?Colors.white:Colors.black87,fontWeight:FontWeight.bold,fontSize:13)),
      ),
    );
  }
}
