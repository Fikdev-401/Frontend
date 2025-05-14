import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_frontend/core/core.dart';
import 'package:flutter_frontend/ui/pages/add_goal_page.dart';
import 'package:flutter_frontend/ui/pages/add_journal_pages.dart';
import 'package:flutter_frontend/ui/pages/home_page.dart';
import 'package:flutter_frontend/ui/pages/profile_page.dart';
import 'package:flutter_frontend/ui/pages/search_page.dart';
import 'package:flutter_frontend/ui/pages/task_page.dart';
import 'package:flutter_frontend/ui/widget/navitem.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _indexSelected = 0;

  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    TaskPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _indexSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_indexSelected],
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(5),
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.darkGray,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -2),
              blurRadius: 20,
              blurStyle: BlurStyle.outer,
              spreadRadius: 0,
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItem(
                iconPath: AssetsIcon.icons.nav.home.path,
                label: 'Home',
                isActive: _indexSelected == 0,
                onTap: () {
                  _onItemTapped(0);
                }),
            NavItem(
                iconPath: AssetsIcon.icons.nav.search.path,
                label: 'Search',
                isActive: _indexSelected == 1,
                onTap: () {
                  _onItemTapped(1);
                }),
            NavItem(
              iconPath: AssetsIcon.icons.nav.add.path,
              label: 'Add',
              isActive: false,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  backgroundColor: Colors.white,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'What do you want to add?',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          ListTile(
                            leading: Icon(Icons.book, color: Colors.black87),
                            title: Text('Add Journal'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddJournalPage())); // close bottom sheet
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.flag, color: Colors.black87),
                            title: Text('Add Goal'),
                           onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddGoalPage())); // close bottom sheet
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            NavItem(
                iconPath: AssetsIcon.icons.nav.task.path,
                label: 'Goal',
                isActive: _indexSelected == 2,
                onTap: () {
                  _onItemTapped(2);
                }),
            NavItem(
                iconPath: AssetsIcon.icons.nav.profile.path,
                label: 'Profile',
                isActive: _indexSelected == 3,
                onTap: () {
                  _onItemTapped(3);
                }),
          ],
        ),
      ),
    );
  }
}
