import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:epm/utils/app_color.dart';
import 'package:flutter/material.dart';

class PdfViewScreen extends StatefulWidget {
  final String pdfUrl;
  PdfViewScreen({super.key, required this.pdfUrl});

  @override
  State<PdfViewScreen> createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  PDFDocument? document;

  initialPdf() async {
    document = await PDFDocument.fromURL(widget.pdfUrl);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    initialPdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: document != null
            ? PDFViewer(document: document!)
            : Center(
                child: CircularProgressIndicator(
                  color: AppColor.deepOrange,
                ),
              ));
  }
}
