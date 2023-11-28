import 'package:get/get.dart';
import 'dart:async';
import '../../../service/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // JSON 처리를 위해 필요
import 'dart:io';

class ConvertController extends GetxController {
  API api = API();
  var isLoading = false.obs;
  var isSuccess = false.obs;

  /* pdf를 image로 변환 */
  Future<bool> convertPdfToImg(List<File> files, String imgType) async {
    isLoading.value = true;
    try {
      if (files.isEmpty) {
        print('파일이 없습니다.');
        return false;
      }
      var request = http.MultipartRequest('POST', Uri.parse(api.pdfToImg));

      for (var file in files) {
        var multipartFile = await http.MultipartFile.fromPath(
            'files', // 파일 필드
            file.path,
            filename: file.path.split('/').last);
        request.files.add(multipartFile);
      }

      // 추가 필드 'extens' 설정
      request.fields['extens'] = imgType;

      var response = await request.send();

      if (response.statusCode == 200) {
        isLoading.value = false;

        print("성공성공!!!");
        return true;
      } else {
        isLoading.value = false;

        return false;
      }
    } catch (e) {
      isLoading.value = false;

      print('Error Msg >>>> : $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /* pdf를 Docx로 변환 */
  Future<void> convertPdfToDocx(List<File> files) async {
    isLoading.value = true;
    try {
      var request = http.MultipartRequest('POST', Uri.parse(api.pdfTodocx));

      for (var file in files) {
        var stream = http.ByteStream(file.openRead());
        var length = await file.length();
        var multipartFile = http.MultipartFile('file', stream, length,
            filename: file.path.split('/').last);
        request.files.add(multipartFile);
      }

      var response = await request.send();
      // 여기에 응답 처리 로직을 추가하세요
    } catch (e) {
      print('Error Msg >>>> : $e');
    } finally {
      isLoading.value = false;
    }
  }

  /* file을 pdf로 변환 */
  Future<bool> convertFileToPdf(List<File> files) async {
    isLoading.value = true;
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://127.0.0.1:8000/convert/file-to-pdf'));

      for (var file in files) {
        var multipartFile = await http.MultipartFile.fromPath(
            'files', // 서버가 요구하는 필드 이름 'files'
            file.path,
            filename: file.path.split('/').last);
        request.files.add(multipartFile);
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error Msg >>>> : $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

/* 변환된 파일 다운로드 */
  Future<void> downloadFile(String fileName) async {
    isLoading.value = true;
    try {
      var response = await http.post(
        Uri.parse(api.downloadFile),
        body: jsonEncode(
          {"filenames": fileName},
        ),
      );
      /* 인증 성공 */
      if (response.statusCode == 200) {}
    } catch (e) {
      print('이메일 인증코드 발생 Error Msg >>>> : $e');
    } finally {
      isLoading.value = false;
    }
  }

  /* 변환된 파일 삭제 */
  Future<void> deleteFile(String fileName) async {
    isLoading.value = true;
    try {
      var response = await http.post(
        Uri.parse(api.deleteFile),
        body: jsonEncode(
          {"filenames": fileName},
        ),
      );
      /* 비밀번호 재설정 이메일인증 성공 */

      /* 다른 방법 시도가 아닌, 인증성공 정상 루트 */
    } catch (e) {
      print('이메일 인증 Error Msg >>>> : $e');
    } finally {
      isLoading.value = false;
    }
  }
}
