import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/additional_infor.dart';
import 'package:weather_app/hourly_forecast_item.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secret.dart';

class WeatherScreen extends StatefulWidget {
 
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
   

   
  Future<Map<String, dynamic>> getCurrentWeather() async  {

    try{
    String cityName='London';

final res = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey',
),
);

final data = jsonDecode(res.body);
 if (data['cod'] != '200'){
  throw 'An Expected Error occured';
 }
return data;
// (data['list'][0]['main']['temp']);

 
    } catch (e) {
      throw e.toString();
    }
  }
  
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
      body:FutureBuilder(
        future:getCurrentWeather(),
        builder: (context,snapshot) {
          
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator.adaptive()) ;
          }
          if (snapshot.hasError){
            return Text(snapshot.error.toString());
          }

          final data = snapshot.data!;
          final currentweatherData =data['list'];
          final currentTemp = currentweatherData [0]['main']['temp'];
          // final currentSky = currentweatherData ['weather'][0]['main'];
          final currentSky = currentweatherData[0]['weather'][0]['main'];
          final currentPressure = currentweatherData[0]['main']['pressure'];
          final currentwindSpeed = currentweatherData[0]['wind']['speed'];
          final currentHumidity = currentweatherData[0]['main']['humidity'];

          return Padding( 
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
                      child:  Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              '$currentTemp K',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                             Icon(
                              currentSky == "Clouds" || currentSky == 'Rain' ? 
                              Icons.cloud:
                              Icons.sunny, size: 64),
                            const SizedBox(height: 16),
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
        
              const SizedBox(height: 20),
        
              const Text(
                "Weather Forecast",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
           
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for(int i=0; i<5 ; i++)
                       HourlyForecastItem(
                        time:data['list'][i + 1]['dt'].toString(),
                        icon: data['list'][i + 1]['weather'][0]['main'] == 'Clouds' || 
                        data['list'][i + 1]['weather'][0]['main'] == 'Rain' ? 
                        Icons.cloud: Icons.sunny,
                        temperature:data['list'][i + 1]['main']['temp'].toString(),
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
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AdditionalInforItem(
                    icon: Icons.water_drop,
                    label: 'Humidity',
                    value: currentHumidity.toString(),
                  ),
                  AdditionalInforItem(
                     icon: Icons.air,
                    label: 'Wind Spead',
                    value: currentwindSpeed.toString(),
                  ),
                  AdditionalInforItem(
                     icon: Icons.beach_access,
                    label: 'Pressure',
                    value: currentPressure.toString(),
                  ),
                ],
               )
        
        
              
            ],
          ),
        );
        },
      ),
    );

  }
}


