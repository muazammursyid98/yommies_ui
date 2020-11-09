import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yommie/pages/drinks_page.dart';
import 'package:yommie/pages/home_page.dart';
import 'package:yommie/pages/news_page.dart';
import 'package:yommie/pages/rewards_page.dart';
import 'package:yommie/pages/userMenu.dart';
import 'package:yommie/provider/globals.dart';

class NavigationBarDummy extends StatefulWidget {
  final String userId;
  final int page;

  NavigationBarDummy({this.userId, this.page});
  @override
  _NavigationBarDummyState createState() => _NavigationBarDummyState();
}

class _NavigationBarDummyState extends State<NavigationBarDummy> {
  int currentIndex = 0;
  PageController _pageController;

  void onPageChanged(int page) {
    setState(() {
      this.currentIndex = page;
    });
  }

  @override
  void initState() {
    if (widget.page == null) {
      _pageController = PageController();
    } else {
      onPageChanged(widget.page);
      _pageController = PageController(initialPage: widget.page);
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: [
          HomePage(userId: widget.userId),
          NewsPage(),
          DrinksPage(),
          RewardPage(
            userId: widget.userId,
          ),
          UserMenuPage(
            userId: widget.userId,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[500],
        currentIndex: currentIndex,
        onTap: (value) {
          onPageChanged(value);
          _pageController.jumpToPage(value);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.home,
              size: 23.0,
            ),
            title: Text(
              "Home",
              style: TextStyle(fontSize: 10.0),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.newspaper,
              size: 23.0,
            ),
            title: Text(
              "News",
              style: TextStyle(
                fontSize: 10.0,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.list,
              size: 23.0,
            ),
            title: Text(
              "Menu",
              style: TextStyle(fontSize: 10.0),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.gift,
              size: 23.0,
            ),
            title: Text(
              "Reward",
              style: TextStyle(fontSize: 10.0),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.user,
              size: 23.0,
            ),
            title: Text(
              "Me",
              style: TextStyle(fontSize: 10.0),
            ),
          ),
        ],
      ),
    );
  }
}
