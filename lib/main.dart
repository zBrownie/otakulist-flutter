import 'package:flutter/material.dart';
import 'package:projectstore/Provider/animes_control.dart';
import 'package:projectstore/views/Home.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider(create: (_)=>AnimesControl(),)
    ],
    child: MaterialApp(
      title: 'Otaku List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    ),);
  }
}
