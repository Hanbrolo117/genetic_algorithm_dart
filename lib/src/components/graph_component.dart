import 'dart:html';
import 'dart:math';
import 'package:over_react/over_react.dart';
import 'package:genetic_algorithm/models/graph_point.dart';
@Factory()
UiFactory<GraphSolutionProps> GraphSolution;
@Props()
class GraphSolutionProps extends UiProps {
  List<int> lineColor;
  List<GraphPoint> points;
  int gWidth;
  int gHeight;

}
@Component()
class GraphSolutionComponent extends UiComponent<GraphSolutionProps> {
  CanvasElement canvasRef;
  CanvasRenderingContext2D context;

  @override
  getInitialProps() => (newProps()..lineColor = [0,0,0]
    ..points = new List()
    ..gWidth = 100
    ..gHeight = 100);

  @override
  void componentDidMount() {
    context = canvasRef.getContext('2d');
    drawOnCanvas();
  }
  @override
  void componentDidUpdate(prevProps, prevState) {
    context.clearRect(0, 0, props.gWidth, props.gHeight);
    drawOnCanvas();
  }
  void drawOnCanvas() {
    for(int i=0; i < props.points.length; i++){
      context.setStrokeColorRgb(props.lineColor[0], props.lineColor[1], props.lineColor[2]);
      context.moveTo(props.points[i].x1, props.points[i].y1);
      context.lineTo(props.points[i].x2, props.points[i].y2);
      context.stroke();
    }
    for(int i=0; i < props.points.length; i++){
      context.beginPath();
      context.arc(props.points[i].x1, props.points[i].y1,10,0*PI,2*PI);
      context.fillStyle = "#2196f3";
      context.fill();
      context.stroke();

      context.fillStyle = "black"; // font color to write the text with
      context.font = "bold ${20}px serif";
      context.textBaseline = "center";
      context.fillText(props.points[i].name, props.points[i].x1-5, props.points[i].y1+6);
      context.stroke();
    }
  }
  @override
  render() {
    return (Dom.canvas()
      ..width = props.gWidth
      ..height = props.gHeight
      ..ref = (ref) { canvasRef = ref; }
    )();
  }
}
