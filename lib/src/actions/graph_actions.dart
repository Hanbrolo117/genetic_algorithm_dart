import 'package:w_flux/w_flux.dart';
import 'package:genetic_algorithm/src/models/graph_point.dart';

class GraphActions extends Action {
  final Action<GraphPoint> addCity = new Action();
  final Action<int> removeCity = new Action();
  final Action<bool> setMap = new Action();

}
