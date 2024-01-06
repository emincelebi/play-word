import 'package:flutter/material.dart';
import 'package:play_word/views/home/buttons_view.dart';
import 'package:play_word/views/home/my_profile.dart';
import 'package:play_word/views/home/star_questions_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: <Widget>[
        const ButtonsView(),
        const StarQuestionView(),
        const MyProfileView(),
      ][currentPageIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 12.0, left: 8, right: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: NavigationBar(
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            onDestinationSelected: (index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            selectedIndex: currentPageIndex,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(icon: Icon(Icons.star), label: 'Star Questions'),
              NavigationDestination(icon: Icon(Icons.person), label: 'My Profile')
            ],
          ),
        ),
      ),
    );
  }
}
