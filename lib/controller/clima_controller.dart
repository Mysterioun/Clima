import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:Clima/model/weather/hourly_weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../model/weather/current_weather.dart';
import '../model/weather/daily_weather.dart';
import 'utils/api_service.dart';

class ClimaController extends ChangeNotifier {
  late List<double> coordenadas;
  late String endereco;
  bool isLoading = true;

  final climaService = ApiService();
  late CurrentWeather climaAtual;
  late List<HourlyWeather> climaHora;
  late List<DailyWeather> climaDia;

  ClimaAtualController() {
    getLocalizacaoAtual();
  }

  getLocalizacaoAtual() async {
    isLoading = true;
    notifyListeners();

    Position pos = await _determinaPosicao();
    coordenadas = [pos.latitude, pos.longitude];

    await getEndereco(latitude: coordenadas[0], longitude: coordenadas[1]);

    getDadosClima();
  }

  getLocalizacao({required String nome}) async {
    isLoading = true;
    notifyListeners();

    endereco = nome;
    List<Location> localizacao = await locationFromAddress(nome);
    Location location = localizacao[0];
    coordenadas = [location.latitude, location.longitude];

    getDadosClima();
  }

  getEndereco({required double latitude, required double longitude}) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      latitude,
      longitude,
    );
    Placemark place = placemarks[0];
    endereco = 'Santa Maria';
  }

  Future<Position> _determinaPosicao() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Permissão de localização desabilitada');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permissão de localização negada');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Permissão de localização negada para sempre');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  getDadosClima() async {
    Response result;
    result = await climaService.request(coordenadas[0], coordenadas[1]);

    climaAtual = CurrentWeather.fromJson(result.data['current']);
    climaHora = List<HourlyWeather>.from(result.data['hourly'].map((e) => HourlyWeather.fromJson(e)));
    climaDia = List<DailyWeather>.from(result.data['daily'].map((e) => DailyWeather.fromJson(e)));

    isLoading = false;
    notifyListeners();
  }
}
