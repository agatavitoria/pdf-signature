import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';

class PDFPage extends StatelessWidget {
  final PDFDocument document;

  const PDFPage({@required this.document});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PDFViewer(
        document: document,
        zoomSteps: 1,
      ),
    );
  }
}
