import 'dart:math';
import 'population.dart';
import 'individual.dart';
import 'city.dart';


enum Survival  {Age, Fitness}

class GA {
  Population population_pool;
  Random randNumGenerator;
  double mutation;
  int generations;
  Survival survivalType;


  GA(List<City> map, int popSize ,int generations, {double mutation: 0.02, Survival st: Survival.Fitness}){
    this.mutation = (mutation == null) ? 0.02 : mutation;
    this.randNumGenerator = new Random();
    this.population_pool = new Population(map, ((popSize == null) ? 100 : popSize));
    this.generations = (generations == null) ? 1000 : generations;
    this.survivalType = st;
  }

  //O(n)
  Individual ox1(Individual parent1, Individual parent2){
    //Generate new Offspring
    Individual offspring = new Individual(_generateChild(parent1, parent2));//O(n)
    return offspring;
  }

  List<int> _generateChild(Individual parent1, Individual parent2){
    int startGene = this.randNumGenerator.nextInt(parent1.chromosome.length);
    int endGene = (this.randNumGenerator.nextInt( ((parent1.chromosome.length - startGene)) ) + startGene);
    List<int> offspring = new List<int>(parent1.length);

    //TODO: Break Down to smaller functions:
    //copy subsequence to new child O(n):
    // Build Gene SubSequence with a map:
    Map geneSubSeq = new Map();

    // Will Iterate less than n times: O(n)
    for(int i = startGene; i <= endGene; i++){
      geneSubSeq[parent1.chromosome[i]] = i;
      offspring[i] = parent1.chromosome[i];
    }

    //Iterate ((n - endGene) + startGene) times:
    int j = 0;
    int i = 0;
    while((j < startGene) && (i < parent2.length)){
      if(geneSubSeq[parent2.chromosome[i]] == null){
        offspring[j] = parent2.chromosome[i];
        j++;
      }
      i++;
    }

    //Iterate (n - startGene) times:
    j = endGene+1;
    while((j < parent2.length ) && (i < parent2.length)){
      if(geneSubSeq[parent2.chromosome[i]] == null){
        offspring[j] = parent2.chromosome[i];
        j++;
      }
      i++;
    }
    return offspring;
  }// END of genChild function

  void _mutateChromosome(Individual mutatee){
    if(this.randNumGenerator.nextInt(100) <= (this.mutation*100.0)){
      int randPos1 = this.randNumGenerator.nextInt(mutatee.length);
      int randPos2 = this.randNumGenerator.nextInt(mutatee.length);
      int temp = mutatee.chromosome[randPos1];
      mutatee.chromosome[randPos1] = mutatee.chromosome[randPos2];
      mutatee.chromosome[randPos2] = temp;
    }
  }

  void ga_tsp(){
    Individual originalFittest = this.population_pool.getFittest();
    for(int cur_gen=0; cur_gen < this.generations; cur_gen++){
      // Parent Selection
      Individual parent1 = this.population_pool.parentSelection();// O(n^(3/2))
      Individual parent2 = this.population_pool.parentSelection();// O(n^(3/2))

      // Apply Crossover operator to selected parents to generate new
      // individuals
      Individual offspring1 = this.ox1(parent1, parent2);
      // Possibly Mutate new offspring (based on probability)
      this._mutateChromosome(offspring1);
      //Introduce new offspring to the population:
      this.population_pool.pop.add(offspring1);
      // Offspring2:
      Individual offspring2 = this.ox1(parent2, parent1);
      // Possibly Mutate new offspring (based on probability)
      this._mutateChromosome(offspring2);
      //Introduce new offspring to the population:
      this.population_pool.pop.add(offspring2);

      // Survivor Selection (Age based)
      if(this.survivalType == Survival.Age){
        this.population_pool.survivorSelectionAB();
      }else{
        this.population_pool.survivorSelectionFB();
      }
    }
    Individual newFittest = this.population_pool.getFittest();
    // print('Original Most Fit Individual level: ${originalFittest.fitness}');
    // print('Original Most Fit Individual age: ${originalFittest.age}');
    // print('Original Most Fit Individual age: ${originalFittest.chromosome.toString()}');
    // print('\n');
    // print('New Most Fit Individual level: ${newFittest.fitness}');
    // print('New Most Fit Individual age: ${newFittest.age}');
    // print('New Most Fit Individual age: ${newFittest.chromosome.toString()}');
  }
}




