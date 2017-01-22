import 'dart:math';
import 'city.dart';
import 'package:genetic_algorithm/src/models/constants.dart';


class TourMap {

    // Holds our cities
    static List<City> destinationCities = new List<City>();

    // Adds a destination city
    static void addCity(City city) {
        destinationCities.add(city);
    }

    // Get a city
    static City getCity(int index){
        return destinationCities[index];
    }

    // Get the number of destination cities
    static int numberOfCities(){
        return destinationCities.length;
    }
}
