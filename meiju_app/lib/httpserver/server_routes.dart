import 'package:shelf/shelf.dart';
import 'dart:async';
import 'package:meiju_app/httpserver/simple_server.dart';

class ServerRoutes {
  static String path = 'assets/data/';

  /// http 路由
  Future<Response> router(Request request) {
    switch (request.url.path) {
      case "moives":
      // return new Future(
      //       () => new Response.notFound("Hi,This is App Server for Data Test!"));
        return SimpleServer.loadAssetJson("${path}moives_home.json");
      default:
        return new Future(
            () => new Response.ok("Hi,This is App Server for Data Test!"));
    }
  }
}
