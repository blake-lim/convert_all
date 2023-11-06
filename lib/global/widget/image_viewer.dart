import 'package:flutter/material.dart';
import 'dart:io'; // 'File' 클래스를 사용하려면 임포트해야 합니다.

class ImageViewer extends StatelessWidget {
  final String imagePath;

  ImageViewer({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Viewer'),
      ),
      body: Center(
        child: Image.file(
          File(imagePath), // 이미지 파일의 경로를 전달하여 이미지 표시
        ),
      ),
    );
  }
}
