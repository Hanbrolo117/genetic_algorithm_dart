import 'dart:html';
import 'dart:core';
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart' as react_client;
import 'package:over_react/over_react.dart';
import 'package:genetic_algorithm/models/graph_point.dart';
import 'package:genetic_algorithm/src/components/graph_component.dart';
import 'package:genetic_algorithm/src/components/title_component.dart';
import 'package:genetic_algorithm/src/components/app_body_component.dart';
import 'package:genetic_algorithm/src/components/nav_component.dart';



void main(){
  //Initialize React within our Dart App:
  react_client.setClientConfiguration();

  List<GraphPoint> points = new List();
  GraphPoint p1 = new GraphPoint("1",20, 20, 100, 100);
  GraphPoint p2 = new GraphPoint("2",100, 100, 250, 150);
  GraphPoint p3 = new GraphPoint("3",250, 150, 400, 386);
  GraphPoint p4 = new GraphPoint("4", 400, 386, 340, 120);
  GraphPoint p5 = new GraphPoint("5", 340, 120, 20, 20);
  points.add(p1);
  points.add(p2);
  points.add(p3);
  points.add(p4);
  points.add(p5);

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
        ..leftTitle = "Map"
        ..rightTitle = "Map Tools"
      )(),
    //   (GraphSolution()
    //     ..lineColor = [0,0,0]
    //     ..points = points
    //     ..gWidth = 3840
    //     ..gHeight = 2160
    // )()
    ),querySelector('#react_mount_point'));
}
