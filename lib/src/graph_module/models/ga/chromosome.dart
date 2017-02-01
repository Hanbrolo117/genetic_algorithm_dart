import 'dart:math';
import 'package:genetic_algorithm/src/models/constants.dart';
import 'package:genetic_algorithm/src/models/ga/tourMap.dart';
import 'package:genetic_algorithm/src/models/ga/city.dart';

class Chromosome{

    // Holds our tour of cities
    List<City> _tour = new List<City>();
    // Cache
    double _fitness;
    int _distance;

    // Constructs a blank tour
    Chromosome(){
      _fitness = 0.0;
      _distance = 0;
        for (int i = 0; i < TourMap.numberOfCities(); i++) {
            _tour.add(null);
        }
    }

    List<City> get tour => this._tour;

    // Creates a random individual
    void generateIndividual() {
        // Loop through all our destination cities and add them to our tour
        for (int cityIndex = 0; cityIndex < TourMap.numberOfCities(); cityIndex++) {
          setCity(cityIndex, TourMap.getCity(cityIndex));
        }
        // Randomly reorder the tour
        _tour.shuffle();
    }

    // Gets a city from the tour
    City getCity(int tourPosition) {
        return _tour[tourPosition];
    }

    // Sets a city in a certain position within a tour
    void setCity(int tourPosition, City city) {
        _tour[tourPosition] = city;
        // If the tours been altered we need to reset the fitness and distance
        _fitness = 0.0;
        _distance = 0;
    }

    // Gets the tours fitness
    double getFitness() {
        if (_fitness == 0) {
            _fitness = 1.0/getDistance();
        }
        return _fitness;
    }

    // Gets the total distance of the tour
    int getDistance(){
        if (_distance == 0) {
            int tourDistance = 0;
            // Loop through our tour's cities
            for (int cityIndex=0; cityIndex < tourSize(); cityIndex++) {
                // Get city we're travelling from
                City fromCity = getCity(cityIndex);
                // City we're travelling to
                City destinationCity;
                // Check we're not on our tour's last city, if we are set our
                // tour's final destination city to our starting city
                if(cityIndex+1 < tourSize()){
                    destinationCity = getCity(cityIndex+1);
                }
                else{
                    destinationCity = getCity(0);
                }
                // Get the distance between the two cities
                tourDistance += fromCity.distanceTo(destinationCity).floor();
            }
            _distance = tourDistance;
        }
        return _distance;
    }

    // Get number of cities on our tour
    int tourSize() {
        return tour.length;
    }

    // Check if the tour contains a city
    bool containsCity(City city){
        return tour.contains(city);
    }

    @override
    String toString() {
        String geneString = "|";
        for (int i = 0; i < tourSize(); i++) {
            geneString += "${getCity(i)}|";
        }
        return geneString;
    }
}
