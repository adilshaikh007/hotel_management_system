// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pdfWid;
// import 'package:printing/printing.dart';

// class PrintPdf extends StatefulWidget {
//   const PrintPdf({super.key});

//   @override
//   State<PrintPdf> createState() => _PrintPdfState();
// }

// class _PrintPdfState extends State<PrintPdf> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PdfPreview(
//         maxPageWidth: MediaQuery.of(context).devicePixelRatio * 0.5,
//         build: (format) => _createPdf(format),
//       ),
//     );
//   }
// }

// Future<Uint8List> _createPdf(
//   PdfPageFormat format,
// ) async {
//   final pdf = pdfWid.Document(
//     version: PdfVersion.pdf_1_4,
//     compress: true,
//   );
//   pdf.addPage(
//     pdfWid.Page(
//       pageFormat: PdfPageFormat((80 * (72.0 / 25.4)), 600,
//           marginAll: 5 * (72.0 / 25.4)),
//       //pageFormat: format,
//       build: (context) {
//         return pdfWid.SizedBox(
//           width: double.infinity,
//           child: pdfWid.FittedBox(
//               child: pdfWid.Column(
//                   mainAxisAlignment: pdfWid.MainAxisAlignment.start,
//                   children: [
//                 pdfWid.Text("Follow",
//                     style: pdfWid.TextStyle(
//                         fontSize: 35, fontWeight: pdfWid.FontWeight.bold)),
//                 pdfWid.Container(
//                   width: 250,
//                   height: 1.5,
//                   margin: pdfWid.EdgeInsets.symmetric(vertical: 5),
//                   color: PdfColors.black,
//                 ),
//                 pdfWid.Container(
//                   width: 300,
//                   child: pdfWid.Text("#30FlutterTips",
//                       style: pdfWid.TextStyle(
//                         fontSize: 35,
//                         fontWeight: pdfWid.FontWeight.bold,
//                       ),
//                       textAlign: pdfWid.TextAlign.center,
//                       maxLines: 5),
//                 ),
//                 pdfWid.Container(
//                   width: 250,
//                   height: 1.5,
//                   margin: pdfWid.EdgeInsets.symmetric(vertical: 10),
//                   color: PdfColors.black,
//                 ),
//                 pdfWid.Text("Lakshydeep Vikram",
//                     style: pdfWid.TextStyle(
//                         fontSize: 25, fontWeight: pdfWid.FontWeight.bold)),
//                 pdfWid.Text("Follow on Medium, LinkedIn, GitHub",
//                     style: pdfWid.TextStyle(
//                         fontSize: 25, fontWeight: pdfWid.FontWeight.bold)),
//               ])),
//         );
//       },
//     ),
//   );
//   return pdf.save();
// }
