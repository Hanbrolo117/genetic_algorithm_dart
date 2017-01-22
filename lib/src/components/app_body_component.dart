import 'dart:html';
import 'package:react/react.dart' as react;
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart' as react_client;
import 'package:over_react/over_react.dart';
import 'package:genetic_algorithm/src/components/title_component.dart';


@Factory()
UiFactory<AppBodyProps> AppBody;

@Props()
class AppBodyProps extends UiProps {
  String leftTitle;
  String rightTitle;
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

        ),
        (Dom.div()..className="column")(
          (Dom.h1()
            ..className="title"
            ..style={"textAlign":"center"})(
              props.rightTitle
          )
        ),
      );
  }
}
