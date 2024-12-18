import 'package:flutter/material.dart';
import 'package:weather_app/helper/weather_helper.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherProvider with ChangeNotifier {
  WeatherHelper helper = WeatherHelper();
  TextEditingController controller = TextEditingController();
  WeatherModel? weatherModel;
  String city = "Surat";
  List<String> searchHistory = [];
  List<WeatherModel> bookmark = [];

  Future<void> getWeather() async {
    weatherModel = await helper.getWeather(city);
    notifyListeners();
  }

  Future<void> setSearch(String term) async {
    if (term.isNotEmpty && !searchHistory.contains(term)) {
      searchHistory.insert(0, term);
      await helper.saveSearchHistory(searchHistory);
      notifyListeners();
    }
  }

  Future<void> removeSearch(String term) async {
    searchHistory.remove(term);
    await helper.saveSearchHistory(searchHistory);
    notifyListeners();
  }

  String? getBgImage(String main) {
    if (weatherModel != null) {
      if (weatherModel!.weather![0].main == "Clouds") {
        return "assets/images/skyy.jpg";
      } else if (weatherModel!.weather![0].main == "Rain") {
        return "assets/images/rain.jpg";
      } else if (weatherModel!.weather![0].main == "Clear") {
        return "assets/images/clear.jpg";
      } else if (weatherModel!.weather![0].main == "Snow") {
        return "assets/images/snow.jpg";
      } else if (weatherModel!.weather![0].main == "Mist") {
        return "assets/images/Mist.jpg";
      } else if (weatherModel!.weather![0].main == "Smoke") {
        return "assets/images/smokee.jpg";
      } else {
        return "assets/images/skyy.jpg";
      }
    }
    notifyListeners();
    return null;
  }

  String? getIcon(String main) {
    if (weatherModel != null) {
      if (weatherModel!.weather![0].main == "Clouds") {
        return "assets/images/cloudy.png";
      } else if (weatherModel!.weather![0].main == "Rain") {
        return "assets/images/rain.png";
      } else if (weatherModel!.weather![0].main == "Clear") {
        return "assets/images/clear.png";
      } else if (weatherModel!.weather![0].main == "Snow") {
        return "assets/images/snow.png";
      } else if (weatherModel!.weather![0].main == "Mist") {
        return "assets/images/mist.png";
      } else if (weatherModel!.weather![0].main == "Smoke") {
        return "assets/images/smoke.png";
      } else {
        return "assets/images/cloudy.png";
      }
    }
    notifyListeners();
    return null;
  }

  String getGif(String main) {
    if (weatherModel?.weather![0].main == "Clouds") {
      return "assets/images/bg.png";
    } else if (weatherModel?.weather![0].main == "Rain") {
      return "assets/gif/rain.gif";
    } else if (weatherModel?.weather![0].main == "Snow") {
      return "assets/images/snoww.png";
    } else {
      return "assets/images/bg.png";
    }
  }
}
