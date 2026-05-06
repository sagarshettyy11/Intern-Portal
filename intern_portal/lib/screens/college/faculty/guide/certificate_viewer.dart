import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CertificateViewer extends StatelessWidget {
  final String fileUrl;
  const CertificateViewer({super.key, required this.fileUrl});
  @override
  Widget build(BuildContext context) {
    final isPdf = fileUrl.toLowerCase().endsWith('.pdf');
    return Scaffold(
      appBar: AppBar(
        title: Text("Certificate", style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
      ),
      body: isPdf ? SfPdfViewer.network(fileUrl) : InteractiveViewer(child: Center(child: Image.network(fileUrl))),
    );
  }
}
