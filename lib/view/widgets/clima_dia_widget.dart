import 'package:flutter/material.dart';
import 'package:Clima/view/widgets/utils/dia_detalhes_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../controller/clima_controller.dart';

class ClimaDiaWidget extends StatefulWidget {
  const ClimaDiaWidget({Key? key}) : super(key: key);

  @override
  State<ClimaDiaWidget> createState() => _ClimaDiaWidgetState();
}

class _ClimaDiaWidgetState extends State<ClimaDiaWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ClimaController>(
      builder: (context, ClimaController climaController, child) {
        return Column(
          children: [
            const Text(
              'Clima dessa semana',
              style: TextStyle(fontSize: 24),
            ),
            Container(
              height: 400,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).dividerColor,
              ),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return DiaDetalhesWidget(
                    day: DateFormat('dd/MM/yyyy')
                        .format(DateTime.fromMillisecondsSinceEpoch(climaController.climaDia[index].dt! * 1000)),
                    icon: climaController.climaDia[index].weather![0].icon!,
                    desc: climaController.climaDia[index].weather![0].description!,
                    temp: climaController.climaDia[index].temp!,
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
