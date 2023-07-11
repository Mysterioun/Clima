import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/clima_controller.dart';

class ClimaAtualWidget extends StatefulWidget {
  const ClimaAtualWidget({super.key});

  @override
  State<ClimaAtualWidget> createState() => _ClimaAtualWidgetState();
}

class _ClimaAtualWidgetState extends State<ClimaAtualWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ClimaController>(
      builder: (context, ClimaController climaController, child) {
        return Column(
          children: [
            const Text(
              'Agora',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  'assets/weather/${climaController.climaAtual.weather![0].icon}.png',
                  width: 80,
                  height: 80,
                ),
                Container(
                  height: 60,
                  width: 1,
                  color: Theme.of(context).dividerColor,
                ),
                Row(
                  children: [
                    Text(
                      '${climaController.climaAtual.temp}°',
                      style: const TextStyle(
                        fontSize: 60,
                      ),
                    ),
                    Text(
                      '${climaController.climaAtual.weather![0].description}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset(
                        'assets/icons/windspeed.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('${climaController.climaAtual.windSpeed}km/h'),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset(
                        'assets/icons/clouds.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('${climaController.climaAtual.clouds}%'),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset(
                        'assets/icons/humidity.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('${climaController.climaAtual.humidity}%'),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
