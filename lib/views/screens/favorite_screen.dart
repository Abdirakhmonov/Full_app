import 'package:flutter/material.dart';
import '../../viewmodel/cart_viewmodel.dart';
import '../widgets/listview_container.dart';

class FavoriteScreen extends StatefulWidget {
  final Function(int) onItemTapped;
  final int currentIndex;

  FavoriteScreen({required this.onItemTapped, required this.currentIndex, super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Screen", style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w700
        ),),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: CartViewModel.fav.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomListViewBuilderContainer(
              course: CartViewModel.fav[index],
              isViewStylePressed: false,
              isDelete: false,
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.amber,
        onTap: widget.onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.stacked_bar_chart), label: "Statistic"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
