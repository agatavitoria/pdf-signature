import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class HtmlPage extends StatelessWidget {
  final String htmlData;

  HtmlPage({@required this.htmlData}); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTML PAGE'),
      ),
      body: HtmlWidget(
        htmlData,
        customWidgetBuilder: (element) {
          if (element.id.contains("assinatura")) {
            return Container(
              child: RaisedButton(
                child: Text("Clica aqui para assinar"),
                onPressed: () {},
              ),
            );
          }
          return null;
        },
        textStyle: TextStyle(fontSize: 30),
      ),
    );
  }
}