int main(){
  // List<City> map = genMap();
  Map<String, Individual> largestDiffPair = new Map();
  double  ogAvg = 0.0,
          ngAvg = 0.0,
          diffAvg = 0.0,
          largestDiff = 0.0;

  for(int j=0; j < 2; j++){
    Individual bestOfBest = null;

    for(int i = 0; i < 100; i++){
      print("running GA-$i algo with ${(j == 0) ?'age based survival' : 'fitness based survival'}...");

      GA ga;
      if(j == 0){
        ga = new GA(genMap(), 100, 100000, st: Survival.Age);
      }
      else if(j == 1){
        ga = new GA(genMap(), 100, 100000, st: Survival.Fitness);
      }
      Individual og = ga.population_pool.getFittest();
      //Grabing Stats:
      ogAvg += og.fitness;
      ga.ga_tsp();
      Individual ng = ga.population_pool.getFittest();
      if(bestOfBest == null){
        bestOfBest = ng;
      }else{
        bestOfBest = (ng.fitness < bestOfBest.fitness) ? ng : bestOfBest;
      }
      //Grabing Stats:
      ngAvg += ng.fitness;
      if((og.fitness - ng.fitness) > largestDiff){
        largestDiffPair['OG'] = og;
        largestDiffPair['NG'] = ng;
        largestDiff = (og.fitness - ng.fitness);
      }
    }//END OF GA TEST i
    print('\n\n');
    print('GA Test-$j:\n');
    print('Best Of Best Solution:');
    print('\tName: ${bestOfBest.name}:');
    print('\tAge: ${bestOfBest.age}');
    print('\tFitness: ${bestOfBest.fitness}');
    print('\tChromosome: ${bestOfBest.chromosome}');
    print('------------------------------');
    print('\t STATS:');
    print('Largest Diff: $largestDiff');
    print('Between:');
    print("OG:");
    print("\tName: ${largestDiffPair['OG']?.name}:");
    print("\tAge: ${largestDiffPair['OG']?.age}");
    print("\tFitness: ${largestDiffPair['OG']?.fitness}");
    print("\tChromosome: ${largestDiffPair['OG']?.chromosome}");
    print("NG:");
    print("\tName: ${largestDiffPair['NG']?.name}:");
    print("\tAge: ${largestDiffPair['NG']?.age}");
    print("\tFitness: ${largestDiffPair['NG']?.fitness}");
    print("\tChromosome: ${largestDiffPair['NG']?.chromosome}");
    //calc Stats:
    ngAvg = ngAvg/100;
    ogAvg = ogAvg/100;
    diffAvg = (ogAvg-ngAvg);
    print('Original Solution Fitness Average: $ogAvg');
    print('New Solution Fitness Average: $ngAvg');
    print('Fitness Difference Average: $diffAvg');
    print('\n\n');
  }//END OF ALL GA TESTS

  print('\n');
  // print(ga.population_pool.toString());
  // print(ga.population_pool.dMatrix.toString());
  // Individual test1 = new Individual([1,2,3,4,5]);
  // Individual test2 = new Individual([5,4,3,2,1]);
  // Individual offspring = ga.ox1(test1, test2);
  // print('Offspring age: ${offspring.chromosome.toString()}');
  return 0;
}

List<City> genMap(){
  List<City> map = new List<City>();
  map.add(new City( 0, 450, 6));
  map.add(new City( 1, 38, 71));
  map.add(new City( 2, 485, 291));
  map.add(new City( 3, 81, 443));
  map.add(new City( 4, 274, 136));
  map.add(new City( 5, 194, 290));
  map.add(new City( 6, 103, 273));
  map.add(new City( 7, 26, 186));
  map.add(new City( 8, 178, 438));
  map.add(new City( 9, 260, 181));
  map.add(new City( 10, 273, 34));
  map.add(new City( 11, 116, 492));
  map.add(new City( 12, 82, 49));
  map.add(new City( 13, 464, 371));
  map.add(new City( 14, 109, 34));
  map.add(new City( 15, 152, 295));
  map.add(new City( 16, 230, 391));
  map.add(new City( 17, 33, 374));
  map.add(new City( 18, 297, 433));
  map.add(new City( 19, 446, 373));
  map.add(new City( 20, 496, 426));
  map.add(new City( 21, 165, 392));
  map.add(new City( 22, 164, 328));
  map.add(new City( 23, 60, 434));
  map.add(new City( 24, 134, 77));
  map.add(new City( 25, 361, 315));
  map.add(new City( 26, 93, 267));
  map.add(new City( 27, 291, 401));
  map.add(new City( 28, 432, 442));
  map.add(new City( 29, 497, 436));
  map.add(new City( 30, 104, 102));
  map.add(new City( 31, 53, 495));
  map.add(new City( 32, 149, 462));
  map.add(new City( 33, 292, 245));
  map.add(new City( 34, 425, 395));
  map.add(new City( 35, 428, 105));
  map.add(new City( 36, 435, 331));
  map.add(new City( 37, 365, 217));
  map.add(new City( 38, 126, 94));
  map.add(new City( 39, 495, 64));
  map.add(new City(40, 377, 36));
  map.add(new City(41, 138, 26));
  map.add(new City(42, 34, 431));
  map.add(new City(43, 53, 194));
  map.add(new City(44, 442, 95));
  map.add(new City(45, 162, 18));
  map.add(new City(46, 49, 109));
  map.add(new City(47, 229, 23));
  map.add(new City(48, 192, 19));
  map.add(new City( 49, 435, 122));
  return map;
}
