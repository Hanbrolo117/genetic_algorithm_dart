//Dependencies:
import 'dart:math';
import 'package:w_flux/w_flux.dart';
import 'package:w_module/w_module.dart';

import 'package:genetic_algorithm/src/ga_module/actions/ga_actions.dart';
import 'package:genetic_algorithm/src/models/city.dart';
import 'package:genetic_algorithm/src/models/individual.dart';
import 'package:genetic_algorithm/src/models/ga.dart';

class GaStore extends Store {
  Random randNumGenerator;
  GaActions _actions;
  bool isDone;

  //GA variables:
  List<City> _map;
  List<City> get map => _map;
  int _populationSize;
  int get popSize => _populationSize;
  int _numberOfGenerations;
  int get generations => _numberOfGenerations;
  int _mutationProbability;
  int get mutationProb => _mutationProbability;

  //GA Output Variables:
  Individual _genOneFittest;
  Individual get genOneFittest => _genOneFittest;
  Individual _genXFittest;
  Individual get genXFittest => _genXFittest;


  GaStore(this._actions){
    //Initialize Variables:
    randNumGenerator = new Random();
    _map = new List<City>();
    isDone = false;
    //Set listeners:
    triggerOnAction(_actions.addCity, _addCityToList);
    triggerOnAction(_actions.deleteCity, _deleteCityFromList);
    triggerOnAction(_actions.setSettings, _updateGASettings);
    triggerOnAction(_actions.setMapToDefault, _genDefaultMap);
    triggerOnAction(_actions.setMapToRandom, _genRandomMap);
    triggerOnAction(_actions.runGa, _executeGA);
  }

  //O(1)
  _addCityToList(CityPayload payload){
    _map.add(new City(_map.length, payload.x, payload.y));
  }

  //O(n)
  _deleteCityFromList(int cityIndex){
    //remove City:
    _map.removeAt(cityIndex);
    //Update City Names:
    for(int i=0; i < _map.length; i++){
      _map[i].name = i;
    }
  }

  _updateGASettings(SettingsPayload payload){
    _populationSize = payload.popSize;
    _numberOfGenerations = payload.numberOfGenerations;
    _mutationProbability = payload.mutProb;
  }
  _executeGA(_){
    this._populationSize = (this._populationSize == null) ? 100 : this._populationSize;
    this._numberOfGenerations = (this._numberOfGenerations == null) ? 10000 : this._numberOfGenerations;
    this._mutationProbability = (this._mutationProbability == null) ? 2 : this._mutationProbability;
    print('Pop: $_populationSize');
    print('Gen: $_numberOfGenerations');
    print('Mut: $_mutationProbability');
    print(_mutationProbability.runtimeType.toString());
    print(_numberOfGenerations.runtimeType.toString());
    print(_populationSize.runtimeType.toString());
    double mut = (_mutationProbability/100);
    print('Mut-in: $mut');
    GA ga = (_mutationProbability == null) ?
      new GA(_map, _populationSize, _numberOfGenerations) :
      new GA(_map, _populationSize, _numberOfGenerations, mutation: (_mutationProbability/100));
    _genOneFittest = ga.population_pool.getFittest();
    ga.ga_tsp();
    _genXFittest = ga.population_pool.getFittest();
  }


  //Generates a map of 1 to 100 randomly positioned cities
  //on a 500x500 plane.
  _genRandomMap(_){
    _map = new List<City>();
    int numOfCities = randNumGenerator.nextInt(100)+1;
    for(int i=0; i < numOfCities; i++){
      _map.add(new City(i, randNumGenerator.nextInt(501), this.randNumGenerator.nextInt(501)));
    }
  }

  //Generates a default map on a 500x500 plane.
  _genDefaultMap(_){
    _map = new List<City>();
    _map.add(new City( 0, 450, 6));
    _map.add(new City( 1, 38, 71));
    _map.add(new City( 2, 485, 291));
    _map.add(new City( 3, 81, 443));
    _map.add(new City( 4, 274, 136));
    _map.add(new City( 5, 194, 290));
    _map.add(new City( 6, 103, 273));
    _map.add(new City( 7, 26, 186));
    _map.add(new City( 8, 178, 438));
    _map.add(new City( 9, 260, 181));
    _map.add(new City( 10, 273, 34));
    _map.add(new City( 11, 116, 492));
    _map.add(new City( 12, 82, 49));
    _map.add(new City( 13, 464, 371));
    _map.add(new City( 14, 109, 34));
    _map.add(new City( 15, 152, 295));
    _map.add(new City( 16, 230, 391));
    _map.add(new City( 17, 33, 374));
    _map.add(new City( 18, 297, 433));
    _map.add(new City( 19, 446, 373));
    _map.add(new City( 20, 496, 426));
    _map.add(new City( 21, 165, 392));
    _map.add(new City( 22, 164, 328));
    _map.add(new City( 23, 60, 434));
    _map.add(new City( 24, 134, 77));
    _map.add(new City( 25, 361, 315));
    _map.add(new City( 26, 93, 267));
    _map.add(new City( 27, 291, 401));
    _map.add(new City( 28, 432, 442));
    _map.add(new City( 29, 497, 436));
    _map.add(new City( 30, 104, 102));
    _map.add(new City( 31, 53, 495));
    _map.add(new City( 32, 149, 462));
    _map.add(new City( 33, 292, 245));
    _map.add(new City( 34, 425, 395));
    _map.add(new City( 35, 428, 105));
    _map.add(new City( 36, 435, 331));
    _map.add(new City( 37, 365, 217));
    _map.add(new City( 38, 126, 94));
    _map.add(new City( 39, 495, 64));
    _map.add(new City(40, 377, 36));
    _map.add(new City(41, 138, 26));
    _map.add(new City(42, 34, 431));
    _map.add(new City(43, 53, 194));
    _map.add(new City(44, 442, 95));
    _map.add(new City(45, 162, 18));
    _map.add(new City(46, 49, 109));
    _map.add(new City(47, 229, 23));
    _map.add(new City(48, 192, 19));
    _map.add(new City( 49, 435, 122));
  }

}
