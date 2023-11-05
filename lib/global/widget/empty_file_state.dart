import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -0.3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/svgs/empty_files.svg',
            fit: BoxFit.contain,
            width: 300,
            height: 300,
          ),
          const Text(
            '문서함이 비어있어요',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontFamily: 'Yeongdeok Snow Crab',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Yeongdeok Snow Crab',
              ),
              children: <TextSpan>[
                const TextSpan(
                  text: '하단 ',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                const TextSpan(
                  text: '플러스',
                  style: TextStyle(
                    color: Colors.amber,
                  ),
                ),
                const TextSpan(
                  text: ' 버튼을 눌러 파일을 ',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: '추가해보세요!',
                  style: TextStyle(
                    color: Colors.greenAccent[400],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
