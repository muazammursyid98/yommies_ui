import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yommie/pages/drinks_page.dart';
import 'package:yommie/pages/history_page.dart';
import 'package:yommie/pages/home_page.dart';
import 'package:yommie/pages/news_page.dart';
import 'package:yommie/pages/rewards_page.dart';

class NavigationBar extends StatefulWidget {
  NavigationBar({Key key}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  PageController _pageController;
  int _page = 0;
  bool _isVisible = true;

  List icons = [
    FontAwesomeIcons.home,
    FontAwesomeIcons.newspaper,
    FontAwesomeIcons.list,
    FontAwesomeIcons.gift,
    FontAwesomeIcons.history,
  ];

  List text = [
    'Home',
    'News',
    'Drinks',
    'Reward',
    'Orders',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  buildTabIcon(int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _pageController.jumpToPage(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 5,
            ),
            Icon(
              icons[index],
              size: 28.0,
              color: _page == index
                  ? Theme.of(context).primaryColor
                  : Colors.black38,
            ),
            SizedBox(
              height: 1,
            ),
            Text(
              text[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10.0,
                color: _page == index
                    ? Theme.of(context).primaryColor
                    : Colors.black,
              ),
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: [
          HomePage(),
          NewsPage(),
          DrinksPage(),
          RewardPage(),
          HistoryPage(),
        ],
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: _isVisible ? 60 : 0.0,
        child: BottomAppBar(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 7),
              buildTabIcon(0),
              buildTabIcon(1),
              buildTabIcon(2),
              buildTabIcon(3),
              buildTabIcon(4),
              SizedBox(width: 7),
            ],
          ),
          color: Colors.white,
          shape: CircularNotchedRectangle(),
        ),
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }
}
