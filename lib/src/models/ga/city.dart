import 'dart:math';
import 'package:genetic_algorithm/src/models/constants.dart';

class City {
    int _x;
    int _y;

    // Constructs a randomly placed city
    City() {
        Random rand = new Random();
        this._x = rand.nextInt(200);
        this._y = rand.nextInt(200);
    }

    // Constructs a city at chosen x, y location
    City.point(int x, int y){
        this._x = x;
        this._y = y;
    }

    // Gets city's x coordinate
    int get x => this._x;

    // Gets city's y coordinate
    int get y => this._y;

    // Gets the distance to given city
    double distanceTo(City city){
        int xDistance = (x - city.x).abs();
        int yDistance = (y - city.y).abs();
        double distance = sqrt( (xDistance*xDistance) + (yDistance*yDistance) );
        return distance;
    }

    @override
    String toString(){
        return "$x, $y";
    }
}
