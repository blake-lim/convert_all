import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../controller/file_manager.dart';
import 'convert_screen.dart';
import './show_selected_files_screen.dart';

class SelectFileScreen extends StatefulWidget {
  final String conversionType;

  const SelectFileScreen({super.key, required this.conversionType});

  @override
  _SelectFileScreenState createState() => _SelectFileScreenState();
}

//테스트
class _SelectFileScreenState extends State<SelectFileScreen> {
  final FileManager fileManager = FileManager();

  @override
  Widget build(BuildContext context) {
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
                final selectedFile = await fileManager.pickFiles();
                if (selectedFile != null) {
                  await Get.to(ShowSelectedFilesScreen(
                      conversionType: widget.conversionType,
                      selectedFile: selectedFile));
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
