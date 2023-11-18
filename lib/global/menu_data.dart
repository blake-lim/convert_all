import 'package:flutter/material.dart';

class FileItem {
  String _path; // private 변수로 변경
  final bool isFolder;
  final String? svgPath;

  FileItem({required String path, required this.isFolder, this.svgPath})
      : _path = path; // 생성자에서 _path를 초기화

  String get path => _path; // path의 getter

  set path(String newPath) {
    _path = newPath; // path의 setter
  }
}

final List<Map<String, Object>> convertPdfToFiletMenuButtons = [
  {
    'text': 'IMG to PDF',
    'color': const Color(0xFFef476f),
    'conversionType': 'IMGtoPDF',
  },
  {
    'text': 'EXCEL to PDF',
    'color': const Color(0xFF06d6a0),
    'conversionType': 'EXCELtoPDF'
  },
  {
    'text': 'PPT to PDF',
    'color': const Color(0xFFf05742),
    'conversionType': 'PPTtoPDF'
  },
  {
    'text': 'WORD to PDF',
    'color': const Color(0xFF1b9aaa),
    'conversionType': 'WORDtoPDF'
  },
];
final List<Map<String, Object>> convertFileToPdftMenuButtons = [
  {
    'text': 'PDF to JPEG',
    'color': const Color(0xFFffca3a),
    'conversionType': 'PDFtoJPEG'
  },
  {
    'text': 'PDF to JPG',
    'color': const Color(0xFF8ac926),
    'conversionType': 'PDFtoPNG'
  },
  {
    'text': 'PDF to PNG',
    'color': const Color(0xFF1982c4),
    'conversionType': 'PDFtoPNG'
  },
  {
    'text': 'PDF to GIF',
    'color': const Color(0xFF6a4c93),
    'conversionType': 'PDFtoPNG'
  },
  {
    'text': 'PDF to BMP',
    'color': const Color(0xFF87c38f),
    'conversionType': 'PDFtoPNG'
  },
  // {
  //   'text': 'PDF to WORD',
  //   'color': const Color(0xFF7F90BF),
  //   'conversionType': 'PDFtoWORD'
  // },
  // {
  //   'text': 'PDF to EXCEL',
  //   'color': const Color(0xFF097045),
  //   'conversionType': 'PDFtoEXCEL'
  // },
  // {
  //   'text': 'PDF to PPT',
  //   'color': const Color(0xFFE33629),
  //   'conversionType': 'PDFtoPPT'
  // },
  // {
  //   'text': 'PDF to BMP',
  //   'color': const Color(0xFFF0F2F5),
  //   'conversionType': 'PDFtoBMP'
  // },
  // {
  //   'text': 'PDF to TIFF',
  //   'color': const Color(0xFFD9D9D9),
  //   'conversionType': 'PDFtoTIFF'
  // },
];
