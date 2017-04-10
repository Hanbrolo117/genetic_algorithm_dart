import 'dart:math';
import 'city.dart';
import 'individual.dart';
import 'dist_matrix.dart';

class Population {
  DistMatrix dMatrix;
  List<Individual> pop;
  Random randNumGenerator;

  Population(List<City> cities, int popSize){
    this.randNumGenerator = new Random();


    //O(n^2): Build the distance matrix for fitness calculation
    this.dMatrix = new DistMatrix(cities);

    //O(nm): Randomly generate population. ( Worse case O(n^2) )
    this.pop = new List<Individual>();
    for(int i=0; i < popSize; i++){

      //Create and encode chromosome:
      List<int> chromosome = new List<int>();
      for(int j=0; j < cities.length; j++){
        chromosome.add(cities[j].name);
      }
      //Create randomize Chromosome Encoding:
      chromosome.shuffle();
      //Add to population:
      pop.add( new Individual(chromosome));
    }

  }

  //Via Tournament Selection O(n^(3/2))
  Individual parentSelection(){
    //Setup O(1):
    int tourneySize = sqrt(this.pop.length).floor();
    Individual mostFit = null;

    //Pick a random gene point and calculate it's fitness O(n):
    int genePoint = this.randNumGenerator.nextInt(tourneySize);
    mostFit = this.pop[genePoint];
    fitnessOf(mostFit);

    //Run the Tournament O(n^(3/2)):
    for(int i=0; i < tourneySize; i++){
      if(fitnessOf(pop[i]) < mostFit.fitness){
        mostFit = pop[i];
      }
    }

    //Return selected Parent O(1):
    return mostFit;
  }

  //Via Tournament Selection O(n^(3/2))
  Individual parentRemovalSelection(){
    //Setup O(1):
    int tourneySize = sqrt(this.pop.length).floor();
    Individual mostFit = null;

    //Pick a random gene point and calculate it's fitness O(n):
    int genePoint = this.randNumGenerator.nextInt(tourneySize);
    mostFit = this.pop[genePoint];
    fitnessOf(mostFit);

    //Run the Tournament O(n^(3/2)):
    for(int i=0; i < tourneySize; i++){
      if(fitnessOf(pop[i]) > mostFit.fitness){
        mostFit = pop[i];
      }
    }

    //Return selected Parent O(1):
    return mostFit;
  }

  //Age Based, O(n)
  void survivorSelectionAB(){
    //O(n)
    for(int i=0; i < this.pop.length; i++){
      this.pop[i].age++;
    }
    //O(1)
    List<Individual> oldest = [this.pop[0], this.pop[1]];
    //O(n)
    for(int i=0; i < this.pop.length; i++){
      int curLifeSpan = this.pop[i].age;
      if((curLifeSpan > oldest[0].age) && (curLifeSpan > oldest[1].age)){
        if(oldest[0].age > oldest[1].age){
          oldest[0] = this.pop[i];
        }else{
          oldest[1] = this.pop[i];
        }
      }
      if((curLifeSpan > oldest[0].age) && (curLifeSpan < oldest[1].age)){
        oldest[0] = this.pop[i];
      }
      if((curLifeSpan < oldest[0].age) && (curLifeSpan > oldest[1].age)){
        oldest[1] = this.pop[i];
      }
      this.pop.remove(oldest[0]);
      this.pop.remove(oldest[1]);
    }

  }

  void survivorSelectionFB(){
    Individual remove1 = parentRemovalSelection();
    Individual remove2 = parentRemovalSelection();
    this.pop.remove(remove1);
    this.pop.remove(remove2);
  }

  //Calculate fitness of individual O(n):
  double fitnessOf(Individual individual){
    double dist = 0.0;
    for(int i = 0; i < (individual.chromosome.length-1); i++){
      dist += dMatrix.matrix[individual.chromosome[i]][individual.chromosome[i+1]];
    }
    // print(dist);
    individual.fitness = dist;
    return individual.fitness;
  }

  Individual getFittest(){
    Individual fittest = this.pop[0];
    fitnessOf(fittest);
    for(int i=0; i < this.pop.length; i++){
      fitnessOf(this.pop[i]);
      fittest = (this.pop[i].fitness < fittest.fitness) ? this.pop[i] : fittest;
    }
    return fittest;
  }

  @override
  String toString(){
    String individual = '';
    for(int i=0; i < this.pop.length; i++){
      individual += 'Name: ${this.pop[i].name}\n';
      individual += 'Age: ${this.pop[i].age}\n';
      individual += 'Chromosome: ${this.pop[i].chromosome.toString()}\n';
      individual += 'Fitness: ${fitnessOf(this.pop[i])}\n';
    }
    return individual;
  }
}
