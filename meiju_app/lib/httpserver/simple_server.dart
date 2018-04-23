import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';

class SimpleServer {
  static HttpServer _server;
  static const String address = "localhost";
  static const int port = 8080;
  Map<String, String> jsonHeader() {
    return {
      "Content-Type": "application/json",
    };
  }

  Future _scheduleServer(Handler handler,
      {SecurityContext securityContext}) async {
    assert(_server == null);
    _server =
        await serve(handler, address, port, securityContext: securityContext);
  }

  void closeServer() async {
    if (_server != null) {
      await _server.close(force: true);
      _server = null;
    }
  }

  void startServer() async {
    var handler =
        const Pipeline().addMiddleware(logRequests()).addHandler(asyncHandler);
    await _scheduleServer(handler);
    print('Serving at http://${_server.address.host}:${_server.port}');
  }

  Future<Response> asyncHandler(Request request) => router(request);

  /// http 路由
  Future<Response> router(Request request) {
    switch (request.url.path) {
      case "moives":
        return loadAssetJson("moives_home.json");
      default:
        return new Future(
            () => new Response.ok("Hi,This is App Server for Data Test!"));
    }
  }

  Future<Response> loadAssetJson(String name) async {
    String jsonStr = await rootBundle.loadString('assets/data/$name');
    return new Response.ok(jsonStr, headers: jsonHeader());
  }

  Response syncHandler(Request request,
      {int statusCode, Map<String, String> headers}) {
    if (statusCode == null) statusCode = 200;
    return new Response(statusCode,
        headers: headers,
        body:
            'Hi,This is App Server for Data Test /n current path is ${request.requestedUri.path}');
  }
}

main(List<String> args) {
  SimpleServer simpleServer = new SimpleServer();
  simpleServer.startServer();
}

// Future<Response> loadDataJson(String name) async {
//   String path = "../../assets/data/$name.json";
//   String jsonStr = await new File(path).readAsString();
//   return new Response.ok(jsonStr, headers: jsonHeader());
// }
