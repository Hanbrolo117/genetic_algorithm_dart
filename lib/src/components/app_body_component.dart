import 'dart:html';
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
UiFactory<AppBodyProps> AppBody;

@Props()
class AppBodyProps extends UiProps {
  String leftTitle;
  String rightTitle;
  GraphStore store;
  GraphActions actions;
}

@Component()
class AppBodyComponent extends UiComponent<AppBodyProps> {

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
          (Dom.div()..className="columns is-centered")(
              (GraphSolution()
                ..style={"border":"solid 5px black","width":"inherit", "height":"inherit"}
                ..width = 300
                ..height = 300
                ..store = props.store
                ..actions = props.actions
                ..lineColor = [99,236,63]
              )()
          )
        ),
        (Dom.div()..className="column")(
          (Dom.h1()
            ..className="title"
            ..style={"textAlign":"center"})(
              props.rightTitle
          ),
        ),
      );
  }
}
