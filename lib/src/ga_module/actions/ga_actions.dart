import 'package:w_flux/w_flux.dart';


class GaActions extends Action {
  final Action<int> deleteCity = new Action();
  final Action<CityPayload> addCity = new Action();
  final Action<SettingsPayload> setSettings = new Action();
  final Action<Null> setMapToDefault = new Action();
  final Action<Null> setMapToRandom = new Action();
  final Action<Null> runGa = new Action();
}

class CityPayload {
  int x;
  int y;
  CityPayload(this.x, this.y);
}

class SettingsPayload {
  int popSize;
  int numberOfGenerations;
  int mutProb;
  SettingsPayload(this.popSize, this.numberOfGenerations, this.mutProb);
}
