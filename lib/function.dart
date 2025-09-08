import 'dart:convert';
import 'package:http/http.dart' as http;

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
