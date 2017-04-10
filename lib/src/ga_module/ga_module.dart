import 'package:w_module/w_module.dart';

import 'package:genetic_algorithm/src/ga_module/events/ga_events.dart';
import 'package:genetic_algorithm/src/ga_module/actions/ga_actions.dart';
import 'package:genetic_algorithm/src/ga_module/stores/ga_store.dart';
import 'package:genetic_algorithm/src/ga_module/components/app_body_component.dart';

class GaModule extends Module {

  final String name = 'graphModule';

  GaActions _actions;
  GaEvents _events;
  GaStore _store;
  GaComponents _components;
  GaComponents get components => this._components;

  GaModule(){
    _actions = new GaActions();
    _events = new GaEvents();
    _store = new GaStore(_actions);
    _components = new GaComponents(_actions, _store);
  }

}


class GaComponents implements ModuleComponents {

  GaActions _actions;
  GaStore _store;

  GaComponents(this._actions, this._store);

  content() => (AppBody()
    ..store = _store
    ..actions = _actions
    ..leftTitle = "GA v1.0"
    ..rightTitle = "Genetic Configuration Tools"
  );
}
