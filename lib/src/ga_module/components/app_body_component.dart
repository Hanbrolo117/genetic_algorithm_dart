import 'dart:html';
import 'package:react/react.dart' as react;
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart' as react_client;
import 'package:over_react/over_react.dart';

import 'package:genetic_algorithm/src/ga_module/actions/ga_actions.dart';
import 'package:genetic_algorithm/src/ga_module/stores/ga_store.dart';
import 'package:genetic_algorithm/src/ga_module/components/title_component.dart';
import 'package:genetic_algorithm/src/ga_module/components/add_city_component.dart';
import 'package:genetic_algorithm/src/ga_module/components/city_table_component.dart';
import 'package:genetic_algorithm/src/ga_module/components/ga_settings_component.dart';
import 'package:genetic_algorithm/src/ga_module/components/output_component.dart';


@Factory()
UiFactory<AppBodyProps> AppBody;

@Props()
class AppBodyProps extends FluxUiProps<GaActions, GaStore> {
  String leftTitle;
  String rightTitle;
}

@Component()
class AppBodyComponent extends FluxUiComponent<AppBodyProps> {

  @override
  render() {
    return (Dom.div()
    ..className="columns"
    ..style={"paddingTop":"50px"})(
      (Dom.div()..className="column")(
        (Dom.h1()
          ..className="title"
          ..style={"textAlign":"center"})(
            props.leftTitle
        ),
        (Dom.div()..className="columns is-centered")(//Output Panel (OG)
          (Dom.div()..className="column is-half")(
            (Dom.button()
            ..className="button is-primary"
            ..onClick= (_) => this.onClickRunGaAlgo())(
              "Run Genetic Algorithm"
            ),
          ),
        ),
        (Dom.div()..className="columns is-centered")(//Output Panel (OG)
          (Dom.div()..className="column is-half")(
            (GaOutput()
              ..store = props.store
              ..actions = props.actions)()
          ),
        ),
        (Dom.div()..className="columns is-centered")(//Settings Panel
          (Dom.div()..className="column is-half")(
            (GaSettingsForm()
              ..store = props.store
              ..actions = props.actions)()
          ),
        ),
        (Dom.div()..className="columns is-centered")(//Add City Panel
          (Dom.div()..className="column is-half")(
            (AddCityForm()
              ..store = props.store
              ..actions = props.actions)()
          ),
        ),
        (Dom.div()..className="columns is-centered")(//Output Panel (OG)
          (Dom.div()..className="column is-one-quarter")(
            (Dom.button()
            ..className="button is-primary"
            ..style={'width':'100%'}
            ..onClick= (_) => this.onGenerateDefaultMap())(
              "Generate Default Map"
            ),
          ),
          (Dom.div()..className="column is-one-quarter")(
            (Dom.button()
            ..className="button is-primary"
            ..style={'width':'100%'}
            ..onClick= (_) => this.onGenerateRandomMap())(
              "Generate Random Map"
            ),
          ),
        ),
        (Dom.div()..className="columns is-centered")(//City Display Panel
          (Dom.div()..className="column is-half"
        ..style={'overflow-y':'auto','max-height':'400px'})(
            (CityTable()
              ..store = props.store
              ..actions = props.actions)()
          ),
        ),
      ),
    );
  }

  onClickRunGaAlgo(){
    props.actions.runGa();
  }

  onGenerateDefaultMap(){
    props.actions.setMapToDefault();
  }

  onGenerateRandomMap(){
    props.actions.setMapToRandom();
  }

}
