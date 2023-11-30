import 'package:get/get.dart';
import 'dart:async';
import '../../../global/menu_data.dart';
import '../../../service/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

class ConvertController extends GetxController {
  API api = API();
  var files = <FileItem>[].obs;

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
        String responseData = await response.stream.bytesToString();
        var json = jsonDecode(responseData);
        List<String> fileNames = List<String>.from(json['file_names']);
        updateFileNames(fileNames);
        isLoading.value = false;
        // 각 파일에 대해 다운로드 및 저장 수행
        for (var fileName in fileNames) {
          await downloadAndSaveFile(fileName);
        }
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
  Future<bool> convertPdfToDocx(List<File> files) async {
    isLoading.value = true;
    try {
      var request = http.MultipartRequest('POST', Uri.parse(api.pdfTodocx));

      // for (var file in files) {
      //   var stream = http.ByteStream(file.openRead());
      //   var length = await file.length();
      //   var multipartFile = http.MultipartFile('file', stream, length,
      //       filename: file.path.split('/').last);
      //   request.files.add(multipartFile);
      // }
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
        // await deleteFile(response);
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
      await saveFileToUserSelectedLocation(fileData, fileName);
      /*  파일 삭제*/

      await deleteFile(fileName);

      // var newFileItem = FileItem(path: fileName, isFolder: false);
      // files.add(newFileItem); // 파일 목록에 새 항목 추가
      print("File downloaded and added: $fileName");
    } else {
      print("File download failed");
    }
  }
  // Future<void> downloadAndSaveFile(String fileName) async {
  //   var fileData = await downloadFile([fileName]);
  //   if (fileData != null) {
  //     /* 파일을 내 저장소에 저장하는 기 */
  //     // await saveFileToInternalDocuments(
  //     //     fileData, fileName); // 파일을 내부 문서 디렉토리에 저장
  //     // var newFileItem = FileItem(path: fileName, isFolder: false);
  //     // files.add(newFileItem); // 파일 목록에 새 항목 추가
  //     saveFileToUserSelectedLocation();
  //     print("File downloaded and saved: $fileName");
  //   } else {
  //     print("File download failed");
  //   }
  // }

//   Future<void> downloadAndSaveFile(String fileName) async {
//   var fileData = await downloadFile([fileName]);
//   if (fileData != null) {
//     await saveFileToExternalStorage(fileData, fileName); // 파일을 외부 저장소에 저장
//     var newFileItem = FileItem(path: fileName, isFolder: false);
//     files.add(newFileItem); // 파일 목록에 새 항목 추가
//     print("File downloaded and saved: $fileName");
//   } else {
//     print("File download failed");
//   }
// }

  /* 변환된 파일 삭제 */
  Future<void> deleteFile(String fileName) async {
    print("딜리트 자체를 안타네");
    isLoading.value = true;
    try {
      var response = await http.delete(
        Uri.parse(api.deleteFile),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "filenames": [fileName] // 파일 이름을 배열로 보내는 경우
        }),
      );

      if (response.statusCode == 200) {
        print('File successfully deleted: $fileName');
      } else {
        print('Error deleting file: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during file deletion: $e');
    } finally {
      isLoading.value = false;
    }
  }
/* 유저의 내부 문서 디렉토리에 파일을 저장하는 로직 */
  // Future<void> saveFileToInternalDocuments(
  //     Uint8List data, String fileName) async {
  //   // 내부 문서 디렉토리의 경로를 얻음
  //   final directory = await getApplicationDocumentsDirectory();
  //   final filePath = '${directory.path}/$fileName';
  //   final file = File(filePath);

  //   // 파일을 내부 문서 디렉토리에 쓰기
  //   await file.writeAsBytes(data);
  //   print('File saved to $filePath');
  // }

  /* 유저의 외부 저장소에 저장하는 로직 */
//   Future<void> saveFileToExternalStorage(
//       Uint8List data, String fileName) async {
//     // 외부 저장소 접근 권한 요청
//     print('여기 들어오니111');

//     var status = await Permission.storage.request();
//     if (status.isGranted) {
//       print('status.isGranted::${status.isGranted}');

//       // 외부 저장소의 경로를 얻음
//       final directory = await getExternalStorageDirectory();
//       final filePath = '${directory!.path}/$fileName';
//       final file = File(filePath);

//       // 파일을 외부 저장소에 쓰기
//       await file.writeAsBytes(data);
//       print('File saved to $filePath');
//     } else {
//       print('Storage permission denied');
//     }
//   }
// }

/* 유저가 파일 저장 장소를 선택하게 하는 로직 */
  Future<void> saveFileToUserSelectedLocation(
      Uint8List data, String fileName) async {
    // 사용자가 폴더를 선택할 수 있도록 함
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory == null) {
      // 사용자가 폴더 선택을 취소한 경우
      print('No directory selected');
      return;
    }

    // 선택한 경로에 파일 생성
    String filePath = '$selectedDirectory/$fileName';
    File file = File(filePath);

    // 파일에 데이터 쓰기
    await file.writeAsBytes(data);
    print('File saved to $filePath');
  }
}
