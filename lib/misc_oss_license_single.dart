import 'package:flutter/material.dart';

class MiscOssLicenseSingle extends StatelessWidget {
  final String name;
  final Map<String, dynamic> json;

  String get version => json['version'];
  String get description => json['description'];
  String get licenseText => json['license'];

  MiscOssLicenseSingle({required this.name, required this.json});

  String _bodyText() {
    return licenseText.split('\n').map((line) {
      if (line.startsWith('//')) line = line.substring(2);
      line = line.trim();
      return line;
    }).join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF30302E),
      ),
      body: Container(
          color: const Color(0xFF30302E),
          child: ListView(children: <Widget>[
            if (description != null)
              Padding(
                padding:
                    const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
                child: Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            const Divider(),
            Padding(
              padding:
                  const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
              child: Text(
                _bodyText(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ])),
    );
  }
}
