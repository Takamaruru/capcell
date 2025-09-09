import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<void> openVSCodeFromFlutter(String filePath) async {
  final url = Uri.parse('http://127.0.0.1:5000/open_vscode');

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'file_path': filePath}),
  );

  if (response.statusCode == 200) {
    print('VSCode opened successfully');
  } else {
    print('Error: ${response.body}');
  }
}

void read() async {
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  final file = File('$path/hoge.txt');

  // ファイルがあった時だけ読み込む
  if (await file.exists()) {
    final data = await file.readAsString();
    print(data);
  }
}
