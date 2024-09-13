import 'package:dev_boot/models/WeatherData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  bool isLoading = true;
  WeatherData? weatherData;
  double latitude = 26.5131831327021;
  double longitude = 80.23167906958423;

  Future<void> fetchWeatherData(double latitude, double longitude) async {
    final apiKey = '7a240cb8f243e85616798b6b98ca77dc';
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          weatherData = WeatherData.fromJson(data);
        });
        print(weatherData!.temp);
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeatherData(latitude, longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading
          ? CircularProgressIndicator(
              color: Colors.lightGreen,
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Indian Institute of Technology',
                      style: TextStyle(fontSize: 20),
                    ),
                    Icon(Icons.location_pin)
                  ],
                ),
                Text(
                  '${(weatherData!.temp - 273.15).round()}°C',
                  style: TextStyle(fontSize: 55),
                ),
                Row(
                  children: [
                    Image.network(
                        'https://openweathermap.org/img/wn/${weatherData!.weatherIcon}.png'),
                    Text(
                      weatherData!.weatherDescription,
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    8.0,
                    0,
                    0,
                    0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.water_drop),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Humidity: ${weatherData!.humidity}%',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    8.0,
                    0,
                    0,
                    0,
                  ),
                  child: Text(
                    'Feels like: ${(weatherData!.feelsLike - 273.15).round()}°C',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    8.0,
                    0,
                    0,
                    0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.wind_power_rounded),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Wind: ${weatherData!.speed} km/h',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
