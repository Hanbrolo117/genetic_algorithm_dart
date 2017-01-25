import 'dart:html';
import 'dart:math';
import 'dart:async';
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
  bool isTourneyValid;
  bool isMutValid;
  bool isPopSizeValid;
  bool isGenNumValid;
  bool isLoading;
  String tourneyNum;
  String mutNum;
  String popSize;
  String genNum;
  String x;
}

@Component()
class ConfigFormComponent extends FluxUiStatefulComponent<ConfigFormProps, ConfigFormState> {

  InputElement popRef;
  InputElement mutRef;
  InputElement genRef;
  InputElement survRef;


  @override
  getInitialState() => (newState()..tourneyNum=""
    ..mutNum=""
    ..genNum=""
    ..popSize=""
    ..isLoading = false
  );


  @override
  render() {
    print(state.tourneyNum);
    print(state.mutNum);
    print(state.popSize);
    print(state.genNum);
    String validHighlight = "is-valid";
    String validIcon = "fa-check";
    String invalidHighlight = "is-danger";
    String invalidIcon = "fa-warning";
    return Dom.div()(
      (Dom.label()..className="label")("Number of survival rounds in GA:"),
      (Dom.p()..className="control has-icon has-icon-right")(
        (Dom.input()
          ..className="input ${state.isTourneyValid ? (validHighlight == null ? '': validHighlight) : invalidHighlight}"
          ..type = "text"
          ..placeholder = "Enter # of survival rounds here!"
          ..onChange = (event) => (this.onSurvivalRoundsChange(event))
          ..value = state?.tourneyNum
        )(),
        (Dom.span()..className="icon is-small")(
          (Dom.i()..className="fa ${state.isTourneyValid ? validIcon : invalidIcon}")()
        )
      ),
      (Dom.label()..className="label")("Mutation Rate 0.0-1.0:"),
      (Dom.p()..className="control has-icon has-icon-right")(
        (Dom.input()
          ..className="input ${state.isMutValid ? validHighlight : invalidHighlight}"
          ..type = "text"
          ..placeholder = "Enter mutation value here!"
          ..onChange = (event) => (this.onMutationChange(event))
          ..value = state.mutNum
        )(),
        (Dom.span()..className="icon is-small")(
          (Dom.i()..className="fa ${state.isMutValid ? validIcon : invalidIcon}")()
        )
      ),
      (Dom.label()..className="label")("Enter a population Size to start out with:"),
      (Dom.p()..className="control has-icon has-icon-right")(
        (Dom.input()
          ..className="input ${state.isPopSizeValid ? validHighlight : invalidHighlight}"
          ..type = "text"
          ..placeholder = "Enter number of individuals in first generation here!"
          ..onChange = (event) => (this.onPopSizeChange(event))
          ..value = state.popSize
        )(),
        (Dom.span()..className="icon is-small")(
          (Dom.i()..className="fa ${state.isPopSizeValid ? validIcon : invalidIcon}")()
        )
      ),
      (Dom.label()..className="label")("Enter number of Generations to Run in the sim:"),
      (Dom.p()..className="control has-icon has-icon-right")(
        (Dom.input()
          ..className="input ${state.isGenNumValid ? validHighlight : invalidHighlight}"
          ..type = "text"
          ..placeholder = "Enter number of generations to sim here!"
          ..onChange = (event) => (this.onGenSetChange(event))
          ..value = state.genNum
        )(),
        (Dom.span()..className="icon is-small")(
          (Dom.i()..className="fa ${state.isPopSizeValid ? validIcon : invalidIcon}")()
        )
      ),

      (Dom.div()..className="control is-grouped")(
        (Dom.p()..className="control")(
          (Dom.button()
            ..className="button is-primary ${props.store.isSimRunning ? 'is-loading is-disabled' : ''}"
            ..onClick = (_){this.handleEvolve();}
            ..ref = "evolve"
          )("Evolve!"),
          (Dom.button()
            ..className="button is-primary ${props.store.isSimRunning ? 'is-disabled' : 'is-hidden'}"
            ..onClick = (_){this.handleEvolve();}
          )("Evolve!"),
        )
      )
    );
  }
  Future sleep1() {
    return new Future.delayed(const Duration(seconds: 1), () => "1");
  }

  handleEvolve(){
    if(state.isTourneyValid && state.isGenNumValid && state.isMutValid && state.isPopSizeValid){
      print("Spinning up...");
      props.actions.startSim(true);
      (this.ref("evolve") as ButtonElement).classes = ["is-loading"];
      sleep1();
      print("Packing payload...");
      GAPayload payload = new GAPayload(state.mutNum, state.popSize, state.tourneyNum, state.genNum);
      print("Done!");
      print("Contacting GA Runner...");
      props.actions.runSim(payload);
      print("Done!");
    }
  }


  onSurvivalRoundsChange(event){
    if(props.store.isSimRunning)return;
    //Checking:
    // String val = event.target.value;
    String val = event.target.value;
    if(!isNumeric(val)){
      setState(newState()..isTourneyValid = false);
    }else{
      setState(newState()..isTourneyValid = true);
    }
    setState(newState()..tourneyNum = val);
  }

  onMutationChange(event){
    if(props.store.isSimRunning)return;
    //Checking:
    // String val = event.target.value;
    String val = event.target.value;
    if(!isNumeric(val)){
      setState(newState()..isMutValid = false);
    }else{
      if(double.parse(val) >= 1){
        setState(newState()..isMutValid = false);
      }else{
        setState(newState()..isMutValid = true);
      }
    }
    setState(newState()..mutNum = val);
  }

  onPopSizeChange(event){
    if(props.store.isSimRunning)return;
    //Checking:
    String val = event.target.value;
    if(!isNumeric(val)){
      setState(newState()..isPopSizeValid = false);
    }else{
      setState(newState()..isPopSizeValid = true);
    }
    setState(newState()..popSize = val);
  }

  onGenSetChange(event){
    if(props.store.isSimRunning)return;
    //Checking:
    String val = event.target.value;
    if(!isNumeric(val)){
      setState(newState()..isGenNumValid = false);
    }else{
      setState(newState()..isGenNumValid = true);
    }
    setState(newState()..genNum = val);
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
