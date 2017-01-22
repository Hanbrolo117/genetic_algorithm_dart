import 'dart:html';
import 'package:react/react.dart' as react;
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart' as react_client;
import 'package:over_react/over_react.dart';
import 'package:genetic_algorithm/src/components/title_component.dart';


@Factory()
UiFactory<NavItemProps> NavItem;

@Props()
class NavItemProps extends UiProps {
  String leftTitle;
  String rightTitle;
}

@Component()
class NavItemComponent extends UiComponent<NavItemProps> {

  @override
  render() {
    return (Dom.a()..className="nav-item")();
  }
}
