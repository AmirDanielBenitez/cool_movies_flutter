import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:coolmovies/config/theme/app_themes.dart';
import 'package:coolmovies/features/coolmovies/presentation/widgets/movie_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int bottomNavIndex = 0;
  List<TabItem> tabItems = List.of([
    TabItem(
      Icons.movie_outlined,
      "Movies",
      Colors.red,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
      ),
    ),
    TabItem(
      Icons.comment_outlined,
      "Reviews",
      Colors.amber,
      circleStrokeColor: Colors.black,
    ),
    TabItem(
      Icons.account_circle_outlined,
      "Profile",
      backgroundCard,
    ),
  ]);
  late CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController = CircularBottomNavigationController(bottomNavIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            _getBody(bottomNavIndex),
            Align(alignment: Alignment.bottomCenter, child: bottomNav())
          ],
        ),
      ),
    );
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      selectedPos: bottomNavIndex,
      barHeight: 60,
      barBackgroundColor: Colors.white,
      backgroundBoxShadow: const <BoxShadow>[
        BoxShadow(color: Colors.black45, blurRadius: 10.0),
      ],
      animationDuration: const Duration(milliseconds: 300),
      selectedCallback: (int? selectedPos) {
        setState(() {
          bottomNavIndex = selectedPos ?? 0;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return const MovieList();
      case 1:
        return Container();
      case 2:
        return Container();
      default:
        return const MovieList();
    }
  }
}
