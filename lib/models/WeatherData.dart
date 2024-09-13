class WeatherData {
  final double temp;
  final double feelsLike;
  final int humidity;
  final double speed;
  final String weatherDescription;
  final String weatherIcon;

  WeatherData({
    required this.temp,
    required this.feelsLike,
    required this.speed,
    required this.humidity,
    required this.weatherDescription,
    required this.weatherIcon,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temp: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      speed: json['wind']['speed'],
      humidity: json['main']['humidity'],
      weatherDescription: json['weather'][0]['description'],
      weatherIcon: json['weather'][0]['icon'],
    );
  }
}
