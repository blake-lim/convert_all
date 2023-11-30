import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

class PDFViewer extends StatelessWidget {
  final String pdfPath;
  final String name;
  PDFViewer({required this.pdfPath, required this.name});

  @override
  Widget build(BuildContext context) {
    print("뷰어");
    return Scaffold(
      backgroundColor: const Color(0xFF30302E),
      appBar: AppBar(
        title: Text(
          /* 속한 폴더의 이름으로 타이틀 설정 */
          name,
          style: const TextStyle(
            fontFamily: 'Yeongdeok Snow Crab',
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF30302E),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Get.back(result: null);
              },
            );
          },
        ),
      ),
      body: PDFView(
        filePath: pdfPath,
      ),
    );
  }
}
