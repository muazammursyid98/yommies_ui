import 'package:flutter/material.dart';
import 'package:yommie/pages/history_page.dart';
import 'package:yommie/pages/profile_page.dart';

class UserMenuPage extends StatefulWidget {
  final String userId;
  UserMenuPage({this.userId});
  @override
  _UserMenuPageState createState() => _UserMenuPageState();
}

class _UserMenuPageState extends State<UserMenuPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    _controller = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.only(top: 30),
            color: Theme.of(context).primaryColor,
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor),
                    child: TabBar(
                      labelColor: Colors.black,
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      controller: _controller,
                      tabs: [
                        Tab(
                          text: 'Profile',
                        ),
                        Tab(
                          text: 'History',
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 30)
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 1,
            child: new TabBarView(
              controller: _controller,
              children: <Widget>[
                ProfilePage(
                  userId: widget.userId,
                ),
                HistoryPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
