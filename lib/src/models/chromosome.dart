import 'dart:math';
import 'city.dart';
import 'constants.dart';
import 'package:genetic_algorithm/src/models/tourMap.dart';

class Chromosome {

  List<City> _chromosome;
  double _fitness;
  int _distance;
  String _chr;


  Chromosome(String chromosome){
    //Decode chromosome string:
    List genes = chromosome.split(",");
    for(String gene in genes){
      _chromosome.add(TourMap.getCity(int.parse(gene)));
    }
  }

  int getCityDistance(City c1, City c2){
    int xDist = (c1.x - c2.x).abs();
    int yDist = (c1.y - c2.y).abs();
    return sqrt((xDist + yDist)).floor();
  }

  int getTourDistance(){
    int distance = 0;
    if(_chromosome.length > 1){
      for(int gene=1; gene < _chromosome.length; gene++){
        City c1 = _chromosome[gene];
        City c2 = _chromosome[gene-1];
        distance += getCityDistance(c1, c2);
      }
    }
    _distance = distance;
    return _distance;
  }

  City getCity(int geneIndex){
    return _chromosome[geneIndex];
  }

  void setCity(int geneIndex, City city) {
    _chromosome[geneIndex] = city;
    _fitness = 0.0;
    _distance = 0;
  }

  bool hasCity(City city){
    return _chromosome.contains(city);
  }

  int get chromosomeLength => this._chromosome.length;

  double getChrFitness(){
    _fitness = _fitness == 0.0 ? 1/getTourDistance() : _fitness;
    return _fitness;
  }

  void shuffleChr(){
    for(int gene = 0; gene < _chromosome.length; gene++){

    }
  }

  String getChromosome(){
    String chromosome = "";
    for(int gene=0; gene < _chromosome.length; gene++){
      chromosome += ( gene < (_chromosome.length-1) ) ? "${_chromosome[gene].cityKey}," : "${_chromosome[gene].cityKey}";
    }
    return chromosome;
  }



}
