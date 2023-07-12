import 'package:flutter/material.dart';
import 'package:notes_app/Providers/notes_provider.dart';
import 'package:provider/provider.dart';
import 'Pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return MultiProvider(providers: [
             ChangeNotifierProvider(create: (context)=>NotesProvider())
    ],
    child:  const  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  HomePage(),
    ),);
  }
}


