import 'package:flutter/material.dart';
import './misc_oss_license_single.dart';
import 'oss_licenses.dart';

class OssLicensesPage extends StatelessWidget {
  const OssLicensesPage({super.key});

  static Future<List<String>> loadLicenses() async {
    // merging non-dart based dependency list using LicenseRegistry.
    final ossKeys = ossLicenses.keys.toList();
    return ossKeys..sort();
  }

  static final _licenses = loadLicenses();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF30302E),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF30302E),
          title: const Text('오픈소스 라이센스'),
        ),
        body: FutureBuilder<List<String>>(
            future: _licenses,
            builder: (context, snapshot) {
              return ListView.separated(
                  padding: const EdgeInsets.all(0),
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final key = snapshot.data![index];
                    final licenseJson = ossLicenses[key];
                    final version = licenseJson['version'];
                    final desc = licenseJson['description'];
                    return ListTile(
                        title: Text(
                          '$key ${version ?? ''}',
                          style: const TextStyle(
                            color: Colors.amber,
                          ),
                        ),
                        subtitle: desc != null
                            ? Text(
                                desc,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            : null,
                        trailing: Icon(Icons.chevron_right),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => MiscOssLicenseSingle(
                                    name: key, json: licenseJson))));
                  },
                  separatorBuilder: (context, index) => const Divider());
            }));
  }
}
