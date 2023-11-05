import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../controller/file_manager.dart';
import './about_project.dart';
import '../../../oss_licenses_page.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

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
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  '설정',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SettingTile(
              icon: Icons.layers_clear,
              title: '광고제거(유료)',
              onTap: () {},
            ),
            SettingTile(
              icon: Icons.help,
              title: '다바꿔는 어떤 앱인가요?',
              onTap: () {
                Get.to(const AboutApp());
              },
            ),
            SettingTile(
              icon: Icons.list,
              title: '오픈소스 라이센스',
              onTap: () {
                Get.to(const OssLicensesPage());
              },
            ),
            SettingTile(
              icon: Icons.cloud_upload,
              title: '자주 묻는 질문',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SettingTile({
    required this.icon,
    required this.title,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      child: ListTile(
        leading: Icon(icon, color: Colors.amber),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        onTap: onTap,
      ),
    );
  }
}
