import 'dart:html';
import 'dart:math';
import 'package:react/react.dart' as react;
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart' as react_client;
import 'package:over_react/over_react.dart';
import 'package:genetic_algorithm/src/components/title_component.dart';
import 'package:genetic_algorithm/src/models/constants.dart';
import 'package:genetic_algorithm/src/models/graph_point.dart';
import 'package:genetic_algorithm/src/components/graph_component.dart';
import 'package:genetic_algorithm/src/stores/graph_store.dart';
import 'package:genetic_algorithm/src/actions/graph_actions.dart';

@Factory()
UiFactory<ConfigFormProps> ConfigForm;

@Props()
class ConfigFormProps extends FluxUiProps<GraphActions, GraphStore> {

}

@State()
class ConfigFormState extends UiState {
  bool survivalRoundsValid;
  bool mutationRateValid;
  bool initPopSizeValid;
  bool generationNumValid;
  bool isSucessful;

  String survivialRounds;
  String mutationRate;
  String popSize;
  String numOfGens;
}

@Component()
class ConfigFormComponent extends FluxUiStatefulComponent<ConfigFormProps, ConfigFormState> {

  InputElement popRef;
  InputElement mutRef;
  InputElement genRef;
  InputElement survRef;



  @override
  render() {
    String validHighlight = "is-valid";
    String validIcon = "fa-check";
    String invalidHighlight = "is-danger";
    String invalidIcon = "fa-warning";
    return Dom.div()(
      (Dom.label()..className="label")("Number of survival rounds in GA:"),
      (Dom.p()..className="control has-icon has-icon-right")(
        (Dom.input()
          ..className="input ${state.survivalRoundsValid ? (validHighlight == null ? '': validHighlight) : invalidHighlight}"
          ..type = "text"
          ..placeholder = "Enter # of survival rounds here!"
          ..onChange = (event) => (this.onSurvivalRoundsChange(event))
          ..value = state.survivialRounds
        )(),
        (Dom.span()..className="icon is-small")(
          (Dom.i()..className="fa ${state.survivalRoundsValid ? validIcon : invalidIcon}")()
        )
      ),
      (Dom.label()..className="label")("Mutation Rate 0.0-1.0:"),
      (Dom.p()..className="control has-icon has-icon-right")(
        (Dom.input()
          ..className="input ${state.mutationRateValid ? validHighlight : invalidHighlight}"
          ..type = "text"
          ..placeholder = "Enter mutation value here!"
          ..onChange = (event) => (this.onMutationChange(event))
          ..value = state.mutationRate
        )(),
        (Dom.span()..className="icon is-small")(
          (Dom.i()..className="fa ${state.mutationRateValid ? validIcon : invalidIcon}")()
        )
      ),
      (Dom.label()..className="label")("Enter a population Size to start out with:"),
      (Dom.p()..className="control has-icon has-icon-right")(
        (Dom.input()
          ..className="input ${state.initPopSizeValid ? validHighlight : invalidHighlight}"
          ..type = "text"
          ..placeholder = "Enter number of individuals in first generation here!"
          ..onChange = (event) => (this.onPopSizeChange(event))
          ..value = state.popSize
        )(),
        (Dom.span()..className="icon is-small")(
          (Dom.i()..className="fa ${state.initPopSizeValid ? validIcon : invalidIcon}")()
        )
      ),
      (Dom.label()..className="label")("Enter number of Generations to Run in the sim:"),
      (Dom.p()..className="control has-icon has-icon-right")(
        (Dom.input()
          ..className="input ${state.generationNumValid ? validHighlight : invalidHighlight}"
          ..type = "text"
          ..placeholder = "Enter number of generations to sim here!"
          ..onChange = (event) => (this.onGenSetChange(event))
          ..value = state.numOfGens
        )(),
        (Dom.span()..className="icon is-small")(
          (Dom.i()..className="fa ${state.initPopSizeValid ? validIcon : invalidIcon}")()
        )
      ),

      (Dom.div()..className="control is-grouped")(
        (Dom.p()..className="control")(
          (Dom.button()
            ..className="button is-primary ${state.isSucessful ? 'is-loading' : ''}"
            ..onClick = (_){this.handleEvolve();}
          )("Evolve!"),
          (Dom.button()
            ..className="button is-primary "
            ..onClick = (_){this.handleRandomize();}
          )("Randomize!")
        )
      )
    );
  }

  handleEvolve(){
    if(state.survivalRoundsValid && state.generationNumValid && state.mutationRateValid && state.initPopSizeValid){
      setState(newState()..isSucessful = true);
      //Trigger GA
    }
  }

  handleRandomize(){
    if(!state.isSucessful){
      Random rand = new Random();
      var popRef = (rand.nextInt(100)+50).toString();
      var genRef = (rand.nextInt(1001)+50).toString();
      var mutRef = rand.nextDouble().toString();
      var survRef = rand.nextInt(10).toString();
      print(popRef);
      print(genRef);
      print(mutRef);
      print(survRef);
      setState(newState()
        // ..survivalRoundsValid = true
        // ..initPopSizeValid = true
        // ..generationNumValid = true
        // ..mutationRateValid = true
        ..survivialRounds = survRef
        ..popSize = popRef
        ..mutationRate = mutRef
        ..numOfGens = genRef);
    }
  }

  onSurvivalRoundsChange(event){
    //Checking:
    String val = event.target.value;
    if(!isNumeric(val)){
      setState(newState()..survivalRoundsValid = false);
    }else{
      setState(newState()..survivalRoundsValid = true);
    }
    setState(newState()..survivialRounds = event.target.value);
  }

  onMutationChange(event){
    //Checking:
    String val = event.target.value;
    if(!isNumeric(val)){
      setState(newState()..mutationRateValid = false);
    }else{
      if(double.parse(val) >= 1){
        setState(newState()..mutationRateValid = false);
      }else{
        setState(newState()..mutationRateValid = true);
      }
    }
    setState(newState()..mutationRate = event.target.value);
  }

  onPopSizeChange(event){
    //Checking:
    String val = event.target.value;
    if(!isNumeric(val)){
      setState(newState()..initPopSizeValid = false);
    }else{
      setState(newState()..initPopSizeValid = true);
    }
    setState(newState()..popSize = event.target.value);
  }

  onGenSetChange(event){
    //Checking:
    String val = event.target.value;
    if(!isNumeric(val)){
      setState(newState()..generationNumValid = false);
    }else{
      setState(newState()..generationNumValid = true);
    }
    setState(newState()..numOfGens = event.target.value);
  }
}

bool isNumeric(String s) {
  if(s == null) {
    return false;
  }

  // TODO according to DartDoc num.parse() includes both (double.parse and int.parse)
  return double.parse(s, (e) => null) != null ||
      int.parse(s, onError: (e) => null) != null;
}
