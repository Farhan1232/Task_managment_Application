import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../provider/bottomnav_provider.dart';
import '../screens/addpage.dart';
import '../screens/favourite_screens.dart';
import '../screens/graph.dart';
import '../screens/todo_list.dart';


class bottomnavbar extends StatelessWidget {
  static  List<Widget> _widgetOptions = <Widget>[
    TodoListPage(),
    AddPage(),
    FavoriteScreen(),
    ChartScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavProvider>(context);
    
    return Scaffold(
    
      body: _widgetOptions.elementAt(bottomNavProvider.selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.add_circled),
            label: 'Add Task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite,color: Colors.red,),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.graph_circle),
            label: 'Graph',
          ),
        ],
        currentIndex: bottomNavProvider.selectedIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          bottomNavProvider.setIndex(index);
        },
      ),
    );
  }
}
