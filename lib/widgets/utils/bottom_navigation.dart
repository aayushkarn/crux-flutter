import 'package:crux/widgets/screens/auth/profile.dart';
import 'package:crux/widgets/screens/saved/saved_screen.dart';
import 'package:crux/widgets/screens/sources/nepali_page.dart';
import 'package:crux/widgets/screens/sources/source_main.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentPage = 0;
  List<Widget> pages = const [
    SourceMain(),
    NepaliPage(),
    SavedScreen(key: ValueKey("ss")),
    // MessageTemplate(message: "Settings"),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LazyLoadIndexedStack(index: currentPage, children: pages),
      // bottomNavigationBar: NavigationBar(
      //   destinations: const <Widget>[
      //     NavigationDestination(icon: Icon(Icons.home), label: ''),
      //     NavigationDestination(icon: Icon(Icons.bookmark), label: ''),
      //     NavigationDestination(icon: Icon(Icons.settings), label: ''),
      //   ],
      //   selectedIndex: currentPage,

      //   onDestinationSelected:
      //       (value) => {
      //         setState(() {
      //           currentPage = value;
      //         }),
      //       },
      // ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentPage,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        iconSize: 24,
        enableFeedback: true,
        elevation: 0,
        selectedIconTheme: IconThemeData(size: 30),
        selectedFontSize: 0,
        unselectedFontSize: 0,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmarks_outlined),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
      ),
    );
  }
}
