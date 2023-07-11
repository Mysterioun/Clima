import 'package:flutter/material.dart';

class MyTab {
  final String nome;
  final IconData icon;

  const MyTab({required this.nome, required this.icon});
}

enum TabItem { CLIMA, LOCALIZACOES}
