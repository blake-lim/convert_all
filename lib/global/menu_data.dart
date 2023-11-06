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
    'color': const Color(0xFF6EF685),
    'conversionType': 'IMGtoPDF',
  },
  {
    'text': 'EXCEL to PDF',
    'color': const Color(0xFFE6CCE7),
    'conversionType': 'EXCELtoPDF'
  },
  {
    'text': 'PPT to PDF',
    'color': const Color(0xFFF7606F),
    'conversionType': 'PPTtoPDF'
  },
  {
    'text': 'WORD to PDF',
    'color': const Color(0xFFFEE500),
    'conversionType': 'WORDtoPDF'
  },
];
final List<Map<String, Object>> convertFileToPdftMenuButtons = [
  {
    'text': 'PDF to JPEG',
    'color': const Color(0xFFF5EBE0),
    'conversionType': 'PDFtoJPEG'
  },
  {
    'text': 'PDF to PNG',
    'color': const Color(0xFFE08B8B),
    'conversionType': 'PDFtoPNG'
  },
  {
    'text': 'PDF to WORD',
    'color': const Color(0xFF7F90BF),
    'conversionType': 'PDFtoWORD'
  },
  {
    'text': 'PDF to EXCEL',
    'color': const Color(0xFF097045),
    'conversionType': 'PDFtoEXCEL'
  },
  {
    'text': 'PDF to PPT',
    'color': const Color(0xFFFFB169),
    'conversionType': 'PDFtoPPT'
  },
  {
    'text': 'PDF to BMP',
    'color': const Color(0xFFE33629),
    'conversionType': 'PDFtoBMP'
  },
  {
    'text': 'PDF to TIFF',
    'color': const Color(0xFFD9D9D9),
    'conversionType': 'PDFtoTIFF'
  },
];
