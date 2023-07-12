import 'package:flutter/material.dart';
import 'package:notes_app/Models/note.dart';
import 'package:notes_app/Providers/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNewNotePage extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const AddNewNotePage({super.key,required this.isUpdate,this.note});

  @override
  State<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<AddNewNotePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  FocusNode noteFocus = FocusNode();
  @override
  void initState() {
    super.initState();

    if(widget.isUpdate==true){
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }
  }
  void addNewNote(){
       Note newNote = Note(
         id: const Uuid().v1(),
         userid: "Yogesh",
         title: titleController.text,
         content: contentController.text,
       );
     Provider.of<NotesProvider>(context,listen: false).addNote(newNote);
     Navigator.pop(context);  
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
      home:  Scaffold(
         appBar : AppBar(
           leading: IconButton(onPressed :(){
             Navigator.pop(context);
           },icon: const Icon(Icons.arrow_back_ios)),
           actions: [
             IconButton(onPressed: (){
               if(widget.isUpdate==true){
                  widget.note!.title = titleController.text;
                  widget.note!.content = contentController.text;
                  widget.note!.dateadded = DateTime.now();
                  Provider.of<NotesProvider> (context,listen: false).updateNote(widget.note!);
                  Navigator.pop(context);
               }
               else{
               addNewNote();
               Navigator.pop(context);
               }
             }, icon: const Icon(Icons.check)),
           ],
           backgroundColor: Color(0xff121212),
         ),
      backgroundColor: Color(0xffF5F5F5),
      body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
      child: SafeArea(
        child: Column(
          children: [
            // for title
           TextField(
             controller: titleController,
              autofocus: (widget.isUpdate==true) ? false : true,
              onSubmitted: (valueOnTitleField){
                  if(valueOnTitleField!=""){
                        noteFocus.requestFocus();
                  }
              },
              style: const TextStyle(
                fontSize: 30,
                
              ),
              decoration: const InputDecoration(
                hintText: "Title",
                
                border: InputBorder.none,
              ),
            ),

            // for content
            Expanded(child: 
            TextField(
            maxLines: null,
              controller: contentController,
              focusNode: noteFocus,
              style: const TextStyle(
                fontSize: 20,
              ),
              decoration: const InputDecoration(
                hintText: "Note",
                border: InputBorder.none,
              ),
            ),)
          ],
        ) ,
      ),
      )
    ),
    );
  }
}