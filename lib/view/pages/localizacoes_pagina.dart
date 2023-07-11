import 'package:flutter/material.dart';
import 'package:Clima/controller/cidade_controller.dart';
import 'package:provider/provider.dart';

import '../../controller/clima_controller.dart';
import '../../model/tab.dart';

class LocalizacoesPagina extends StatefulWidget {
  const LocalizacoesPagina({super.key, required this.onTapCityFunction});
  final Function onTapCityFunction;

  @override
  _LocalizacoesPaginaState createState() => _LocalizacoesPaginaState();
}

class _LocalizacoesPaginaState extends State<LocalizacoesPagina> {
  final TextEditingController _textFieldController = TextEditingController();

  void _onTapCityFunction(TabItem tabItem) {
    widget.onTapCityFunction(tabItem);
  }

  Future<void> _displayDialog(CidadeController cidadeController) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar nova cidade'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Digite a nova cidade'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Adicionar'),
              onPressed: () {
                Navigator.of(context).pop();
                cidadeController.adicionarCidadeItem(_textFieldController.text);
                _textFieldController.clear();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CidadeController>(
      create: (_) => CidadeController(),
      child: Consumer2<ClimaController, CidadeController>(
        builder: (context, ClimaController forecastNotifier, CidadeController cidadeController, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Página das Localizações"),
              actions: [
                IconButton(
                  onPressed: () {
                    _displayDialog(cidadeController);
                  },
                  icon: const Icon(Icons.add_rounded),
                )
              ],
            ),
            body: ReorderableListView(
              header: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Material(
                  elevation: 3,
                  child: ListTile(
                    title: const Text('Obter localização atual'),
                    leading: const Icon(Icons.my_location_rounded),
                    onTap: () {
                      forecastNotifier.getLocalizacaoAtual();
                      cidadeController.cidadeSelecionada = null;
                      _onTapCityFunction(TabItem.CLIMA);
                    },
                  ),
                ),
              ),
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              children: <Widget>[
                for (int index = 0; index < cidadeController.cidades.length; index += 1)
                  Padding(
                    key: Key('$index'),
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Material(
                      elevation: 3,
                      child: ListTile(
                        title: Text(cidadeController.cidades[index]),
                        leading: const Icon(Icons.drag_handle_rounded),
                        trailing: IconButton(
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () => cidadeController.handleExcluirCidade(cidadeController.cidades[index]),
                        ),
                        onTap: () async {
                          forecastNotifier.getLocalizacao(nome: cidadeController.cidades[index]);
                          cidadeController.selecionarCidade(index);
                          _onTapCityFunction(TabItem.CLIMA);
                        },
                        selected: cidadeController.cidades[index] == cidadeController.cidadeSelecionada,
                        selectedColor: Theme.of(context).indicatorColor,
                      ),
                    ),
                  ),
              ],
              onReorder: (int oldIndex, int newIndex) {
                cidadeController.reordenarCidades(oldIndex, newIndex);
              },
            ),
          );
        },
      ),
    );
  }
}
