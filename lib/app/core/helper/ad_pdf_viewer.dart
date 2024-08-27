
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

import '../custom_dio/src/custom_dio.dart';


class AdPdfViewer extends StatefulWidget {
  final String pdfLink;

  const AdPdfViewer({Key? key, required this.pdfLink}) : super(key: key);

  @override
  State<AdPdfViewer> createState() => _AdPdfViewerState();
}

class _AdPdfViewerState extends State<AdPdfViewer> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: PdfView(
          scrollDirection: Axis.vertical,
          controller: PdfController(
            document: PdfDocument.openData(
              CustomDio().downloadFileAsBytes(widget.pdfLink),
            ),
          ),
        ),
      ),
    );
  }
}
