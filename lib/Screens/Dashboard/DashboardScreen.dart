import 'package:flutter/material.dart';
import 'package:myproject/Screens/Dashboard/Components/BottomNavigation.dart';
import 'package:myproject/Screens/Dashboard/Components/CarouselSlider.dart';
import 'package:myproject/Screens/Dashboard/Components/CustomAppBar.dart';
import 'package:myproject/Screens/Dashboard/Components/SuggestionSection.dart';
import 'package:myproject/Screens/Dashboard/Components/menu_buttons.dart';

import 'package:myproject/provider/favorite_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  int notificationCount = 5;

  @override
  Widget build(BuildContext context) {
    FavoriteProvider.of(context, listen: false);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 164, 243),
      appBar: CustomAppBar(
        userName: 'Jimmy',
        notificationCount: notificationCount,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 10),
              CarouselSliderWidget(),
              SizedBox(height: 40),
              MenuButtons(),
              SizedBox(height: 20),
              SuggestionSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
