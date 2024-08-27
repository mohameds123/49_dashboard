import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../core/custom_dio/src/custom_dio.dart';

class AdPdfViewer extends StatelessWidget {
  final String pdfLink;

  const AdPdfViewer({super.key, required this.pdfLink});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: PdfView(
          scrollDirection: Axis.vertical,
          controller: PdfController(
            document: PdfDocument.openData(
              downloadFile(pdfLink),
            ),
          ),
        ),
      ),
    );
  }

  Future<Uint8List> downloadFile(String url) async {
    final path = (await getTemporaryDirectory()).path +
        const Uuid().v4() +
        url.split('.').last;
    await CustomDio().download(path: url, filePath: path);

    return File(path).readAsBytes();
  }
}
