import 'dart:html';
import 'dart:math';
import 'dart:async';
//Dart:
import 'dart:html';
import 'dart:math';

//Dependencies:
import 'package:w_flux/w_flux.dart';
import 'package:react/react.dart' as react;
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart' as react_client;
import 'package:over_react/over_react.dart';

import 'package:genetic_algorithm/src/ga_module/actions/ga_actions.dart';
import 'package:genetic_algorithm/src/ga_module/stores/ga_store.dart';
import 'package:genetic_algorithm/src/models/city.dart';

@Factory()
UiFactory<CityTableProps> CityTable;

@Props()
class CityTableProps extends FluxUiProps<GaActions, GaStore> {}


@Component()
class CityTableComponent extends FluxUiComponent<CityTableProps> {

  @override
  render(){
    return (Dom.table()
      ..className="table"
      ..style={'width':'100%',})(
        Dom.thead()(
          Dom.tr()(
            Dom.th()('City'),
            Dom.th()('X-Pos'),
            Dom.th()('Y-Pos'),
            Dom.th()('Action'),
          ),
        ),
        Dom.tfoot()(
          Dom.tr()(
            Dom.th()('City'),
            Dom.th()('X-Pos'),
            Dom.th()('Y-Pos'),
            Dom.th()('Action'),
          ),
        ),
        Dom.tbody()(
          renderCityTableRows()
        ),
      );
  }

  renderCityTableRows(){
    List cities = new List();
    int cityIndex = 0;
    for(City city in props.store.map){
      var cityElement = Dom.tr()(
        Dom.td()(city.name),
        Dom.td()(city.x),
        Dom.td()(city.y),
        Dom.td()(renderDeleteButton(cityIndex))
      );
      cityIndex++;
      cities.add(cityElement);
    }
    return cities;
  }

  renderDeleteButton(int cityIndex){
    return (Dom.div()
      ..className="button is-danger"
      ..onClick = (event) => this.onDeleteCity(cityIndex)
    )('Delete');
  }

  onDeleteCity(int cityIndex){
    props.actions.deleteCity(cityIndex);
  }

}
