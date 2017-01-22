import 'dart:html';
import 'dart:core';
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart' as react_client;
import 'package:over_react/over_react.dart';
import 'package:genetic_algorithm/src/components/title_component.dart';
import 'package:genetic_algorithm/src/components/app_body_component.dart';
import 'package:genetic_algorithm/src/components/nav_component.dart';
import 'package:genetic_algorithm/src/stores/graph_store.dart';
import 'package:genetic_algorithm/src/actions/graph_actions.dart';



void main(){
  GraphActions graphActions = new GraphActions();
  GraphStore graphStore = new GraphStore(graphActions);
  //Initialize React within our Dart App:
  react_client.setClientConfiguration();

  react_dom.render(
    Dom.div()(
      Nav()(),
      (Title()
        ..title = "Genetic Algorithm For The Traveling Salesman Problem"
        ..subTitle = "By: Kyle Ferguson"
        ..size = "is-small"
        ..type = "is-primary"
        ..boldness = "is-bold"
      )(),
      (AppBody()
        ..store = graphStore
        ..actions = graphActions
        ..leftTitle = "Map Builder"
        ..rightTitle = "Genetic Configuration Tools"
      )(),
    //   (GraphSolution()
    //     ..lineColor = [0,0,0]
    //     ..points = points
    //     ..gWidth = 3840
    //     ..gHeight = 2160
    // )()
    ),querySelector('#react_mount_point'));
}
