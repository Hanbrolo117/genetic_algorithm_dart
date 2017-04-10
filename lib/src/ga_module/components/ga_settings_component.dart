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
UiFactory<GaSettingsProps> GaSettingsForm;

@Props()
class GaSettingsProps extends FluxUiProps<GaActions, GaStore> {}

@State()
class GaSettingsState extends UiState {
  int popSize;
  int genSize;
  int muta;
}

@Component()
class GaSettingsComponent extends FluxUiStatefulComponent<GaSettingsProps, GaSettingsState> {

  @override
  getInitialState() => (newState()
    ..popSize = 100
    ..genSize = 1000
    ..muta = null
  );

  @override
  render(){
    return (Dom.div()..className="panel"..style={'width':'100%'})(
      (Dom.p()..className="panel-heading has-text-centered")(
        "Genetic Algorithm Settings"
      ),
      (Dom.div()..className="panel-block")(
        renderPopulationInput(),
        renderGenerationInput(),
        renderMutationInput(),
        renderUpdateButton(),
      ),
      (Dom.footer()..className="card-footer")(),
    );
  }

  renderPopulationInput(){
    return (Dom.div()
      ..className="field is-horizontal"
      ..style={'width':'100%'})(
      (Dom.div()..className="field-label is-normal")(
        (Dom.label()..className="label")('Population Size')
      ),
      (Dom.div()..className="field-body")(
        (Dom.div()..className="field")(
          (Dom.div()..className="control")(
            (Dom.input()
              ..className="input"
              ..type="number"
              ..min="0"
              ..required=true
              ..onChange = (event){this.onPopChange(event);}
              ..placeholder="Defaults to 100")(),
          ),
        ),
      ),
    );
  }


  renderGenerationInput(){
    return (Dom.div()
    ..className="field is-horizontal"
    ..style={'width':'100%'})(
      (Dom.div()..className="field-label is-normal")(
        (Dom.label()..className="label")('# Of Generations')
      ),
      (Dom.div()..className="field-body")(
        (Dom.div()..className="field")(
          (Dom.div()..className="control")(
            (Dom.input()
              ..className="input"
              ..type="number"
              ..min="0"
              ..required=true
              ..placeholder="Defaults to 10,000"
              ..onChange = (event){this.onGenChange(event);}
            )(),
          ),
        ),
      ),
    );
  }


  renderMutationInput(){
    return (Dom.div()
    ..className="field is-horizontal"
    ..style={'width':'100%'})(
      (Dom.div()..className="field-label is-normal")(
        (Dom.label()..className="label")('Mutation Percent')
      ),
      (Dom.div()..className="field-body")(
        (Dom.div()..className="field")(
          (Dom.div()..className="control")(
            (Dom.input()
              ..className="input"
              ..type="number"
              ..min="0"
              ..placeholder="(optional) Defaults to 2%"
              ..required=true
              ..onChange = (event){this.onMutaChange(event);}
            )(),
          ),
        ),
      ),
    );
  }

  renderUpdateButton(){
    return (Dom.div()
    ..className="field is-horizontal"
    ..style={'margin-top':'20px'})(
      (Dom.div()..className="field-label")(),
      (Dom.div()..className="field-body")(
        (Dom.div()..className="field")(
          (Dom.div()..className="control")(
            (Dom.button()
              ..className="button is-primary"
              ..onClick= (_){this.onClickUpdate(_);}
            )(
              "Update Settings"
            ),
          ),
        ),
      ),
    );
  }

  onPopChange(event){
    int val = int.parse(event.target.value);
    setState(newState()..popSize = val);
  }
  onGenChange(event){
    int val = int.parse(event.target.value);
    setState(newState()..genSize = val);
  }
  onMutaChange(event){
    int val = int.parse(event.target.value);
    setState(newState()..muta = val);
  }

  onClickUpdate(_){
    SettingsPayload payload = new SettingsPayload(state.popSize, state.genSize, state.muta);
    props.actions.setSettings(payload);
  }

}
