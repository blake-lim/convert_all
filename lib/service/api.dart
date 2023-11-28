import 'package:flutter_dotenv/flutter_dotenv.dart';

class API {
  late final String baseUrl;

  API() {
    baseUrl = dotenv.env['BASE_API_KEY'] ?? '';
  }
  // pdf를 image로 변환
  String get pdfToImg => '$baseUrl/convert/pdf-to-image';
  // pdf를 Docx로 변환
  String get pdfTodocx => '$baseUrl/convert/pdf-to-docx';
  // file을 pdf로 변환
  String get fileToPdf => '$baseUrl/convert/file-to-pdf';

  // 변환된 파일 다운로드
  String get downloadFile => '$baseUrl/download-file';

  // 변환된 파일 삭제
  String get deleteFile => '$baseUrl/delete-files';
}
