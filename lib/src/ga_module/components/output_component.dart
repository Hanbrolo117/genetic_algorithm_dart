//Dart:
import 'dart:html';
import 'dart:math';
import 'dart:async';

//Dependencies:
import 'package:w_flux/w_flux.dart';
import 'package:react/react.dart' as react;
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart' as react_client;
import 'package:over_react/over_react.dart';

import 'package:genetic_algorithm/src/ga_module/actions/ga_actions.dart';
import 'package:genetic_algorithm/src/ga_module/stores/ga_store.dart';

@Factory()
UiFactory<GaOutputProps> GaOutput;

@Props()
class GaOutputProps extends FluxUiProps<GaActions, GaStore> {}


@Component()
class GaOutputComponent extends FluxUiComponent<GaOutputProps> {

  @override
  redrawOn() => [props.store];

  @override
  render(){
    print('Drawing');
    return (Dom.div()..className="panel"..style={'width':'100%'})(
      (Dom.p()..className="panel-heading has-text-centered")("Genetic Algorithm Output"),
      (Dom.div()..className="panel-block")(renderOuput()),
      (Dom.footer()..className="card-footer")(),
    );
  }

  renderOuput(){
    String solution = '';
    if( (props.store.genOneFittest != null) && (props.store.genXFittest != null) ){
      solution += "Generation 1 Optimal Solution:\n";
    solution += "\tName: ${props.store.genOneFittest.name}\n";
    solution += "\tAge: ${props.store.genOneFittest.age}\n";
    solution += "\tFitness: ${props.store.genOneFittest.fitness}\n";
    solution += "\tChromosome: \t${props.store.genOneFittest.chromosome.toString()}\n";
    solution += "\n\n";
    solution += "Generation ${props.store.generations} Optimal Solution:\n";
    solution += "\tName: ${props.store.genXFittest.name}\n";
    solution += "\tAge: ${props.store.genXFittest.age}\n";
    solution += "\tFitness: ${props.store.genXFittest.fitness}\n";
    solution += "\tChromosome: \t${props.store.genXFittest.chromosome.toString()}\n";
  }else{
    solution = 'GA solution will be outputted here...';
    print(props.store.genOneFittest.runtimeType.toString());
    print(props.store.genXFittest.runtimeType.toString());
  }
    return (Dom.div()
    ..className="field-body is-grouped"
    ..style={'width':'100%'})(
        (Dom.p()..className="control is-expanded is-horizontal")(
          (Dom.label()..className="label")(),
          (Dom.textarea()
            ..className="textarea"
            ..placeholder= solution
          )(),
        ),
      );
  }

}
