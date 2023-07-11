import 'package:flutter/material.dart';

import '../../model/tab.dart';
import '../utils/bottom_navigation.dart';
import '../utils/tab_navigator.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  final _navigatorKeys = {
    TabItem.CLIMA: GlobalKey<NavigatorState>(),
    TabItem.LOCALIZACOES: GlobalKey<NavigatorState>(),
  };

  var _currentTab = TabItem.CLIMA;

  void _selectTab(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentTab != TabItem.CLIMA) {
          _selectTab(TabItem.CLIMA);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator(TabItem.CLIMA),
          _buildOffstageNavigator(TabItem.LOCALIZACOES),
        ]),
        bottomNavigationBar: MyBottomNavigation(
          currentTab: _currentTab,
          onSelectTab: _selectTab,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
        selectTabFunction: _selectTab,
      ),
    );
  }
}
