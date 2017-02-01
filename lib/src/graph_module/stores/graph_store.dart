//Dependencies:
import 'package:w_flux/w_flux.dart';
import 'package:w_module/w_module.dart';



//App:
import 'package:genetic_algorithm/src/graph_module/actions/graph_actions.dart';
import 'package:genetic_algorithm/src/graph_module/events/graph_events.dart';
import 'package:genetic_algorithm/src/models/ga/tourMap.dart';
import 'package:genetic_algorithm/src/models/graph_point.dart';
import 'package:genetic_algorithm/src/graph_module/actions/graph_actions.dart';
import 'package:genetic_algorithm/src/models/ga/chromosome.dart';
import 'package:genetic_algorithm/src/models/ga/city.dart';
import 'package:genetic_algorithm/src/models/ga/tourMap.dart';
import 'package:genetic_algorithm/src/models/ga/population.dart';
import 'package:genetic_algorithm/src/models/ga/genetic_algorithm.dart';

class GraphStore extends Store {
  GraphActions _actions;
  GraphEvents _events;
  DispatchKey _dispatchKey;

  TourMap _map;
  List<GraphPoint> _cityPoints;
  Chromosome _solution;

  bool _isSimRunning;
  bool _solutionFound;

  GraphStore(this._actions, this._events, this._dispatchKey){
    this._isSimRunning = false;
    this._solutionFound = false;
    this._cityPoints = [];
    triggerOnAction(_actions.addCity, this._addCity);
    triggerOnAction(_actions.removeCity, this._removeCity);
    triggerOnAction(_actions.startSim, this._setSim);
    triggerOnAction(_actions.runSim, this._runGA);
    triggerOnAction(_actions.completeSim, this._setSolution);


  }

  Chromosome get solution => this._solution;

  List<GraphPoint> get cityPoints => this._cityPoints;

  int get cityCount => this._cityPoints.length;

  bool get isSimRunning => this._isSimRunning;

  bool get solutionFound => this._solutionFound;

  void _setSim(bool flag){
    _isSimRunning = flag;
  }

  void _addCity(GraphPoint city){
    _cityPoints.add(city);
  }

  void _removeCity(int index){
    _cityPoints.removeAt(index);
    for(int i = 0; i < _cityPoints.length; i++){
      _cityPoints[i].name = (i+1);
    }
  }

  void _reset(){
    this._solutionFound = false;
  }

  void _setSolution(bool set){
      this._solutionFound = true;
  }

  void _runGA(GAPayload payload){
    if(_isSimRunning){
      print("Unpacking Payload...");
      //Unpack Payload:
      int popSize = int.parse(payload.population);
      int tourney = int.parse(payload.tournament);
      int genSize = int.parse(payload.generations);
      double mutation = double.parse(payload.mutation);
      print(popSize);
      print(tourney);
      print(genSize);
      print(mutation);
      print("Done!");
      print("Setting up GA...");
      //Setup GA:
      int i = 0;
      for(GraphPoint point in this._cityPoints){
        City city = new City.point(point.x1, point.y1, point.name);
        TourMap.addCity(city);
        i++;
      }
      GeneticAlgorithm ga = new GeneticAlgorithm();
      ga.mutationRate = mutation;
      ga.tournamentSize = tourney;
      ga.elitism = true;
      Population pop = new Population(popSize, true);
      print("Done!");
      print("Running GA sim...");
      //Run GA:
      pop = ga.evolvePopulation(pop);
      for (int i = 0; i < genSize; i++) {
          pop = ga.evolvePopulation(pop);
      }
      Chromosome fittest = pop.getFittest();
      print("Done!");
      print("Generating map...");
      //Set Solution:
      List<GraphPoint> solution = new List<GraphPoint>();
      for(int i=0; i < fittest.tourSize(); i++){
        City city = fittest.getCity(i);
        GraphPoint point;
        if(i < (fittest.tourSize()-1)){
          City cityTo = fittest.getCity(i+1);
          point = new GraphPoint(city.x, city.y, cityTo.x, cityTo.y, fittest.getCity(i).name);
        }else{
          point = new GraphPoint(city.x, city.y,null,null,fittest.getCity(i).name);
        }
        solution.add(point);
      }
      String sol = "";
      for(int i=0; i < solution.length; i++){
        if(i < solution.length-1){
          sol += " ${solution[i].name},";
        }else{
          sol += " ${solution[i].name}";
        }
      }
      print(sol);
      String og = "";
      for(int i=0; i < _cityPoints.length; i++){
        if(i < _cityPoints.length-1){
          og += " ${_cityPoints[i].x1}, ${_cityPoints[i].y1},";
        }else{
          og += " ${_cityPoints[i].x1}, ${_cityPoints[i].y1}";
        }
      }
      print(og);
      _cityPoints = solution;
      _solution = fittest;
      print("Done!");

      //Fire Completion Action:
      _isSimRunning = false;
      _actions.completeSim();

    }
  }
}
