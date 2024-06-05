import 'package:flutter/material.dart';

import '../../viewmodel/todo_viewmodel.dart';

class NotesScreen extends StatelessWidget {
  NotesScreen({super.key});

  final todosViewModel = TodosViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: todosViewModel.list,
          builder: (context, snapshot) {
            if(snapshot.data == null){
              return const Center(child: CircularProgressIndicator(),);
            }
            final todos = snapshot.data;
            return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: const BorderSide(color: Colors.amber)),
                    title: Text(todo.title),
                    subtitle: Text(todo.date),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: todos!.length);
          }),
    );
  }
}