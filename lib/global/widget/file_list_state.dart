import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import '../../feature/convert/screen/folder_screen.dart';
import '../../global/menu_data.dart';
import 'dart:io';
import '../../feature/convert/controller/file_manager.dart';

class FileList extends StatefulWidget {
  final List<FileItem> files; // 'files' 변수를 생성자 매개변수로 추가

  final Function(int, String) onFileRenamed;
  final Function(int) onFileDeleted;

  const FileList({
    Key? key,
    required this.onFileRenamed,
    required this.onFileDeleted,
    required this.files,
  }) : super(key: key);

  @override
  _FileListState createState() => _FileListState(files: []);
}

class _FileListState extends State<FileList> {
  late FileManager fileManager; // 'fileManager'를 미리 선언
  List<FileItem> files = [];

  _FileListState({required List<FileItem> files}) {
    fileManager = FileManager();

    this.files = files;
    fileManager = FileManager(); // 'fileManager' 필드를 생성자에서 초기화
  }
  @override
  void initState() {
    super.initState();
    fileManager = FileManager();
    initFileManager();
  }

  Future<void> initFileManager() async {
    await fileManager.init(); // 파일 관리자 초기화
    final List<FileItem> updatedFiles =
        await fileManager.getFiles(); // 파일 목록 가져오기
    setState(() {
      files = updatedFiles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.files.length,
      itemBuilder: (context, index) {
        FileItem fileItem = widget.files[index];
        String fileName = path.basename(fileItem.path);

        _showRenameDialog(index, fileItem) async {
          String? newName; // newName 변수를 선언합니다.
          newName = await showDialog<String>(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: Text('Rename'),
                content: TextField(
                  decoration: InputDecoration(
                    labelText: 'New Name',
                  ),
                  controller:
                      TextEditingController(text: path.basename(fileItem.path)),
                  onChanged: (value) {
                    newName = value;
                  },
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop(null);
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop(newName);
                    },
                    child: Text('Confirm'),
                  ),
                ],
              );
            },
          );

          if (newName != null) {
            // 파일 이름이 null이 아닌 경우에만 업데이트
            fileManager.updateFileName(fileItem, newName!);
            // newName 변수를 null이 아닌 값으로 강제 언래핑
          }
        }

        return ListTile(
          leading: fileItem.isFolder
              ? Icon(Icons.folder_open, color: Colors.yellow)
              : Icon(Icons.file_copy, color: Colors.blue),
          onTap: () {
            if (fileItem.isFolder) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FolderScreen(folderPath: fileItem.path),
                ),
              );
            }
          },
          title: Text(
            fileName,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          trailing: PopupMenuButton<String>(
            icon: Icon(Icons.more_horiz, color: Colors.white),
            onSelected: (String result) async {
              if (result == 'delete') {
                widget.onFileDeleted(index);
              } else if (result == 'rename') {
                _showRenameDialog(index, fileItem);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'delete',
                child: Text('삭제'),
              ),
              const PopupMenuItem<String>(
                value: 'rename',
                child: Text('이름 변경'),
              ),
            ],
          ),
        );
      },
    );
  }
}
