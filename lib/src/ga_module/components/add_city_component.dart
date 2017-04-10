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
UiFactory<AddCityProps> AddCityForm;

@Props()
class AddCityProps extends FluxUiProps<GaActions, GaStore> {}

@State()
class AddCityState extends UiState {
  int x;
  int y;
}

@Component()
class AddCityComponent extends FluxUiStatefulComponent<AddCityProps, AddCityState> {

  @override
  getInitialState() => (newState()
    ..x = 0
    ..y = 0
  );

  @override
  render(){
    return (Dom.div()..className="panel"..style={'width':'100%'})(
      (Dom.p()..className="panel-heading has-text-centered")(
        "Add A City"
      ),
      (Dom.div()..className="panel-block")(
        renderAddCityInput(),
      ),
      (Dom.footer()..className="card-footer")(),
    );
  }

  renderAddCityInput(){
    return (Dom.div()
    ..className="field-body is-grouped"
    ..style={'width':'100%'})(
        (Dom.p()..className="control is-expanded is-horizontal")(
          (Dom.label()..className="label")(),
          (Dom.input()
            ..className="input"
            ..type="number"
            ..min="0"
            ..placeholder="X position"
            ..onChange= (event) => this.onXChange(event)
          )(),
          (Dom.input()
            ..className="input"
            ..type="number"
            ..min="0"
            ..placeholder="Y position"
            ..required=true
            ..onChange= (event) => this.onYChange(event)
          )(),
          (Dom.button()
            ..className="button is-primary"
            ..onClick= (_) => this.onAddCity())(
            "Add City"
          ),
        ),
      );
  }

  renderSendButton(){
    return (Dom.div()..className="field is-horizontal")(
      (Dom.div()..className="field-label")(),
      (Dom.div()..className="field-body")(
        (Dom.div()..className="field")(
          (Dom.div()..className="control")(
            (Dom.button()
            ..className="button is-primary"
            ..onClick= (_) => this.onAddCity())(
              "Add City"
            ),
          ),
        ),
      ),
    );
  }

  onXChange(event){
    int val = int.parse(event.target.value);
    setState(newState()..x = val);
  }

  onYChange(event){
    int val = int.parse(event.target.value);
    setState(newState()..y = val);
  }

  onAddCity(){
    CityPayload payload = new CityPayload(state.x, state.y);
    props.actions.addCity(payload);
  }

}
