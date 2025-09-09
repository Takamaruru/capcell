import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_selector/file_selector.dart';

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

Future<void> pickFolderAndListFiles() async {
  // フォルダ選択ダイアログを表示
  final path = await getDirectoryPath();
  if (path == null) {
    print("フォルダが選択されませんでした");
    return;
  }

  final dir = Directory(path);

  // フォルダ内のファイル・ディレクトリを取得
  final entities = dir.listSync();

  for (var entity in entities) {
    if (entity is File) {
      print("File: ${entity.path}");
    } else if (entity is Directory) {
      print("Dir : ${entity.path}");
    }
  }
}
