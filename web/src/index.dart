import 'dart:html';
import 'dart:core';

import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart' as react_client;
import 'package:over_react/over_react.dart';

import 'package:genetic_algorithm/src/graph_module/components/title_component.dart';
import 'package:genetic_algorithm/src/graph_module/components/nav_component.dart';
import 'package:genetic_algorithm/src/graph_module/components/footer_component.dart';
import 'package:genetic_algorithm/src/graph_module/graph_module.dart';


void main(){

  GraphModule gModule = new GraphModule();

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
      gModule.components.content()(),
      (Footer())()
    ),querySelector('#react_mount_point'));
}
