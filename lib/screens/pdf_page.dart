import 'dart:typed_data';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signature_pdf/controller/my_signature_controller.dart';
import 'package:signature_pdf/controller/pdf_controller.dart';
import 'package:signature_pdf/globals/environment.dart';
import 'package:signature_pdf/screens/signature_page.dart';

class PDFPage extends StatefulWidget {
  @override
  _PDFPageState createState() => _PDFPageState();
}

class _PDFPageState extends State<PDFPage> {
  PDFDocument _document;
  bool _carregando = true;

  _getAssinatura() async {
    final Uint8List resul = await Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => SignaturePage()),
    );

    if (resul != null) _updatePDF(resul);
  }

  _updatePDF(Uint8List uint8List) async {
    setState(() => _carregando = true);
    await MySignatureController.anexaImagemNoHtml(uint8List);
    await _gerarPDF();
  }

  _gerarPDF() async {
    final pdfHtml = await PDFController.createPDFByHTML(Environment.html);
    final pdfFile = await PDFController.savePDF(pdfHtml);
    PDFDocument tempDoc = await PDFDocument.fromFile(pdfFile);
    setState(() {
      _document = tempDoc;
      _carregando = false;
    });
  }

  @override
  void initState() {
    _gerarPDF();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _carregando
          ? Center(
              child: CircularProgressIndicator(),
            )
          : PDFViewer(
              document: _document,
              zoomSteps: 1,
              showPicker: false,
              showNavigation: false,
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.brush),
        onPressed: _getAssinatura,
      ),
    );
  }
}
