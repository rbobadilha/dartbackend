import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

class Servidor {
  static Future<void> initialize({
    required String endereco,
    required int porta,
    required Handler handler,
  }) async {
    await shelf_io.serve(handler, endereco, porta);
    print('Server running on: http://$endereco:$porta');
  }
}
