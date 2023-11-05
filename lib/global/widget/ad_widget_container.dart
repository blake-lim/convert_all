import 'package:flutter/material.dart';
import 'ad_manager.dart'; // AdManager 클래스가 정의된 파일을 임포트합니다.
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdWidgetContainer extends StatefulWidget {
  const AdWidgetContainer({super.key});

  @override
  _AdWidgetContainerState createState() => _AdWidgetContainerState();
}

class _AdWidgetContainerState extends State<AdWidgetContainer> {
  final AdManager adManager = AdManager();

  @override
  void initState() {
    super.initState();
    adManager.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: adManager.bannerAd.size.width.toDouble(),
      height: adManager.bannerAd.size.height.toDouble(),
      child: AdWidget(ad: adManager.bannerAd),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Ad Example'),
      ),
      body: AdWidgetContainer(),
    ),
  ));
}
