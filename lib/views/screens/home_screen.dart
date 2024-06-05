import 'package:flutter/material.dart';
import 'package:full_app/services/course_service.dart';
import 'package:full_app/views/screens/todos_screen.dart';

import '../widgets/drawer_page.dart';
import 'notes_screen.dart';

class HomeScreen extends StatefulWidget {
  final Function(int) onItemTapped;
  final int currentIndex;

   HomeScreen(
      {super.key, required this.onItemTapped, required this.currentIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final courseService = CourseService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    courseService.fetchCourse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(
        title: const Text(
          "Home Screen",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(10),
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TodosScreen(
                          onItemTapped: widget.onItemTapped,
                          currentIndex: widget.currentIndex)));
            },
            child: const Card(
              child: Center(
                  child: Text(
                    "Todos",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    textAlign: TextAlign.center,
                  )),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotesScreen()));
            },
            child: const Card(
              child: Center(
                  child: Text("Notes",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24))),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        selectedItemColor: Colors.green,
        onTap: widget.onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.stacked_bar_chart), label: "Statistic"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}