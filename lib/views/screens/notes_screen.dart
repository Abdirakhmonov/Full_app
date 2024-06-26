import 'package:flutter/material.dart';
import 'package:full_app/utils/note_extension.dart';
import 'package:full_app/views/widgets/manage_note.dart';
import 'package:full_app/views/widgets/note_item.dart';
import 'package:full_app/views/widgets/search_notes.dart';

import '../../models/note_model.dart';
import '../../utils/routes_utild.dart';
import '../../viewmodel/notes_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<NotesScreen> {
  final notesViewModel = NotesViewmodel();
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();

    selectedDate = DateTime.now();
  }

  void addNote() async {
    final response = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ManageNoteScreen(notes: null)));

    if (response != null) {
      await notesViewModel.addNote(
        (response as Map)['title'],
        response['date'],
      );
      setState(() {});
    }
  }

  void editNote(Note note) async {
    final response = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ManageNoteScreen(
                  notes: note,
                )));

    if (response != null) {
      await notesViewModel.editNote(
        note.id,
        (response as Map)['title'],
        response['date'],
      );
      setState(() {});
    }
  }

  void deleteNote(Note note) async {
    final response = await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Ishonchingiz komilmi?"),
          content: Text("Siz ${note.title} eslatmani o'chirmoqchisiz."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child:  Text(AppLocalizations.of(context)!.cancel),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child:  Text(AppLocalizations.of(context)!.save),
            ),
          ],
        );
      },
    );

    if (response) {
      await notesViewModel.deleteNote(note.id);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          AppLocalizations.of(context)!.notesScreen,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: addNote,
            icon: const Icon(Icons.add),
          ),
          IconButton(onPressed: ()async{
            String? result = await showSearch(
                context: context,
                delegate:
                SearchViewDelegateNotes(notes: await notesViewModel.list(selectedDate)));
          }, icon: Icon(Icons.search))
        ],
      ),
      body: Column(
        children: [
        
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder(
              future: notesViewModel.list(selectedDate),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }

                final notes = snapshot.data;
                return notes == null || notes.isEmpty
                    ? const Center(
                        child: Text("Eslatmalar mavjud emas."),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(20),
                        itemCount: notes.length,
                        itemBuilder: (ctx, index) {
                          return NoteItem(
                              note: notes[index],
                              onEdit: () {
                                editNote(notes[index]);
                              },
                              onDelete: () {
                                deleteNote(notes[index]);
                              });
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
