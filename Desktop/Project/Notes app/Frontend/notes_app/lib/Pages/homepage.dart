import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:notes_app/Models/note.dart';
import 'package:notes_app/Providers/notes_provider.dart';
import 'package:provider/provider.dart';

import 'add_new_note_page.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = "";
  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);  
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xff121212),
        title: const Text("Notes app"),
        centerTitle: true,
      ),
      body: (notesProvider.isLoading==false) ? SafeArea(
        child:  (notesProvider.notes.isNotEmpty) ? ListView(
          children: [
            Padding(padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (val){
                setState(() {
                  searchQuery = val;
                });
              },

             decoration : const InputDecoration(hintText: "search")
            ),
            ),
            (notesProvider.getFilteredNotes(searchQuery).isNotEmpty) ? GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: notesProvider.getFilteredNotes(searchQuery).length,
          itemBuilder: (context,index){
            Note currentNote = notesProvider.getFilteredNotes(searchQuery)[index];
            return GestureDetector(
              onTap: (){
                Navigator.push(context, CupertinoPageRoute(builder: (context) => AddNewNotePage(isUpdate: true,note: currentNote)));
              },
              onLongPress: (){
                notesProvider.deleteNote(currentNote);
              },
              child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black,
                  width: 5,
                )
              ),
              margin: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                
                Text(currentNote.title!,maxLines: 1,overflow: TextOverflow.ellipsis, style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30,
                ),),
                const SizedBox(height: 7,),
                Text(currentNote.content!,maxLines : 5 ,overflow: TextOverflow.ellipsis,style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                  fontSize: 18,
                  
                ),)
              ]),
            ),
            );
          },
      
        ) : const Center(child: (Text("No notes found"))),
          ],
        ) : const Center(
          child: Text("No notes yet"),
        )
      
      ) : const Center(child: CircularProgressIndicator(),),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff121212),
        onPressed: (){
           // ignore: non_constant_identifier_names
           Navigator.push(context,CupertinoPageRoute(fullscreenDialog: true ,builder: (Context)=>const AddNewNotePage(isUpdate: false)));
        },
        child: const Icon(Icons.add),
      ),
    ),
    );
  }
}