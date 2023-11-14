import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';
import 'package:get/get.dart';

class OfficeViewer extends StatelessWidget {
  final String filePath;
  final String name;

  OfficeViewer({Key? key, required this.filePath, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF30302E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF30302E),
        title: Text(
          /* 속한 폴더의 이름으로 타이틀 설정 */
          name,
          style: const TextStyle(
            fontFamily: 'Yeongdeok Snow Crab',
          ),
        ),
        centerTitle: true,
        elevation: 0,
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
      body: Center(
        child: ElevatedButton(
          onPressed: () => _openFile(filePath),
          child: const Text("파일 열기"),
        ),
      ),
    );
  }

  void _openFile(String filePath) {
    final File file = File(filePath);
    if (file.existsSync()) {
      OpenFile.open(filePath);
    } else {
      print("File does not exist");
    }
  }
}
