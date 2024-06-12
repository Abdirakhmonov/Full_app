import 'package:flutter/material.dart';
import 'package:full_app/utils/note_extension.dart';

import '../../models/note_model.dart';
import '../../models/todo_model.dart';

class SearchViewDelegateNotes extends SearchDelegate<String> {
  List<Note> notes;

  SearchViewDelegateNotes({required this.notes});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, "");
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final notesList = query.isEmpty
        ? notes
        : notes
            .where((element) => element.date
                .format()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
    return ListView.builder(
        itemCount: notesList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notesList[index].title),
            subtitle: Text(notesList[index].date.format()),
          );
        });
  }
}
