import 'package:w_flux/w_flux.dart';
import 'package:genetic_algorithm/src/models/graph_point.dart';

class GraphActions extends Action {
  final Action<GraphPoint> addCity = new Action();
  final Action<int> removeCity = new Action();
  final Action<bool> setMap = new Action();

  final Action<bool> startSim = new Action();
  final Action<GAPayload> runSim = new Action();
  final Action<bool> completeSim = new Action();
  final Action<bool> reset= new Action();

}

class GAPayload {
  String _mutation, _population, _tournament, _generations;
  GAPayload(this._mutation, this._population, this._tournament, this._generations);
  String get mutation => this._mutation;
  String get population => this._population;
  String get tournament => this._tournament;
  String get generations => this._generations;
}
