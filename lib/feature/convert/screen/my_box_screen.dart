import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/widget/floating_button.dart';
import '../../../global/menu_data.dart';
import '../../../global/widget/delete_dialog.dart';
import 'package:path_provider/path_provider.dart';
import '../../../global/widget/file_list_state.dart';
import '../../../global/widget/empty_file_state.dart';
import 'package:path/path.dart' as path;

class MyBoxScreen extends StatefulWidget {
  const MyBoxScreen({super.key});

  @override
  MyBoxScreenState createState() => MyBoxScreenState();
}

class MyBoxScreenState extends State<MyBoxScreen> {
  List<FileItem> files = [];
  String currentFolderPath = "여기에 초기 폴더 경로를 설정하세요";

  final FocusNode focusNode = FocusNode();

  Future<void> _loadFiles() async {
    final Directory folder = Directory(currentFolderPath);

    /* 폴더가 존재하지 않는 경우 함수를 종료. */
    if (!await folder.exists()) {
      return;
    }

    /* 폴더 내의 모든 파일과 폴더 목록을 가져옴. */
    List<FileSystemEntity> entities = await folder.list().toList();

    /* 목록을 FileItem 객체의 리스트로 변환하여 `files` 상태 변수에 저장. */
    setState(() {
      files = entities
          .map((entity) =>
              FileItem(path: entity.path, isFolder: entity is Directory))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();

    _initFolder().then((_) {
      _loadFiles();
    });

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        _loadFiles();
      }
    });
    _loadFiles();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  Future<void> _initFolder() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    setState(() {
      currentFolderPath = appDocDir.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF30302E),
      appBar: AppBar(
        title: const Text(
          '보관함',
          style: TextStyle(
            fontFamily: 'Yeongdeok Snow Crab',
          ),
        ),
        centerTitle: true,
        elevation: files.isEmpty ? 0 : 1,
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
      body: Padding(
        padding: const EdgeInsets.only(
          top: 40.0,
          left: 10.0,
        ),
        child: files.isEmpty
            ? EmptyState()
            : FileList(
                files: files,
                onFileDeleted: (index) async {
                  bool shouldDelete = false;
                  if (Platform.isIOS) {
                    shouldDelete = await showCupertinoDeleteDialog(context);
                  } else {
                    shouldDelete = await showDeleteDialog(context);
                  }

                  if (shouldDelete) {
                    final FileItem fileItem = files[index];
                    final FileSystemEntity entity = fileItem.isFolder
                        ? Directory(fileItem.path)
                        : File(fileItem.path);

                    try {
                      await entity.delete(recursive: true);
                      setState(() {
                        files.removeAt(index);
                      });
                    } catch (e) {
                      print("Error deleting file/folder: $e");
                    }
                  }
                },
                onFileRenamed: (fileItem, newName) {
                  if (fileItem is FileItem && (fileItem as FileItem).isFolder) {
                    final index = files.indexOf(fileItem as FileItem);
                    if (index >= 0) {
                      setState(() {
                        final newPath = path.join(
                            path.dirname((fileItem as FileItem).path), newName);
                        files[index].path = newPath;
                      });
                    }
                  }
                },
              ),
      ),
      floatingActionButton: floatingButtons(
        context,
        currentFolderPath,
        (String filePath) {
          try {
            final newFileItem = FileItem(path: filePath, isFolder: false);
            setState(() {
              files.add(newFileItem);
              print("파일 추가: $filePath");
            });
          } catch (e) {
            print("파일을 추가하는 중 오류 발생: $e");
          }
        },
        (String folderPath) {
          setState(() {
            files.insert(0, FileItem(path: folderPath, isFolder: true));
          });
        },
      ),
    );
  }
}
