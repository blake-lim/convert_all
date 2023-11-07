import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';

class ImageViewer extends StatelessWidget {
  final String imagePath;
  final String name;

  ImageViewer({required this.imagePath, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Center(
        child: Image.file(
          File(imagePath),
        ),
      ),
    );
  }
}
