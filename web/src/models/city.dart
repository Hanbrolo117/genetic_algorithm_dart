import 'dart:math';
import 'package:genetic_algorithm/models/constants.dart';

class City{
  int _key;
  int _x;
  int _y;

  City(int key ,[int x, int y]){
    Random random = new Random();
    this._x = x ?? random.nextInt(xDim);
    this._y = y ?? random.nextInt(yDim);
  }
  int get key => this._key;
  int get x => this._x;
  int get y => this._y;
}
