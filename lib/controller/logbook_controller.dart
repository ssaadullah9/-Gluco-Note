import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:syncfusion_flutter_pdf/pdf.dart';
import '/model.dart';
class LogBookController extends GetxController{

  var currentSortColumn = 0.obs;
  var isAscending = true.obs;

  Future<void> createPDF() async {
    PdfDocument document =  PdfDocument();
    final page = document.pages.add();
    page.graphics.drawString(
        'Hello World!', PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 0, 50, 20));

    List<int> bytes = document.save();
    document.dispose();

    saveAndLaunchFile(bytes, 'Output.pdf');
  }
}