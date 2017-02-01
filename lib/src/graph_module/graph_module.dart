import 'package:w_module/w_module.dart';

import 'package:genetic_algorithm/src/graph_module/actions/graph_actions.dart';
import 'package:genetic_algorithm/src/graph_module/events/graph_events.dart';
import 'package:genetic_algorithm/src/graph_module/stores/graph_store.dart';
import 'package:genetic_algorithm/src/graph_module/components/app_body_component.dart';

class GraphModule extends Module {

  final String name = 'graphModule';

  GraphActions _actions;
  GraphEvents _events;
  GraphStore _store;
  GraphComponents _components;
  GraphComponents get components => this._components;

  GraphModule(){
    _actions = new GraphActions();
    _events = new GraphEvents();
    _store = new GraphStore(_actions, _events, graphDispatchKey);
    _components = new GraphComponents(_actions, _store);
  }

}


class GraphComponents implements ModuleComponents {

  GraphActions _actions;
  GraphStore _store;

  GraphComponents(this._actions, this._store);

  content() => (AppBody()
    ..store = _store
    ..actions = _actions
    ..leftTitle = "Map Builder"
    ..rightTitle = "Genetic Configuration Tools"
  );
}
