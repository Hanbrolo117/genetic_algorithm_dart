import 'package:genetic_algorithm/src/models/ga/population.dart';
import 'package:genetic_algorithm/src/models/ga/tourMap.dart';
import 'package:genetic_algorithm/src/models/ga/city.dart';
import 'package:genetic_algorithm/src/models/ga/chromosome.dart';
import 'package:genetic_algorithm/src/models/ga/genetic_algorithm.dart';

void main(){

  City city = new City.point(60, 200);
  TourMap.addCity(city);
  City city2 = new City.point(180, 200);
  TourMap.addCity(city2);
  City city3 = new City.point(80, 180);
  TourMap.addCity(city3);
  City city4 = new City.point(140, 180);
  TourMap.addCity(city4);
  City city5 = new City.point(20, 160);
  TourMap.addCity(city5);
  City city6 = new City.point(100, 160);
  TourMap.addCity(city6);
  City city7 = new City.point(200, 160);
  TourMap.addCity(city7);
  City city8 = new City.point(140, 140);
  TourMap.addCity(city8);
  City city9 = new City.point(40, 120);
  TourMap.addCity(city9);
  City city10 = new City.point(100, 120);
  TourMap.addCity(city10);
  City city11 = new City.point(180, 100);
  TourMap.addCity(city11);
  City city12 = new City.point(60, 80);
  TourMap.addCity(city12);
  City city13 = new City.point(120, 80);
  TourMap.addCity(city13);
  City city14 = new City.point(180, 60);
  TourMap.addCity(city14);
  City city15 = new City.point(20, 40);
  TourMap.addCity(city15);
  City city16 = new City.point(100, 40);
  TourMap.addCity(city16);
  City city17 = new City.point(200, 40);
  TourMap.addCity(city17);
  City city18 = new City.point(20, 20);
  TourMap.addCity(city18);
  City city19 = new City.point(60, 20);
  TourMap.addCity(city19);
  City city20 = new City.point(160, 20);
  TourMap.addCity(city20);

  // Initialize population
  GeneticAlgorithm ga = new GeneticAlgorithm();
  ga.mutationRate = 0.015;
  ga.tournamentSize = 5;
  ga.elitism = true;
  Population pop = new Population(50, true);
  print("Initial distance: ${pop.getFittest().getDistance()}");

  // Evolve population for 100 generations
  pop = ga.evolvePopulation(pop);
  for (int i = 0; i < 100; i++) {
      pop = ga.evolvePopulation(pop);
  }

  // Print final results
  print("Finished");
  print("Final distance: ${pop.getFittest().getDistance()}");
  print("Solution:");
  print(pop.getFittest());

}
