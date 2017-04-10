import 'dart:math';
import 'package:genetic_algorithm/src/models/city.dart';

class DistMatrix {
  List<List<double>> matrix;

  //Preprocessing is O(n^2) for a distance matrix:
  //This will allow us to compute our fitness in O(n) time.
  DistMatrix(List<City> cities){
    matrix = new List<List<double>>();
    for(int i=0; i < cities.length; i++){
      List<double> iDistances = new List<double>();
      for(int j=0; j < cities.length; j++){
        double xDist = (cities[j].x - cities[i].x).abs().toDouble();
        double yDist = (cities[j].y - cities[i].y).abs().toDouble();
        double ij_dist = sqrt( pow(xDist,2) + pow(yDist,2));
        iDistances.add(ij_dist);
      }
      matrix.add(iDistances);//Add computed distances from city i to every jth city.
    }
  }

  @override
  String toString(){
    String sMatrix = '\t';
    for(int i=0; i < this.matrix.length; i++){
      sMatrix += '$i\t';
    }
    sMatrix += '\n\t';
    for(int i=0; i < this.matrix.length; i++){
      sMatrix += '-\t';
    }
    sMatrix += '\n';
    for(int i=0; i < this.matrix.length; i++){
      sMatrix += '$i\t';
      for(int j=0; j < this.matrix[i].length; j++){
        sMatrix += '${this.matrix[i][j]}\t';
      }
      sMatrix += '\n';
    }
    return sMatrix;
  }

}
