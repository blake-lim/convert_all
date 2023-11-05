import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/widget/floating_button.dart';
import '../../../global/menu_data.dart';
import '../../../global/widget/delete_dialog.dart';
import 'package:path/path.dart' as path;
import '../../../global/widget/file_list_state.dart';
import '../../../global/widget/empty_file_state.dart';

class FolderScreen extends StatefulWidget {
  final String folderPath;

  const FolderScreen({Key? key, required this.folderPath}) : super(key: key);

  @override
  _FolderScreenState createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  List<FileItem> files = [];

  late Directory folder;

  /* 폴더의 내용을 다시 로드하는 메소드 */
  void reloadFolder() {
    setState(() {
      folder = Directory(widget.folderPath);
    });
  }

  @override
  void initState() {
    super.initState();
    folder = Directory(widget.folderPath);
    _loadFiles();
  }

  void _loadFiles() async {
    /* 디렉토리의 파일과 폴더 목록을 로드 */
    List<FileSystemEntity> entities = await folder.list().toList();
    setState(() {
      files = entities
          .map((e) => FileItem(path: e.path, isFolder: e is Directory))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF30302E),
      appBar: AppBar(
        title: Text(
          /* 속한 폴더의 이름으로 타이틀 설정 */
          path.basename(widget.folderPath),
          style: const TextStyle(
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
        // child: files.isEmpty ? buildEmptyState() : _buildFileList(),
        child: files.isEmpty
            ? const EmptyState()
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
                      // Here, you can show an error message to the user.
                    }
                  }
                },
                /* TODO:추후 고도화로 2depth이상 이름 변경기능 제공 예정 */
                onFileRenamed: (fileItem, newName) {
                  // 수정 필요
                  if (fileItem is FileItem && (fileItem as FileItem).isFolder) {
                    // 폴더인 경우에만 이름 변경을 허용
                    final index = files.indexOf(fileItem as FileItem);
                    if (index >= 0) {
                      setState(() {
                        // 파일 이름 변경
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
        showAddFolderButton: false,
        folder.path, // 현재 디렉토리 경로를 전달
        (String folderPath) {
          setState(() {
            files.insert(0, FileItem(path: folderPath, isFolder: true));
          });
        },
        (String filePath) {
          setState(() {
            files.add(FileItem(path: filePath, isFolder: false));
          });
          reloadFolder();
        },
      ),
    );
  }
}
