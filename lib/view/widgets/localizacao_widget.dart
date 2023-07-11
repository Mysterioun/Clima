import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../controller/clima_controller.dart';

class LocalizacaoWidget extends StatefulWidget {
  const LocalizacaoWidget({super.key});

  @override
  State<LocalizacaoWidget> createState() => _LocalizacaoWidgetState();
}

class _LocalizacaoWidgetState extends State<LocalizacaoWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ClimaController>(
      builder: (context, ClimaController climaController, child) {
        return Column(
          children: [
            Text(
              climaController.endereco,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 48,
              ),
            ),
            Text(
              DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(climaController.climaAtual.dt! * 1000)),
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        );
      },
    );
  }
}
