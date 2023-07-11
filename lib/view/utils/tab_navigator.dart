import 'package:flutter/material.dart';

import '../../model/tab.dart';
import '../pages/clima_pagina.dart';
import '../pages/localizacoes_pagina.dart';

class TabNavigator extends StatelessWidget {
  const TabNavigator({super.key, required this.navigatorKey, required this.tabItem, required this.selectTabFunction});

  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;
  final Function selectTabFunction;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        Widget currentPage;
        if (tabItem == TabItem.CLIMA) {
          currentPage = const ClimaPagina();
        } else{
          currentPage = LocalizacoesPagina(onTapCityFunction: selectTabFunction);
        };

        return MaterialPageRoute(builder: (context) => currentPage);
      },
    );
  }
}
