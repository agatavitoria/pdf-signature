import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../screens/pdf_page.dart' as my;

class PDFController {
  static createPDF() async {
    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Hello World"),
          );
        },
      ),
    );

    final document = await doc.save();
    return document;
  }

  static createPDFByHTML(String html) async {
    final pdf = await Printing.convertHtml(
      format: PdfPageFormat.a4,
      html: html,
    );

    return pdf;
  }

  static savePDF(Uint8List pdf) async {
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/example.pdf");
    await file.writeAsBytes(pdf);

    return file;
  }

  static openPDFPage(BuildContext context) async {
    return Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => my.PDFPage()),
    );
  }
}
