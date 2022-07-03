import 'dart:io';
import 'parser_extension.dart';

class Env {
  static Map<String, String> _map = {};
  static String _fileName = '.env';

  Env._();

  factory Env.fromFile(String fileName) {
    _fileName = fileName;
    return Env._();
  }

  static Future<T> get<T>({required String key}) async {
    if (_map.isEmpty) await _loadLines();
    return _map[key]!.toType(T);
  }

  static Future<void> _loadLines() async {
    List<String> linhas = await _readFileLines();
    _map = {for (String lin in linhas) lin.split('=')[0]: lin.split('=')[1]};
  }

  static Future<List<String>> _readFileLines() async {
    return await File(_fileName).readAsLines();
  }
}
