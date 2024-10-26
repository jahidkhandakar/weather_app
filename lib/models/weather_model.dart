class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final DateTime? sunrise;
  final DateTime? sunset;
  final double maxTemp;
  final double minTemp;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.sunrise,
    required this.sunset,
    required this.maxTemp,
    required this.minTemp,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],

      sunrise: DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000),
      sunset: DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000),
      maxTemp: json['main']['temp_max'].toDouble() ?? 0.0,
      minTemp: json['main']['temp_min'].toDouble() ?? 0.0,
    );
  }
}
