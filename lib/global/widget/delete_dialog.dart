import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Future<bool> showDeleteDialog(context) async {
  return (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('파일 '),
            content: const Text('정말로 하시겠습니까?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // '아니오'를 클릭하면 false를 반환
                },
                child: const Text('아니오'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // '예'를 클릭하면 true를 반환
                },
                child: const Text('예'),
              ),
            ],
          );
        },
      )) ??
      false; // 다이얼로그가 닫히면 false를 반환 (예를 들어, 백 버튼을 눌러 닫은 경우)
}

Future<bool> showCupertinoDeleteDialog(BuildContext context) async {
  return (await showCupertinoDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('파일 '),
            content: const Text('정말로 하시겠습니까?'),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  Navigator.of(context).pop(false); // '아니오'를 클릭하면 false를 반환
                },
                child: const Text('아니오'),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.of(context).pop(true); // '예'를 클릭하면 true를 반환
                },
                child: const Text('예'),
              ),
            ],
          );
        },
      )) ??
      false;
}
