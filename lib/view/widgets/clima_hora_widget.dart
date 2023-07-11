import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:Clima/view/widgets/utils/dia_clima_grafico.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../controller/clima_controller.dart';


class ClimaHoraWidget extends StatefulWidget {
  const ClimaHoraWidget({Key? key}) : super(key: key);

  @override
  State<ClimaHoraWidget> createState() => _ClimaHoraWidgetState();
}

class _ClimaHoraWidgetState extends State<ClimaHoraWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ClimaController>(
      builder: (context, climaController, child) {
        return Column(
          children: [
            const Text(
              'Próximas Horas',
              style: TextStyle(fontSize: 24),
            ),
            AspectRatio(
              aspectRatio: 1.1,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 18,
                  left: 12,
                  top: 24,
                  bottom: 12,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                    width: 1200,
                    child: LineChart(DayForecastChart(climaController.climaHora, context)),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
