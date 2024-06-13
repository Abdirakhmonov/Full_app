import 'package:flutter/material.dart';

import '../widgets/drawer_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  final Function(int) onItemTapped;
  final int currentIndex;
  ProfileScreen(
      {super.key, required this.onItemTapped, required this.currentIndex});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List infos = ["Abdirakhmanov", "Akromjon", "+998991234567"];

  TextEditingController surnameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  void saveInfo() {
    if (surnameController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        numberController.text.isNotEmpty) {
      infos[0] = surnameController.text;
      infos[1] = nameController.text;
      infos[2] = numberController.text;
      setState(() {});
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(
        title:  Text(
          AppLocalizations.of(context)!.profileScreen,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.amber, width: 5)),
                child: Image.asset(
                  "assets/images/profile.png",
                  height: 200,
                  width: 200,
                )),
            const SizedBox(
              height: 20,
            ),
             Text(
                AppLocalizations.of(context)!.aboutMe,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
              )
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 170,
              child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) {
                    List infos2 = [AppLocalizations.of(context)!.surname, AppLocalizations.of(context)!.name, AppLocalizations.of(context)!.phone];

                    return Text(
                      "${infos2[index]}   ${infos[index]}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 20,
                  ),
                  itemCount: infos.length),
            ),
            const SizedBox(
              height: 80,
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: (context),
                    builder: (context) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: surnameController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  label: const Text("Enter surname")),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  label: const Text("Enter name")),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: numberController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  label: const Text("Enter phone number")),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                onPressed: saveInfo, child: const Text("Save"))
                          ],
                        ),
                      );
                    });
              },
              child:  Text(
                AppLocalizations.of(context)!.editProfile,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.amber,
        onTap: widget.onItemTapped,
        items:  [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: AppLocalizations.of(context)!.home),
          BottomNavigationBarItem(
              icon: Icon(Icons.stacked_bar_chart), label: AppLocalizations.of(context)!.statistic),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label:AppLocalizations.of(context)!.favorite),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: AppLocalizations.of(context)!.profile),
        ],
      ),
    );
  }
}