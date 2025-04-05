import 'package:flutter/material.dart';
import 'package:radio_map/screens/randomRadio/random_radio_screen.dart';
import 'package:radio_map/screens/selectRadio/select_radio_screen.dart';
import 'package:radio_map/screens/tagsRadio/tags_list_radio_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    RandomRadioScreen(),
    SelectRadioScreen(),
    TagsListRadioScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shuffle, color: Colors.blue,),
            label: 'Random',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.radio, color: Colors.blue,),
            label: 'Select' ,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tag, color: Colors.blue),
            label: 'Tags',
          ),
        ],
      ),
    );
  }
}
