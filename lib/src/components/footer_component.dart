import 'package:over_react/over_react.dart';


@Factory()
UiFactory<FooterProps> Footer;

@Props()
class FooterProps extends UiProps{}


@Component()
class FooterComponent extends UiComponent {

  @override
  render(){
    return (Dom.footer()
      ..className = "footer is-small"
    )(
      (Dom.div()..className="container")(
        (Dom.div()..className="content has-text-centered")(
          Dom.p()(
            Dom.strong()("Genetic Algorithms"),
            " by ",
            (Dom.a()..href="https://github.com/Hanbrolo117")("Kyle Ferguson"),
            ". A project powered by ",
            (Dom.a()..href="https://www.dartlang.org/")("Dart"),
            ", ",
            (Dom.a()..href="https://workiva.github.io/over_react/")("Over React"),
            ", and ",
            (Dom.a()..href="http://bulma.io/")("Bulma"),
            "."
          )
        )
      )
    );
  }

}
