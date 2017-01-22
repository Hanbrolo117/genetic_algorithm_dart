import 'dart:math';
import 'package:genetic_algorithm/src/models/ga/city.dart';
import 'package:genetic_algorithm/src/models/constants.dart';
import 'package:genetic_algorithm/src/models/ga/chromosome.dart';


class Population {

    // Holds population of tours
    List<Chromosome> tours;

    // Construct a population
    Population(int populationSize, bool initialise) {
        tours = new List<Chromosome>(populationSize);
        // If we need to initialise a population of tours do so
        if (initialise) {
            // Loop and create individuals
            for (int i = 0; i < populationSize; i++) {
                Chromosome newChromosome = new Chromosome();
                newChromosome.generateIndividual();
                saveChromosome(i, newChromosome);
            }
        }
    }

    // Saves a tour
    void saveChromosome(int index, Chromosome tour) {
        tours[index] = tour;
    }

    // Gets a tour from population
    Chromosome getChromosome(int index) {
        return tours[index];
    }

    // Gets the best tour in the population
    Chromosome getFittest() {
        Chromosome fittest = tours[0];
        // Loop through individuals to find fittest
        for (int i = 1; i < populationSize(); i++) {
            if (fittest.getFitness() <= getChromosome(i).getFitness()) {
                fittest = getChromosome(i);
            }
        }
        return fittest;
    }

    // Gets population size
    int populationSize() {
        return tours.length;
    }
}
