import 'dart:html';
import 'dart:math';
import 'package:react/react.dart' as react;
import 'package:over_react/over_react.dart';
import 'package:genetic_algorithm/src/models/graph_point.dart';
import 'package:genetic_algorithm/src/actions/graph_actions.dart';
import 'package:genetic_algorithm/src/stores/graph_store.dart';
import 'package:genetic_algorithm/src/models/constants.dart';


@Factory()
UiFactory<GraphSolutionProps> GraphSolution;
@Props()
class GraphSolutionProps extends FluxUiProps<GraphActions, GraphStore> {
  List<int> lineColor;
  int width;
  int height;
}


@Component()
class GraphSolutionComponent extends FluxUiComponent<GraphSolutionProps> {
  CanvasElement canvasRef;
  CanvasRenderingContext2D context;

  @override
  getInitialProps() => (newProps()..lineColor = [0,0,0]);

  @override
  redrawOn() => [props.store];

  @override
  void componentDidMount() {
    print("mounted");
    context = canvasRef.getContext('2d');
    drawOnCanvas();
  }

  @override
  void componentDidUpdate(prevProps, prevState) {
    print("updating");
    context.clearRect(0, 0, props.width, props.height);
    context.beginPath();
    drawOnCanvas();
  }

  void drawOnCanvas() {
    context.beginPath();
    String x ="";
    for(int i=0; i < props.store.cityPoints.length; i++){
      x += (i < props.store.cityPoints.length-1) ? "${i+1}," : "${i+1}";
    }
    print(x);
    //If solution in store is set, map the route:
    if(props.store.solution != null){
      for(int i=0; i < props.store.cityPoints.length; i++){
        context.setStrokeColorRgb(props.lineColor[0], props.lineColor[1], props.lineColor[2]);
        context.moveTo(props.store.cityPoints[i].x1, props.store.cityPoints[i].y1);
        context.lineTo(props.store.cityPoints[i].x2, props.store.cityPoints[i].y2);
        context.stroke();
      }
    }

    for(int i=0; i < props.store.cityPoints.length; i++){
      context.beginPath();
      context.arc(props.store.cityPoints[i].x1, props.store.cityPoints[i].y1,raddi,0*PI,2*PI);
      context.fillStyle = "#2196f3";
      context.fill();
      context.stroke();

      context.fillStyle = "black"; // font color to write the text with
      context.font = "bold ${20}px serif";
      context.textBaseline = "center";
      context.fillText("${i+1}", props.store.cityPoints[i].x1-5, props.store.cityPoints[i].y1+6);
      context.stroke();
    }
    context.closePath();
  }
  @override
  render() {
    return (Dom.canvas()
      ..style={"border":"solid 5px black"}
      ..width = props.width
      ..height = props.height
      ..onMouseDown = this.cityTool
      ..ref = (ref) { canvasRef = ref; }
    )();
  }

  void cityTool(react.SyntheticMouseEvent e){
    // tell the browser handler is handling event:
    e.preventDefault();
    e.stopPropagation();

    var bb = canvasRef.getBoundingClientRect();
    var offsetX = bb.left;
    var offsetY = bb.top;
    var mouseX = (e.clientX - offsetX);
    var mouseY = (e.clientY - offsetY);
    int city = clickInCircle(mouseX, mouseY);
    if(city <= -1){
      GraphPoint newCity = new GraphPoint(mouseX, mouseY);
      props.actions.addCity(newCity);
    }else{
      props.actions.removeCity(city);
    }
  }

  int clickInCircle(int x, int y){
    int city = -1;
    List<GraphPoint> cities = props.store.cityPoints;
    for(int i=0; i< cities.length; i++){
      var distSqrd = pow((x - cities[i].x1), 2) + pow((y - cities[i].y1),2);
      if(distSqrd <= pow(raddi, 2)){
          city = i;
          return city;
      }
    }
    return city;
  }

}
