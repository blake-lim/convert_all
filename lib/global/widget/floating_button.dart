import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dart:io';
import '../../feature/convert/controller/file_manager.dart';

Widget floatingButtons(
  BuildContext context,
  String currentFolderPath,
  Function(String) onAddFile,
  Function(String) onAddFolder, {
  bool showAddFolderButton = true,
}) {
  final FileManager fileManager = FileManager();

  return SpeedDial(
    animatedIcon: AnimatedIcons.add_event,
    animatedIconTheme: const IconThemeData(color: Colors.white, size: 35),
    visible: true,
    curve: Curves.bounceIn,
    backgroundColor: const Color(0xFF9747FF),
    buttonSize: const Size(80.0, 80.0),
    childrenButtonSize: const Size(56.0, 56.0),
    overlayColor: Colors.black,
    overlayOpacity: 0.5,
    children: [
      if (showAddFolderButton)
        // SpeedDialChild(
        //   child: const Icon(Icons.folder, color: Colors.white),
        //   label: "폴더 추가하기",
        //   labelStyle: const TextStyle(
        //     fontWeight: FontWeight.w400,
        //     color: Colors.white,
        //     fontSize: 13.0,
        //     fontFamily: 'Yeongdeok Snow Crab',
        //   ),
        //   backgroundColor: Colors.black,
        //   labelBackgroundColor: Colors.black,
        //   onTap: () async {
        //     Directory? newFolder =
        //         await fileManager.addFolder(context, currentFolderPath);
        //     if (newFolder != null) {
        //       onAddFolder(newFolder.path);
        //     }
        //   },
        // ),
        SpeedDialChild(
          child: const Icon(
            Icons.file_copy,
            color: Colors.black,
          ),
          label: "파일 추가하기",
          backgroundColor: Colors.white,
          labelBackgroundColor: Colors.white,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.black,
            fontSize: 13.0,
            fontFamily: 'Yeongdeok Snow Crab',
          ),
          onTap: () async {
            List<File>? newFile = await fileManager.addFile(context);
            if (newFile != null) {
              newFile.forEach((file) {
                onAddFile(file.path);
              });
            }
          },
        ),
    ],
  );
}
