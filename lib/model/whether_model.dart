class Weather {
  final String cityname;
  final double temprature;
  final String condition;

  Weather(
      {required this.cityname, required this.temprature, required this.condition});

  factory Weather.fromJson(Map<String, dynamic>json){
    return Weather(cityname: json["name"],
        temprature: json["main"]["temp"].toDouble(),
        condition: json["weather"][0]["main"]);
  }
}