import 'dart:math';
import 'city.dart';
import 'constants.dart';

class TourMap {

  static List<City> _map;

  static void addCity(City city){
    _map.add(city);
  }

  static City getCity(int index) => _map[index];

  static int get tourLength => _map.length;


}
