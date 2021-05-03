import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:signature_pdf/controller/pdf_controller.dart';
import 'package:signature_pdf/controller/my_signature_controller.dart';
import 'package:signature_pdf/globals/environment.dart';
import 'package:signature_pdf/screens/signature_page.dart';

class HtmlPage extends StatefulWidget {
  @override
  _HtmlPageState createState() => _HtmlPageState();
}

class _HtmlPageState extends State<HtmlPage> {
  bool _carregando = false;

  _getAssinatura() async {
    final Uint8List resul = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => SignaturePage(),
      ),
    );

    if (resul != null) {
      setState(() => _carregando = true);
      _showPDF(resul);
    }
  }

  _showPDF(Uint8List uint8List) async {
    await MySignatureController.anexaImagemNoHtml(uint8List);
    setState(() => _carregando = false);
    PDFController.openPDFPage(context);
  }

  Widget _signatureButton(var element) {
    if (element.id.contains("assinatura")) {
      return Center(
        child: Container(
          child: RaisedButton(
            child: Text("Clica aqui para assinar"),
            onPressed: () => _getAssinatura(),
          ),
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text('HTML PAGE'),
          ),
          backgroundColor: Colors.orange,
          body: SingleChildScrollView(
            child: Column(
              children: [
                HtmlWidget(
                  Environment.html,
                  customWidgetBuilder: _signatureButton,
                ),
              ],
            ),
          ),
        ),
        if (_carregando)
          Positioned.fill(
            child: WillPopScope(
              onWillPop: () async => false,
              child: Container(
                color: Colors.white70,
                child: Center(
                  child: CupertinoActivityIndicator(
                    radius: 15,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
