import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../../../global/menu_data.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';

class FileManager {
  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    final FileManager fileManager = FileManager(); // FileManager 인스턴스 생성

    if (result != null) {
      File selectedFile = File(result.files.single.path!);
      return selectedFile;
    } else {
      print('파일 선택이 취소되었습니다.');
      return null;
    }
  }

  Future<void> init() async {
    // 여기에 초기화 로직을 추가. 예: 파일 시스템 초기화, 설정 로드 등
  }

  Future<List<FileItem>> getFiles() async {
    // 여기에 파일 목록을 가져오는 로직을 추가해야함.
    // 실제 파일 또는 디렉토리 목록을 반환하도록 구현해야 함.
    return [];
  }

  // 파일 또는 폴더 이름을 변경하는 함수
  // 파일 또는 폴더 이름 변경 함수
  void updateFileName(FileItem fileItem, String newName) {
    final String currentPath = fileItem.path;
    final String newPath = path.join(
      path.dirname(currentPath),
      newName,
    );

    final File file = File(currentPath);
    final Directory directory = Directory(currentPath);

    try {
      if (fileItem.isFolder) {
        directory.renameSync(newPath);
      } else {
        file.renameSync(newPath);
      }
      fileItem.path = newPath; // 파일 또는 폴더의 경로를 업데이트
    } catch (e) {
      print("파일 또는 폴더 이름 변경 중 오류 발생: $e");
    }
  }

  /* 주어진 디렉토리 및 폴더 내용 탐색 */
  Future<List<FileSystemEntity>> listFilesInDirectory(Directory dir) async {
    try {
      List<FileSystemEntity> files = dir.listSync();
      return files;
    } catch (e) {
      print('디렉토리를 읽는 도중 오류가 발생했습니다: $e');
      return [];
    }
  }

/* 폴더 이름 생성 메소드 */
  Future<String?> _askUserForFileName(BuildContext context,
      {String? defaultName}) async {
    TextEditingController controller = TextEditingController(text: defaultName);

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            '파일 또는 폴더 이름을 입력하세요',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: '새 폴더'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, null), // 취소 시 null 반환
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                String fileName = controller.text.trim();
                Navigator.pop(context,
                    fileName.isEmpty ? (defaultName ?? '새 폴더') : fileName);
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  /* 파일 생성 */
  Future<File?> addFile(BuildContext context) async {
    File? selectedFile = await pickFile();
    if (selectedFile != null) {
      print("selectedFile::::$selectedFile");
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      final File localFile = await selectedFile
          .copy('$appDocPath/${selectedFile.uri.pathSegments.last}');
      return localFile;
    }
    return null;
  }

/* 폴더 생성 */
  Future<Directory?> addFolder(BuildContext context, String currentFolderPath,
      {String? folderName}) async {
    String? newFolderName = await _askUserForFileName(context);
    if (newFolderName == null || newFolderName.isEmpty) return null;

    Directory newFolder =
        await Directory('$currentFolderPath/$newFolderName').create();
    return newFolder;
  }
}
