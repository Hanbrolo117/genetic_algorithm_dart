import 'package:w_flux/w_flux.dart';
import 'package:genetic_algorithm/src/models/tourMap.dart';
import 'package:genetic_algorithm/src/models/graph_point.dart';
import 'package:genetic_algorithm/src/actions/graph_actions.dart';
import 'package:genetic_algorithm/src/models/chromosome.dart';

class GraphStore extends Store {

  TourMap _map;
  List<GraphPoint> _cityPoints;
  GraphActions _actions;
  Chromosome _solution;
  bool _isMapSet;

  GraphStore(this._actions){
    this._isMapSet = false;
    triggerOnAction(_actions.addCity, this.addCity);
    triggerOnAction(_actions.removeCity, this.removeCity);
    _cityPoints = [];
  }

  Chromosome get solution => this._solution;

  List<GraphPoint> get cityPoints => this._cityPoints;

  int get cityCount => this._cityPoints.length;

  void addCity(GraphPoint city){
    _cityPoints.add(city);
  }

  void removeCity(int index){
    _cityPoints.removeAt(index);
  }

  void runGA(bool setMap){
    _isMapSet = setMap;
    if(_isMapSet){
      //Run GA
    }else{
      this._cityPoints = [];
      this._solution = null;
    }
  }
}
