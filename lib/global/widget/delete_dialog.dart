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
                  Navigator.of(context).pop(false);
                },
                child: const Text('아니오'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('예'),
              ),
            ],
          );
        },
      )) ??
      false;
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
                  Navigator.of(context).pop(false);
                },
                child: const Text('아니오'),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('예'),
              ),
            ],
          );
        },
      )) ??
      false;
}
