//4:55:28

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/additional_info_Item.dart';
import 'package:weather/secrets.dart';
import 'package:weather/weather_forecast_items.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>> GetCurrentWeather() async {
    try {
      String CityName = 'London';
      final res = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$CityName&APPID=$openWeatheAPIkey'),
      );

      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw 'an unexpected error occured';
      }
      return data;

      //temp = data['list'][0]['main']['temp'];
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: GetCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final data = snapshot.data!;
          final currentWeartherData = data['list'][0];
          final currentTemp = currentWeartherData['main']['temp'];
          final currentSky = currentWeartherData['weather'][0]['main'];
          final currentPressure = currentWeartherData['main']['pressure'];
          final currentWindSpeed = currentWeartherData['wind']['speed'];
          final currentHumidity = currentWeartherData['main']['humidity'];

          final K = currentTemp - 273.15;
          String formattedValue = K.toStringAsFixed(3);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //main card
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                '$formattedValue °C',
                                style: const TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Icon(
                                currentSky == 'Clouds' || currentSky == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 65,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                currentSky,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Hourly Forecast',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                // wheather for cast card
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       for (int i = 0; i < 39; i++)
                //         MyWidgetclass(
                //           time: data['list'][i + 1]['dt'].toString(),
                //           temp: data['list'][i + 1]['main']['temp'].toString(),
                //           icon: data['list'][i + 1]['weather'][0]['main'] ==
                //                       'Clouds' ||
                //                   data['list'][i + 1]['weather'][0]['main'] ==
                //                       'Rain'
                //               ? Icons.cloud
                //               : Icons.sunny,
                //         ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 14,
                    itemBuilder: (context, index) {
                      final MyWidgetclassItems = data['list'][index + 1];
                      final hourlysky =
                          data['list'][index + 1]['weather'][0]['main'];
                      final time = DateTime.parse(MyWidgetclassItems['dt_txt']);
                      return MyWidgetclass(
                        temp: MyWidgetclassItems['main']['temp'].toString(),
                        time: DateFormat.j().format(time),
                        icon: hourlysky == 'Clouds' || hourlysky == 'Rainn'
                            ? Icons.cloud
                            : Icons.sunny,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //additional Information
                const Text(
                  'Additional Information',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfo_items(
                      icon: Icons.water_drop,
                      value: currentHumidity.toString(),
                      label: 'Humdity',
                    ),
                    AdditionalInfo_items(
                      icon: Icons.air,
                      value: currentWindSpeed.toString(),
                      label: 'Wind Speed',
                    ),
                    AdditionalInfo_items(
                      icon: Icons.beach_access,
                      label: 'Pressure',
                      value: currentPressure.toString(),
                    ),
                  ],
                ),
                // Text(
                //   'Developed By: KKR',
                //   style: TextStyle(
                //       fontSize: 24,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.blueAccent),
                // ),
              ],
            ),

            // 6:55
          );
        },
      ),
    );
  }
}
