import 'dart:math';
import 'package:genetic_algorithm/src/models/ga/population.dart';
import 'package:genetic_algorithm/src/models/ga/tourMap.dart';
import 'package:genetic_algorithm/src/models/ga/city.dart';
import 'package:genetic_algorithm/src/models/ga/chromosome.dart';


class GeneticAlgorithm {

    /* GA parameters */
    double mutationRate;
    int tournamentSize;
    bool elitism;

    // Evolves a population over one generation
    Population evolvePopulation(Population pop) {
        Population newPopulation = new Population(pop.populationSize(), false);

        // Keep our best individual if elitism is enabled
        int elitismOffset = 0;
        if (elitism) {
            newPopulation.saveChromosome(0, pop.getFittest());
            elitismOffset = 1;
        }

        // Crossover population
        // Loop over the new population's size and create individuals from
        // Current population
        for (int i = elitismOffset; i < newPopulation.populationSize(); i++) {
            // Select parents
            Chromosome parent1 = tournamentSelection(pop);
            Chromosome parent2 = tournamentSelection(pop);
            // Crossover parents
            Chromosome child = crossover(parent1, parent2);
            // Add child to new population
            newPopulation.saveChromosome(i, child);
        }

        // Mutate the new population a bit to add some new genetic material
        for (int i = elitismOffset; i < newPopulation.populationSize(); i++) {
            mutate(newPopulation.getChromosome(i));
        }

        return newPopulation;
    }

    // Applies crossover to a set of parents and creates offspring
    static Chromosome crossover(Chromosome parent1, Chromosome parent2) {
        // Create new child tour
        Random rand = new Random();
        Chromosome child = new Chromosome();

        // Get start and end sub tour positions for parent1's tour
        int startPos = rand.nextInt(parent1.tourSize());
        int endPos = rand.nextInt(parent2.tourSize());

        // Loop and add the sub tour from parent1 to our child
        for (int i = 0; i < child.tourSize(); i++) {
            // If our start position is less than the end position
            if (startPos < endPos && i > startPos && i < endPos) {
                child.setCity(i, parent1.getCity(i));
            } // If our start position is larger
            else if (startPos > endPos) {
                if (!(i < startPos && i > endPos)) {
                    child.setCity(i, parent1.getCity(i));
                }
            }
        }

        // Loop through parent2's city tour
        for (int i = 0; i < parent2.tourSize(); i++) {
            // If child doesn't have the city add it
            if (!child.containsCity(parent2.getCity(i))) {
                // Loop to find a spare position in the child's tour
                for (int ii = 0; ii < child.tourSize(); ii++) {
                    // Spare position found, add city
                    if (child.getCity(ii) == null) {
                        child.setCity(ii, parent2.getCity(i));
                        break;
                    }
                }
            }
        }
        return child;
    }

    // Mutate a tour using swap mutation
    void mutate(Chromosome tour) {
      Random rand = new Random();
        // Loop through tour cities
        for(int tourPos1=0; tourPos1 < tour.tourSize(); tourPos1++){
            // Apply mutation rate
            if(rand.nextDouble() < mutationRate){
                // Get a second random position in the tour
                int tourPos2 = rand.nextInt(tour.tourSize());

                // Get the cities at target position in tour
                City city1 = tour.getCity(tourPos1);
                City city2 = tour.getCity(tourPos2);

                // Swap them around
                tour.setCity(tourPos2, city1);
                tour.setCity(tourPos1, city2);
            }
        }
    }

    // Selects candidate tour for crossover
    Chromosome tournamentSelection(Population pop) {
        Random rand = new Random();
        // Create a tournament population
        Population tournament = new Population(tournamentSize, false);
        // For each place in the tournament get a random candidate tour and
        // add it
        for (int i = 0; i < tournamentSize; i++) {
            int randomId = rand.nextInt(pop.populationSize());
            tournament.saveChromosome(i, pop.getChromosome(randomId));
        }
        // Get the fittest tour
        Chromosome fittest = tournament.getFittest();
        return fittest;
    }
}
