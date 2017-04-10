import 'package:uuid/uuid.dart';

class Individual {
  List<int> chromosome;
  int age;
  double fitness;
  String name;
  Uuid _uuid;

  Individual(this.chromosome, {this.age = 0, this.fitness = 0.0}){
    this._uuid = new Uuid();
    this.name = this._uuid.v4();
  }
  int get length => chromosome.length;
}
