import 'package:flutter/material.dart';

import '../../models/todo_model.dart';

class SearchViewDelegate extends SearchDelegate<String> {
  List<Todo> todos;

  SearchViewDelegate({required this.todos});
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
    final todosList = query.isEmpty
        ? todos
        : todos.where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
        itemCount: todosList.length,
        itemBuilder: (context, index) {
      return ListTile(
        title: Text(todosList[index].title),
        subtitle: Text(todosList[index].date),
      );
    });
  }
}
