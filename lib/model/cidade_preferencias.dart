import 'package:shared_preferences/shared_preferences.dart';

class CidadePreferencia {
  static const cidadesPreferenciasKey = "Cidades";

  setCidades(List<String> list) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList(cidadesPreferenciasKey, list);
  }

  Future<List<String>> getCidades() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList(cidadesPreferenciasKey) ?? [];
  }
}
