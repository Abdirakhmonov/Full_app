import 'package:flutter/material.dart';
import '../../viewmodel/cart_viewmodel.dart';
import '../widgets/listview_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class FavoriteScreen extends StatefulWidget {
  final Function(int) onItemTapped;
  final int currentIndex;

  FavoriteScreen(
      {required this.onItemTapped, required this.currentIndex, super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.favoriteScreen,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
        ),
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
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: AppLocalizations.of(context)!.home),
          BottomNavigationBarItem(
              icon: const Icon(Icons.stacked_bar_chart),
              label: AppLocalizations.of(context)!.statistic),
          BottomNavigationBarItem(
              icon: const Icon(Icons.favorite),
              label: AppLocalizations.of(context)!.favorite),
          BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: AppLocalizations.of(context)!.profile),
        ],
      ),
    );
  }
}
