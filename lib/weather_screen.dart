import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/additional_infor.dart';
import 'package:weather_app/hourly_forecast_item.dart';

class WeatherScreen extends StatelessWidget {
 
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main card
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
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            "300K",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Icon(Icons.cloud, size: 64),
                          Text(
                            "Rain",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Weather Forecast",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
         
            const SizedBox(height: 12),
           const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  
                     HourlyForecastItem(
                      time:"00:12",
                      icon: Icons.cloud,
                      temperature: "300",
                     ),
                     HourlyForecastItem(
                      time:"01:00",
                      icon: Icons.sunny,
                      temperature: "303.12",
                     ),
                     HourlyForecastItem(
                      time:"12:12",
                      icon: Icons.cloud,
                      temperature: "310.34",
                     ),
                     HourlyForecastItem(
                      time:"00:00",
                      icon: Icons.cloud,
                      temperature: "310.90",
                     ),
                     HourlyForecastItem(
                      time:"30:12",
                      icon: Icons.sunny,
                      temperature: "300.9",
                     ),
                ],
              ),
            ),

            // Weather forecast cards
           

            const SizedBox(height: 16),

            // Additional information
           const Text(
              "Addition Information",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
             const SizedBox(height: 8),
            const  Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AdditionalInforItem(
                  icon: Icons.water_drop,
                  label: 'Humidity',
                  value: '91',
                ),
                AdditionalInforItem(
                   icon: Icons.air,
                  label: 'Wind Spead',
                  value: '3.4',
                ),
                AdditionalInforItem(
                   icon: Icons.beach_access,
                  label: 'Pressure',
                  value: '1000',
                ),
              ],
             )


            
          ],
        ),
      ),
    );
  }
}


