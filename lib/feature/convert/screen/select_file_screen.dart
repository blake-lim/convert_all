import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../controller/file_manager.dart';
import 'convert_screen.dart';
import './show_selected_files_screen.dart';
import 'dart:io';

class SelectFileScreen extends StatefulWidget {
  final String conversionType;
  final List<File>? selectedFiles;

  const SelectFileScreen({
    super.key,
    required this.conversionType,
    this.selectedFiles,
  });

  @override
  _SelectFileScreenState createState() => _SelectFileScreenState();
}

class _SelectFileScreenState extends State<SelectFileScreen> {
  final FileManager fileManager = FileManager();

  /* 변환 타입 변수로 추출 */
  String getConversionTypeText() {
    int toIndex = widget.conversionType.indexOf('to');
    if (toIndex != -1) {
      return widget.conversionType.substring(0, toIndex).trim();
    }
    return widget.conversionType;
  }

  @override
  Widget build(BuildContext context) {
    print("컨버전 타입 :::${widget.conversionType}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF30302E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        color: const Color(0xFF30302E),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            GestureDetector(
              onTap: () async {
                final List<File>? selectedFiles = await fileManager.pickFiles();
                if (selectedFiles != null && selectedFiles.isNotEmpty) {
                  String filePath = selectedFiles.first.path;

                  if (!await fileManager.isValidFileType(
                      filePath, widget.conversionType)) {
                    // 파일 유형이 변환 유형과 맞지 않는 경우
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("잘못된 파일 유형"),
                          content: Text(
                              "선택한 파일 유형이 ${getConversionTypeText()}와(과) 일치하지 않습니다. 올바른 파일을 선택해주세요."),
                          actions: [
                            TextButton(
                              child: const Text("닫기"),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // 파일 유형이 맞는 경우
                    await Get.to(ShowSelectedFilesScreen(
                        conversionType: widget.conversionType,
                        selectedFile: selectedFiles));
                  }
                }
              },
              child: Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/svgs/convert_menu.svg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 84),
            const Center(
              child: Text(
                '문서를 선택하세요!',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                  children: <TextSpan>[
                    TextSpan(text: '변환한 문서는 보관함에 '),
                    TextSpan(
                      text: '자동저장',
                      style: TextStyle(
                          color: Color(0xFF6EF685),
                          fontWeight: FontWeight.w600),
                    ),
                    TextSpan(text: ' 됩니다!'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
