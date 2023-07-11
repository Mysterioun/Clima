import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/clima_controller.dart';
import '../tema/theme_notifier.dart';
import '../widgets/clima_atual_widget.dart';
import '../widgets/clima_hora_widget.dart';
import '../widgets/localizacao_widget.dart';
import '../widgets/clima_dia_widget.dart';

class ClimaPagina extends StatefulWidget {
  const ClimaPagina({Key? key});

  @override
  State<ClimaPagina> createState() => _ClimaPaginaState();
}

class _ClimaPaginaState extends State<ClimaPagina> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ClimaController>(
      builder: (context, ClimaController climaController, child) {
        final themeNotifier = Provider.of<ThemeNotifier>(context);
        final isDarkMode = themeNotifier.isDarkMode;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Página de Previsão"),
            actions: [
              IconButton(
                tooltip: 'Alterar Modo Noturno',
                onPressed: () {
                  themeNotifier.toggleDarkMode(); // Alterna o modo noturno
                },
                icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nights_stay), // Ícone do modo noturno ou modo claro
              ),
              IconButton(
                tooltip: 'Obter localização atual',
                onPressed: () {
                  climaController.getLocalizacaoAtual();
                },
                icon: const Icon(Icons.my_location_rounded),
              ),
            ],
          ),
          body: climaController.isLoading
              ? Container(
            padding: const EdgeInsets.all(4.0),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
              : ListView(
            padding: const EdgeInsets.all(8.0),
            children: const [
              LocalizacaoWidget(),
              Divider(),
              ClimaAtualWidget(),
              Divider(),
              ClimaHoraWidget(),
              Divider(),
              ClimaDiaWidget(),
            ],
          ),
        );
      },
    );
  }
}
