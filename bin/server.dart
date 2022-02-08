import 'dart:io';
import 'package:chronos_dart/data_base.dart';
import 'package:chronos_dart/routes.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:dotenv/dotenv.dart' show load;

final overrideHeaders = {
  ACCESS_CONTROL_ALLOW_ORIGIN: '*',
  'Content-Type': 'application/json;charset=utf-8'
};

void main(List<String> args) async {
  try {
    DataBase db = DataBase();
    Routes rt = Routes();
    load();
    db.connect();
    // final ip = InternetAddress.anyIPv4;
    final ip = "127.0.0.1";
    final _handler = Pipeline()
        .addMiddleware(corsHeaders(headers: overrideHeaders))
        .addMiddleware(logRequests())
        .addHandler(rt.getRouter());
    final port = int.parse(Platform.environment['PORT'] ?? '8080');
    final server = await serve(_handler, ip, port);
    print('Server listening on port ${server.port}');
  } catch (e) {
    print(e);
  }
}
