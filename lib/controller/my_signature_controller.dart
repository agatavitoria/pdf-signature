import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:signature_pdf/globals/environment.dart';

class MySignatureController {

  static _overrideHtmlContrato(String oldHtml, String newHtml) {
    var split1 = oldHtml.split('<div id="assinatura">');
    var split2 = split1[1].toString().split('</div id="fim_assinatura">');
    String texto = '''
      ${split1[0].toString()}
      $newHtml
      ${split2[1]}
    ''';
    return texto;
  }

  static anexaImagemNoHtml(Uint8List uint8List) async {
    final file = await saveSignature(uint8List);
    final html = '''
      <div id="assinatura">
        <img src="${file.uri}"/>
      </div id="fim_assinatura">
    ''';
    String newContrato = _overrideHtmlContrato(Environment.html, html);
    Environment.html = newContrato;
  }
  
  static Future<File> saveSignature(Uint8List rawPath) async {
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/assinatura.png");
    await file.writeAsBytes(rawPath);

    return file;
  }

}