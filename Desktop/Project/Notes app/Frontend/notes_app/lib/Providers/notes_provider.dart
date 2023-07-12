import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notes_app/Models/note.dart';
import 'package:notes_app/Services/api_service.dart';

class NotesProvider with ChangeNotifier{
  List<Note> notes = [];
  bool isLoading = true;
  NotesProvider(){
    fetchNote();
  }
  void sortNotes(){
    notes.sort((a,b) => b.dateadded!.compareTo(a.dateadded!));
  }
  List<Note> getFilteredNotes(String searchQuery){
    return notes.where((element) => element.title!.toLowerCase().contains(searchQuery.toLowerCase()) ||element.content!.toLowerCase().contains(searchQuery.toLowerCase())  ).toList();
  }
  void fetchNote () async{
    notes = await ApiService.fetchNotes("userid");
    sortNotes();
    isLoading = false;
    notifyListeners();
  }
  void addNote(Note note){
    notes.add(note);
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  void updateNote(Note note){
       int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.id==note.id));
       notes[indexOfNote] = note;
       sortNotes();
       notifyListeners();
      ApiService.addNote(note);
  }

  void deleteNote(Note note){
    int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.id==note.id));
    notes.removeAt(indexOfNote);
    sortNotes();
    notifyListeners();
    ApiService.deleteNote(note);
  }
}