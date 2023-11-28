import 'package:get/get.dart';
import 'dart:async';
import '../../../service/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // JSON 처리를 위해 필요
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:typed_data';

class ConvertController extends GetxController {
  API api = API();
  var isLoading = false.obs;
  var isSuccess = false.obs;

  var fileNames = <String>[].obs;

  void updateFileNames(List<String> newFileNames) {
    fileNames.value = newFileNames;
  }

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
            'files', file.path,
            filename: file.path.split('/').last);
        request.files.add(multipartFile);
      }

      request.fields['extens'] = imgType;

      var response = await request.send();

      if (response.statusCode == 200) {
        isLoading.value = false;

        print("🔥🔥🔥🔥🔥🔥성공성공🔥🔥🔥🔥🔥");
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
    } catch (e) {
      print('Error Msg >>>> : $e');
    } finally {
      isLoading.value = false;
    }
  }

  /* file을 pdf로 변환 */
  Future<bool> convertFileToPdf(List<File> files) async {
    print("come on!!!!!!!!");

    isLoading.value = true;
    try {
      var request = http.MultipartRequest('POST', Uri.parse(api.fileToPdf));

      for (var file in files) {
        var multipartFile = await http.MultipartFile.fromPath(
            'files', file.path,
            filename: file.path.split('/').last);
        request.files.add(multipartFile);
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        String responseData = await response.stream.bytesToString();
        var json = jsonDecode(responseData);
        List<String> fileNames = List<String>.from(json['file_names']);
        updateFileNames(fileNames);

        // 각 파일에 대해 다운로드 및 저장 수행
        for (var fileName in fileNames) {
          await downloadAndSaveFile(fileName);
        }
        print("fileNames::::$fileNames");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('이미지 Error Msg >>>> : $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

/* 파일 다운로드 */
  Future<Uint8List?> downloadFile(List<String> fileNames) async {
    try {
      var response = await http.post(
        Uri.parse(api.downloadFile),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"filenames": fileNames}),
      );

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        print("Server error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Download error: $e");
      return null;
    }
  }

/* 변환된 파일 다운로드 */
  Future<void> downloadAndSaveFile(String fileName) async {
    var fileData = await downloadFile([fileName]);
    if (fileData != null) {
      await saveFileToExternalStorage(fileData, fileName);
    } else {
      print("File download failed");
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

  /* 유저의 외부 저장소에 저장하는 로직 */
  Future<void> saveFileToExternalStorage(
      Uint8List data, String fileName) async {
    // 외부 저장소 접근 권한 요청
    print('여기 들어오니111');

    var status = await Permission.storage.request();
    if (status.isGranted) {
      print('여기 들어오니2222');

      // 외부 저장소의 경로를 얻음
      final directory = await getExternalStorageDirectory();
      final filePath = '${directory!.path}/$fileName';
      final file = File(filePath);

      // 파일을 외부 저장소에 쓰기
      await file.writeAsBytes(data);
      print('File saved to $filePath');
    } else {
      print('Storage permission denied');
    }
  }
}
