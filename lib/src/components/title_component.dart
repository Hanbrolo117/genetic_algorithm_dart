import 'dart:html';
import 'package:react/react.dart' as react;
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart' as react_client;
import 'package:over_react/over_react.dart';

@Factory()
UiFactory<TitleProps> Title;

@Props()
class TitleProps extends UiProps {
  String title;
  String subTitle;
  String type;
  String size;
  String boldness;
}

@Component()
class TitleComponent extends UiComponent<TitleProps> {

  @override
  render() {
    String titleClass = "hero ${props.type ?? ''} ${props.size ?? ''} ${props.boldness ?? ''}";
    return (Dom.section()..className = titleClass)(
        (Dom.div()..className = "hero-body")(
          (Dom.div()..className = "container")(
            (Dom.h1()..className = "title")(props.title),
            (Dom.h2()..className = "subtitle")(props.subTitle),
          ),
        ),
      );
  }
}
