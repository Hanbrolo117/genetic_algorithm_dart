import 'dart:html';
import 'package:react/react.dart' as react;
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart' as react_client;
import 'package:over_react/over_react.dart';
import 'package:genetic_algorithm/src/ga_module/components/title_component.dart';
import 'package:genetic_algorithm/src/ga_module/components/nav/nav_item_component.dart';


@Factory()
UiFactory<NavProps> Nav;

@Props()
class NavProps extends UiProps {
  String leftTitle;
  String rightTitle;
}

@Component()
class NavComponent extends UiComponent<NavProps> {

  @override
  render() {
    return (Dom.div()
      ..className="nav"
    )(
      (Dom.div()..className="nav-left")(
        (Dom.a()..className="nav-item")(
          Dom.span()(
            (Dom.span()..className="icon"..style={"marginRight":"10px"})(
              (Dom.i()..className="fa fa-coffee")()
            ),
            "Developed by Kyle Ferguson ",
          )
        )
      ),
      (Dom.div()..className="nav-center")(
        (Dom.a()
          ..href="https://github.com/Hanbrolo117/genetic_algorithm_dart"
          ..className="nav-item")(
          (Dom.span()..className="icon")(
            (Dom.i()..className="fa fa-github")()
          )
        )
      ),
      (Dom.div()..className="nav-right nav-menu")(
        (Dom.a()..className="nav-item")("Home"),
        (Dom.a()..className="nav-item")("Analysis"),
        (Dom.a()..className="nav-item")("Education"),
        (Dom.span()..className="nav-item")(
          (Dom.a()
            ..href="https://github.com/Hanbrolo117/genetic_algorithm_dart/archive/master.zip"
            ..className="button is-primary")(
            (Dom.span()..className="icon")(
              (Dom.i()..className="fa fa-download")()
            ),
            Dom.span()("Download"),
          )
        ),
      ),
    );
  }
}
