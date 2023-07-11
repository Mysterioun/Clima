import 'package:flutter/material.dart';

import '../../model/tab.dart';

const Map<TabItem, MyTab> tabs = {
  TabItem.CLIMA: MyTab(nome: "Previsão", icon: Icons.bar_chart_rounded),
  TabItem.LOCALIZACOES: MyTab(nome: "Lozalizações", icon: Icons.location_on),
};

class MyBottomNavigation extends StatelessWidget {
  const MyBottomNavigation(
      {super.key, required this.currentTab, required this.onSelectTab});

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        selectedFontSize: 12,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentTab.index,
        items: [
          _buildItem(TabItem.CLIMA),
          _buildItem(TabItem.LOCALIZACOES),
        ],
        onTap: (index) => onSelectTab(TabItem.values[index]));
  }

  BottomNavigationBarItem _buildItem(TabItem item) {
    return BottomNavigationBarItem(
      icon: Icon(tabs[item]!.icon),
      label: tabs[item]!.nome,
    );
  }
}
