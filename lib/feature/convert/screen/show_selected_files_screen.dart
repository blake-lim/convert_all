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
      body: GlobalStyledContainer(
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
              // DottedDivider(),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.selectedFile?.length ?? 0,
                  itemBuilder: (context, index) {
                    String fileName =
                        widget.selectedFile?[index].path.split('/').last ?? '';
                    return ListTile(
                      leading:
                          Icon(Icons.insert_drive_file, color: Colors.white),
                      title: Text(
                        fileName,
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            widget.selectedFile?.removeAt(index);
                          });
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
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFF855FCE)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    onPressed: () {},
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
