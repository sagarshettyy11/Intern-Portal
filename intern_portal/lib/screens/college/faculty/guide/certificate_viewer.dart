import 'dart:io';
import 'package:photo_view/photo_view.dart';
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

class AttachmentViewer extends StatelessWidget {
  final File file;
  const AttachmentViewer({super.key, required this.file});
  @override
  Widget build(BuildContext context) {
    final ext = file.path.split('.').last.toLowerCase();
    if (ext == 'pdf') {
      return Scaffold(
        appBar: AppBar(title: const Text('PDF Viewer')),
        body: SfPdfViewer.file(file),
      );
    }
    if (['png', 'jpg', 'jpeg', 'webp'].contains(ext)) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(backgroundColor: Colors.black),
        body: PhotoView(imageProvider: FileImage(file)),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Unsupported File')),
      body: const Center(child: Text('Preview not available for this file type')),
    );
  }
}
