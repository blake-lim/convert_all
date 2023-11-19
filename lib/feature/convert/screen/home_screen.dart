import 'package:flutter/material.dart';
import '../../../global/global_style.dart';
import '../../../feature/convert/screen/select_file_screen.dart';
import '../../../global/menu_data.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import '../../../feature/convert/screen/my_box_screen.dart';
import '../../../feature/convert/screen/setting_screen.dart';

import '../../../global/widget/ad_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final AdManager adManager = AdManager();

//   Widget _buildButton(
//       String text, Color color, BuildContext context, String conversionType) {
//     return SizedBox(
//       width: 130,
//       height: 100,
//       child: ElevatedButton(
//         onPressed: () {
//           Get.to(
//               () => SelectFileScreen(
//                     conversionType: conversionType,
//                     selectedFiles: [],
//                   ),
//               transition: Transition.noTransition);
//         },
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(horizontal: 8),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           elevation: 12,
//           backgroundColor: color,
//         ),
//         child: Center(
//           child: Text(
//             text,
//             style: const TextStyle(
//               color: Colors.black,
//               fontSize: 14,
//               fontFamily: 'Pretendards',
//               fontWeight: FontWeight.w900,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     adManager.initialize();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 175, 175, 171),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF30302E),
//         elevation: 0.0,
//         leading: Builder(
//           builder: (BuildContext context) {
//             return IconButton(
//               icon: const Icon(Icons.apps),
//               onPressed: () {
//                 Scaffold.of(context).openDrawer();
//               },
//             );
//           },
//         ),
//       ),
//       drawer: Drawer(
//         backgroundColor: Colors.amber,
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             const DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.red,
//               ),
//               child: Center(
//                 child: Text(
//                   '프로젝트 다바꿔',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontFamily: 'Yeongdeok Snow Crab',
//                     fontSize: 24,
//                   ),
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(
//                 Icons.move_to_inbox_outlined,
//                 size: 28,
//                 color: Colors.green,
//               ),
//               title: const Text(
//                 '보관함',
//                 style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.black,
//                     fontFamily: 'Yeongdeok Snow Crab',
//                     fontWeight: FontWeight.w500),
//               ),
//               onTap: () {
//                 Get.to(MyBoxScreen());
//               },
//             ),
//             ListTile(
//               leading: const Icon(
//                 Icons.settings,
//                 size: 28,
//                 color: Colors.green,
//               ),
//               title: const Text(
//                 '설정',
//                 style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.black,
//                     fontFamily: 'Yeongdeok Snow Crab',
//                     fontWeight: FontWeight.w500),
//               ),
//               onTap: () {
//                 Get.to(const SettingScreen());
//               },
//             ),
//           ],
//         ),
//       ),
//       body: GlobalStyledContainer(
//         applySafeArea: true,
//         child: Column(
//           children: [
//             Lottie.asset(
//               'assets/lotties/main_screen_lottie.json',
//               width: screenWidth,
//               height: 170,
//               fit: BoxFit.fitWidth,
//               repeat: true,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Expanded(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.symmetric(vertical: 10.0),
//                         child: Text(
//                           'PDF로 변환',
//                           style: TextStyle(
//                               fontSize: 24,
//                               fontFamily: 'Yeongdeok Snow Crab',
//                               color: Colors.white),
//                         ),
//                       ),
//                       ...List.generate(convertPdfToFiletMenuButtons.length,
//                           (index) {
//                         return Container(
//                           margin: EdgeInsets.only(bottom: 10),
//                           child: _buildButton(
//                             convertPdfToFiletMenuButtons[index]['text']
//                                 as String,
//                             convertPdfToFiletMenuButtons[index]['color']
//                                 as Color,
//                             context,
//                             convertPdfToFiletMenuButtons[index]
//                                 ['conversionType'] as String,
//                           ),
//                         );
//                       }),
//                     ],
//                   ),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: convertFileToPdftMenuButtons.length,
//                       itemBuilder: (context, index) {
//                         return Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             if (index == 0) // 첫 번째 항목에만 텍스트를 표시
//                               const Padding(
//                                 padding: EdgeInsets.symmetric(vertical: 10.0),
//                                 child: Text(
//                                   '이미지로 변환',
//                                   style: TextStyle(
//                                       fontSize: 24,
//                                       fontFamily: 'Yeongdeok Snow Crab',
//                                       color: Colors.white),
//                                 ),
//                               ),
//                             Container(
//                               margin: EdgeInsets.only(bottom: 10),
//                               child: _buildButton(
//                                 convertFileToPdftMenuButtons[index]['text']
//                                     as String,
//                                 convertFileToPdftMenuButtons[index]['color']
//                                     as Color,
//                                 context,
//                                 convertFileToPdftMenuButtons[index]
//                                     ['conversionType'] as String,
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               width: adManager.bannerAd.size.width.toDouble(),
//               height: adManager.bannerAd.size.height.toDouble(),
//               child: AdWidget(ad: adManager.bannerAd),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AdManager adManager = AdManager();

  @override
  void initState() {
    super.initState();
    adManager.initialize();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 175, 175, 171),
      appBar: AppBar(
        backgroundColor: const Color(0xFF30302E),
        elevation: 0.0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.apps),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF30302E),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Center(
                child: Text(
                  '프로젝트 다바꿔',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Yeongdeok Snow Crab',
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.move_to_inbox_outlined,
                size: 28,
                color: Colors.green,
              ),
              title: const Text(
                '보관함',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: 'Yeongdeok Snow Crab',
                    fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Get.to(const MyBoxScreen());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                size: 28,
                color: Colors.green,
              ),
              title: const Text(
                '설정',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: 'Yeongdeok Snow Crab',
                    fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Get.to(const SettingScreen());
              },
            ),
          ],
        ),
      ),
      body: GlobalStyledContainer(
        applySafeArea: true,
        child: Column(
          children: [
            Lottie.asset(
              'assets/lotties/main_screen_lottie.json',
              width: screenWidth,
              height: 170,
              fit: BoxFit.fitWidth,
              repeat: true,
            ),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                '파일로 변환',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Yeongdeok Snow Crab',
                    color: Colors.white),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: convertFileToPdftMenuButtons.length,
                itemBuilder: (ctx, index) => Container(
                    width: 122,
                    margin: const EdgeInsets.only(right: 10),
                    child: _buildButton(
                        convertFileToPdftMenuButtons[index]['text'] as String,
                        convertFileToPdftMenuButtons[index]['color'] as Color,
                        context,
                        convertFileToPdftMenuButtons[index]['conversionType']
                            as String)),
              ),
            ),
            const SizedBox(height: 40),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'PDF로 변환',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Yeongdeok Snow Crab',
                    color: Colors.white),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: convertPdfToFiletMenuButtons.length,
                itemBuilder: (ctx, index) => Container(
                  width: 122,
                  margin: const EdgeInsets.only(right: 10),
                  child: _buildButton(
                    convertPdfToFiletMenuButtons[index]['text'] as String,
                    convertPdfToFiletMenuButtons[index]['color'] as Color,
                    context,
                    convertPdfToFiletMenuButtons[index]['conversionType']
                        as String,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Spacer(),
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

Widget _buildButton(
    String text, Color color, BuildContext context, String conversionType) {
  return ElevatedButton(
    onPressed: () {
      Get.to(
          () => SelectFileScreen(
                conversionType: conversionType,
                selectedFiles: [],
              ),
          transition: Transition.noTransition);
    },
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
      elevation: 12,
      backgroundColor: color,
    ),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: 'Pretendards',
          fontWeight: FontWeight.w900,
        ),
      ),
    ),
  );
}
