import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF30302E),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                '프로젝트 다바꿔',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.greenAccent[700],
                  fontFamily: 'Yeongdeok Snow Crab',
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              '다바꿔는 모바일 환경에 최적화되어 사용자들이 간편하게 문서 및 이미지 파일을 PDF로 변환할 수 있는 기능을 제공해요! \n뿐만 아니라, PDF 파일을 다른 형식의 파일로 변환하는 역방향 기능도 지원합니다. 이러한 다양한 파일 변환 기능을 통해 사용자는 언제 어디서든 필요한 문서 작업을 빠르고 효율적으로 수행할 수 있어요.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              '주요 기능:',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Yeongdeok Snow Crab',
                fontWeight: FontWeight.w300,
                color: Colors.deepPurpleAccent[400],
              ),
            ),
            ..._buildFeatureTexts([
              '이미지 to PDF 변환: 갤러리나 카메라에서 선택한 이미지들을 PDF 파일로 변환할 수 있어요.',
              'Word, Excel 등 to PDF 변환: 다양한 텍스트 기반 문서 파일들을 PDF로 변환할 수 있어요.',
              'PDF to 이미지/텍스트 변환: PDF 문서를 이미지 파일이나 텍스트 파일로 변환할 수 있어요.',
            ]),
            const SizedBox(height: 16.0),
            Text(
              '모바일 환경에 최적화된 디자인:',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.deepPurpleAccent[400],
                fontFamily: 'Yeongdeok Snow Crab',
                fontWeight: FontWeight.w300,
              ),
            ),
            const Text(
              '다바꿔는 터치 스크린 사용에 최적화된 인터페이스를 갖추고 있어, 모든 기능들을 손쉽게 접근하고 사용할 수 있어요. 큼직한 버튼과 직관적인 메뉴 구조를 통해 사용자는 복잡한 설정 없이도 바로 원하는 작업을 시작할 수 있어요.',
              style: TextStyle(
                color: Colors.white,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              '사용 편의성:',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Yeongdeok Snow Crab',
                fontWeight: FontWeight.w300,
                color: Colors.deepPurpleAccent[400],
              ),
            ),
            const Text(
              '이미지나 문서를 PDF로 변환하는 과정은 몇 번의 탭만으로 완료할 수 있으며, 변환된 파일은 바로 다운로드할 수 있어요.',
              style: TextStyle(
                color: Colors.white,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              '안전성과 프라이버시:',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Yeongdeok Snow Crab',
                fontWeight: FontWeight.w300,
                color: Colors.deepPurpleAccent[400],
              ),
            ),
            const Text(
              '모든 파일 변환 작업은 사용자의 기기에서 직접 처리되며, 개인 정보 보호를 위해 외부 서버로 전송되지 않아요. 사용자의 데이터는 앱 내에서 안전하게 관리되며, 프라이버시는 철저히 보호되요!',
              style: TextStyle(
                color: Colors.white,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFeatureTexts(List<String> features) {
    return features
        .map(
          (feature) => Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              '• $feature',
              style: const TextStyle(
                color: Colors.white,
                height: 1.5,
              ),
            ),
          ),
        )
        .toList();
  }
}
