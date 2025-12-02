import 'package:flutter/material.dart';
import 'package:game_store_app/data/notifier.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return NavigationBarTheme(
            data: NavigationBarThemeData(
                labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
              (Set<MaterialState> states) =>
                  states.contains(MaterialState.selected)
                      ? const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)
                      : const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
            )),
            child: NavigationBar(
              backgroundColor: Colors.black,
              destinations: [
                NavigationDestination(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: "Home"),
                NavigationDestination(
                    icon: Icon(Icons.games_outlined), label: "Game"),
                NavigationDestination(
                    icon: Icon(Icons.star), label: "Speacial"),
                // NavigationDestination(
                //     icon: Icon(Icons.notifications), label: "Notify"),
                NavigationDestination(
                    icon: Icon(Icons.search), label: "Search"),
              ],
              onDestinationSelected: (int value) {
                selectedPageNotifier.value = value;
              },
              selectedIndex: selectedPage,
            ),
          );
        });
  }
}
