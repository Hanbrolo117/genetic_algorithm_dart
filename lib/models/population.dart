import 'dart:math';
import 'package:genetic_algorithm/models/city.dart';
import 'package:genetic_algorithm/models/constants.dart';
import 'package:genetic_algorithm/models/chromosome.dart';
class Population {

  List<Chromosome> _population;

  ///Problem Set-up function:
  List<String> genRandomPopulation([int popSize]){
    Random rand = new Random();
    popSize = popSize ?? rand.nextInt(randMaxPop);
    print(this._population.toString());
    for(int i=0; i < rand.nextInt(this._population.length); i++){
    }
  }

}
