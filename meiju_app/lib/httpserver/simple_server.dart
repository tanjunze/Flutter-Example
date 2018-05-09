import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'package:meiju_app/httpserver/server_routes.dart';

class SimpleServer {
  static HttpServer _server;
  static const String address = "localhost";
  static const int port = 8080;
  ServerRoutes routes;
  SimpleServer() {
    routes = new ServerRoutes();
  }
  static Map<String, String> jsonHeader() {
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

  Future<Response> asyncHandler(Request request) => routes.router(request);

  static Future<Response> loadAssetJson(String path) async {
    //
    String jsonStr = await rootBundle.loadString(path);
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
