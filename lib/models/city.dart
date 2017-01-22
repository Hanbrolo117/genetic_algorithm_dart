import 'dart:math';
import 'package:genetic_algorithm/models/constants.dart';
class City{
  int _cityKey;
  int _x;
  int _y;

  City(this._cityKey, [int x, int y]){
    Random random = new Random();
    this._x = x ?? random.nextInt(xDim);
    this._y = y ?? random.nextInt(yDim);

  }
  int get cityKey => this._cityKey;
  int get x => this._x;
  int get y => this._y;
}
