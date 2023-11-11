import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/file_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../global/widget/ad_manager.dart';
import '../../../global/global_style.dart';

class ConvertScreen extends StatefulWidget {
  final String conversionType;

  const ConvertScreen({super.key, required this.conversionType});

  @override
  _ConvertScreenState createState() => _ConvertScreenState();
}

class _ConvertScreenState extends State<ConvertScreen> {
  final FileManager fileManager = FileManager();

  final AdManager adManager = AdManager();

  bool isConverting = true;

  @override
  void initState() {
    super.initState();
    adManager.initialize();

    // 임의의 시간 후 변환 완료 시 호출 (테스트용)
    Future.delayed(const Duration(seconds: 150), () {
      setState(() {
        isConverting = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
        backgroundColor: const Color(0xFF30302E),
        child: Column(
          children: [
            // if (isConverting) LoadingIndicator(),
            Center(
              child: Lottie.asset(
                'assets/lotties/loading.json',
                height: 150,
                width: screenWidth,
                fit: BoxFit.fitWidth,
                repeat: true,
              ),
            ),
            Expanded(
              child: Center(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Yeongdeok Snow Crab',
                    ),
                    children: <TextSpan>[
                      const TextSpan(text: '열심히 '),
                      TextSpan(
                        text: '변환',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.amber[900],
                        ),
                      ),
                      const TextSpan(text: '하고 있어요!'),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              width: adManager.bannerAd.size.width.toDouble(),
              height: adManager.bannerAd.size.height.toDouble(),
              child: AdWidget(ad: adManager.bannerAd),
            ),
          ],
        ),
      ),
    );
  }
}
