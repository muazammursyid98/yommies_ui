import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yommie/pages/drinks_page.dart';
import 'package:yommie/pages/home_page.dart';
import 'package:yommie/pages/news_page.dart';
import 'package:yommie/pages/rewards_page.dart';
import 'package:yommie/pages/userMenu.dart';
import 'package:yommie/provider/globals.dart' as globals;

class NavigationBar extends StatefulWidget {
  final String userId;
  final int page;
  NavigationBar({this.userId, this.page});

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
    FontAwesomeIcons.user
  ];

  List text = [
    'Home',
    'News',
    'Menu',
    'Reward',
    'Me',
  ];

  @override
  void initState() {
    if (widget.page == null) {
      _pageController = PageController();
      setState(() {
        _page = 0;
      });
    } else {
      setState(() {
        _page = widget.page;
      });

      _pageController = PageController(initialPage: widget.page);
    }
    super.initState();
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
              size: 23.0,
              color: _page == index
                  ? Theme.of(context).primaryColor
                  : Colors.black38,
            ),
            SizedBox(
              height: 5,
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
              height: 5,
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
