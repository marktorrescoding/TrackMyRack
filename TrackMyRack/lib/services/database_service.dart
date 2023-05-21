import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

Future<void> updateDatabase() async {
  final localVersion = await getLocalVersion();
  final remoteVersion = await getRemoteVersion();

  if (remoteVersion > localVersion) {
    await downloadAndReplaceDatabase();
    await saveLocalVersion(remoteVersion);
  }
}

Future<int> getLocalVersion() async {
  // Fetch the local version from shared preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('db_version') ?? 0;
}

Future<int> getRemoteVersion() async {
  // Fetch the version.txt from GitHub
  var url = 'https://raw.githubusercontent.com/marktorrescoding/myrackdb/main/version';
  var response = await http.get(Uri.parse(url));

  // Parse the version number
  return int.parse(response.body.trim());
}

Future<void> downloadAndReplaceDatabase() async {
  // Download geardb.db from GitHub
  var url = 'https://raw.githubusercontent.com/marktorrescoding/myrackdb/main/geardb.db';
  var response = await http.get(Uri.parse(url));

  // Get the path to the local database file
  var documentsDirectory = await getApplicationDocumentsDirectory();
  var dbPath = join(documentsDirectory.path, 'geardb.db');

  // Write the downloaded data to the local database file
  await File(dbPath).writeAsBytes(response.bodyBytes);
}

Future<void> saveLocalVersion(int version) async {
  // Save the new version number to shared preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('db_version', version);
}
