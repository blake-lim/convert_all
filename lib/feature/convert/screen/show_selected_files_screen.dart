import 'package:convert_project/feature/convert/controller/convert_controller.dart';
import 'package:convert_project/global/global_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/file_manager.dart';
import 'dart:io';

class ShowSelectedFilesScreen extends StatefulWidget {
  final String conversionType;
  final List<File>? selectedFile;

  const ShowSelectedFilesScreen(
      {super.key, required this.conversionType, required this.selectedFile});

  @override
  _ShowSelectedFilesScreenState createState() =>
      _ShowSelectedFilesScreenState();
}

//테스트
class _ShowSelectedFilesScreenState extends State<ShowSelectedFilesScreen> {
  final FileManager fileManager = FileManager();
  final ConvertController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    print("conversionType:::${widget.conversionType}");
    print("selectedFile:::${widget.selectedFile}");
    List<File>? selectedFiles = widget.selectedFile;

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
      body: Stack(
        children: [
          GlobalStyledContainer(
            applySafeArea: true,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Colors.amber,
                  width: 1.0,
                ),
              ),
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 12.0, bottom: 6.0),
                    child: Center(
                      child: Text(
                        '선택된 파일',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'Yeongdeok Snow Crab',
                        ),
                      ),
                    ),
                  ),
                  // Obx(
                  //   () => controller.isLoading.value
                  //       ? const Center(child: CircularProgressIndicator())
                  //       : const SizedBox.shrink(),
                  // ),
                  // DottedDivider(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.selectedFile?.length ?? 0,
                      itemBuilder: (context, index) {
                        String fileName =
                            widget.selectedFile?[index].path.split('/').last ??
                                '';
                        String filePath =
                            widget.selectedFile?[index].path ?? '';
                        Color iconColor = getFileIconColor(filePath);
                        return ListTile(
                          leading:
                              Icon(Icons.insert_drive_file, color: iconColor),
                          title: Text(
                            fileName,
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("파일 삭제"),
                                    content: const Text("이 파일을 삭제하시겠습니까?"),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text("취소"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text(
                                          "삭제",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            widget.selectedFile
                                                ?.removeAt(index);
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF855FCE)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (selectedFiles != null) {
                            if (widget.conversionType.startsWith("PDFto")) {
                              // "PDFto" 부분을 제거하고 확장자만 추출
                              String extension = widget.conversionType
                                  .substring(5)
                                  .toLowerCase();

                              // 서버로 넘겨줄 확장자를 인자로 전달
                              await controller.convertPdfToImg(
                                  selectedFiles, extension);
                            } else if (widget.conversionType == "PDFtoDocx") {
                              // PDF를 Docx로 변환하는 API 호출
                              await controller.convertPdfToDocx(selectedFiles);
                            } else if (widget.conversionType == "FiletoPDF") {
                              // 파일을 PDF로 변환하는 API 호출
                              await controller.convertFileToPdf(selectedFiles);
                            } else {
                              // 지원하지 않는 변환 유형 처리
                              print("지원하지 않는 변환 유형입니다.");
                            }
                          }
                        },
                        child: const Text(
                          '확인',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Yeongdeok Snow Crab',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
          Obx(() => controller.isLoading.value
              ? Container(
                  color: Colors.black.withOpacity(0.5), // 반투명 배경
                  child: Center(
                      child: CircularProgressIndicator()), // 중앙에 로딩 인디케이터
                )
              : SizedBox.shrink()),
        ],
      ),
    );
  }
}

Color getFileIconColor(String filePath) {
  String extension = filePath.split('.').last.toLowerCase();
  switch (extension) {
    case 'pdf':
      return Colors.red;
    case 'xls':
    case 'xlsx':
      return Colors.green;
    case 'png':
    case 'jpg':
    case 'jpeg':
      return Colors.yellow;
    case 'doc':
    case 'docx':
      return Colors.blue;
    default:
      return Colors.purple; // 기본 색상
  }
}
