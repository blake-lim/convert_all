import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import '../../feature/convert/screen/folder_screen.dart';
import '../../global/menu_data.dart';
import '../../feature/convert/controller/file_manager.dart';
import '../widget/pdf_viewer.dart';
import '../widget/image_viewer.dart';

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

  /* 이름변경 */
  _showRenameDialog(index, fileItem) async {
    String? newName;
    newName = await showDialog<String>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Rename'),
          content: TextField(
            decoration: const InputDecoration(
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
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(newName);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
    if (newName != null) {
      print("뉴네임 $newName");
      // 파일인 경우 이름 변경
      fileManager.updateFileName(fileItem, newName!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.files.length,
      itemBuilder: (context, index) {
        FileItem fileItem = widget.files[index];

        String fileName = path.basename(fileItem.path);
        print("파일 리스트에서 파일 네임 $fileName");
        print("파일 리스트에서 확장자 ${fileItem.isFolder}");

        /* 파일 뷰어로 오픈 */
        void openViewer(FileItem fileItem) {
          /* 파일 확장자 결정 */
          String fileExtension = path.extension(fileItem.path).toLowerCase();

          if (fileItem.isFolder) {
            /* 폴더 처리 */
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FolderScreen(folderPath: fileItem.path),
              ),
            );
          } else if (fileExtension == '.jpeg' ||
              fileExtension == '.jpg' ||
              fileExtension == '.png' ||
              fileExtension == '.BMP' ||
              fileExtension == 'TIFF') {
            /* 이미지 뷰어 실행 */
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImageViewer(imagePath: fileItem.path),
              ),
            );
          } else if (fileExtension == '.pdf') {
            /* PDF 뷰어 실행 */
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PDFViewer(pdfPath: fileItem.path),
              ),
            );
          }
        }

        return ListTile(
          leading: fileItem.isFolder
              ? const Icon(Icons.folder_open, color: Colors.yellow)
              : const Icon(Icons.file_copy, color: Colors.blue),
          onTap: () {
            openViewer(fileItem); // 파일이나 폴더를 열기 위한 함수 호출
          },
          title: Text(
            fileName,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          trailing: PopupMenuButton<String>(
            icon: const Icon(Icons.more_horiz, color: Colors.white),
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
