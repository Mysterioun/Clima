import 'package:flutter/material.dart';

import '../model/cidade_preferencias.dart';

class CidadeController extends ChangeNotifier {
  List<String> cidades = ['Santa Maria'];
  String? cidadeSelecionada;
  late CidadePreferencia _preferencias;

  CidadeController() {
    _preferencias = CidadePreferencia();
    getPreferencias();
  }

  getPreferencias() async {
    cidades = await _preferencias.getCidades();
    notifyListeners();
  }

  void selecionarCidade(int index) {
    cidadeSelecionada = cidades[index];
    notifyListeners();
  }

  void adicionarCidadeItem(String city) {
    cidades.add(city);
    _preferencias.setCidades(cidades);
    notifyListeners();
  }

  void handleExcluirCidade(String city) {
    cidades.remove(city);
    _preferencias.setCidades(cidades);
    if (cidadeSelecionada == city) {
      cidadeSelecionada = null;
    }
    notifyListeners();
  }

  void reordenarCidades(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final String item = cidades.removeAt(oldIndex);
    cidades.insert(newIndex, item);
    _preferencias.setCidades(cidades);
    notifyListeners();
  }
}
