import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:meiju_app/models/moive.dart';
import 'meiju_api.dart';
import 'package:meiju_app/models/moive.dart';
import 'package:utf/utf.dart';
import 'package:http/http.dart' as http;
import 'package:meiju_app/httpserver/simple_server.dart';

class MeijuApiImpl implements MeijuApi {
  static var httpClient = new HttpClient();
  static const _BASE_URL =
      "http://${SimpleServer.address}:${SimpleServer.port}";
  List<MoiveGroup> moiveGroup = <MoiveGroup>[];

  @override
  Future<List<MoiveGroup>> getRecommendMoive({bool refresh}) async {
    if (refresh || moiveGroup.isEmpty) {
      print("moiveGroup.isEmpty");
      await _requestRecommendData();
    }
    return moiveGroup;
  }

  _requestRecommendData() async {
    var url = '$_BASE_URL/moives';
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.OK) {
      var json = await response.transform(utf8.decoder).join();
      HomeBean homeBean = new HomeBean.fromJson(jsonDecode(json));
      moiveGroup.addAll(homeBean.items);
    } else {
      throw new Exception("请求错误statusCode==${response.statusCode}");
    }
  }
}

requestData() async {
  var url = 'http://192.168.24.117:5500/web/home.json';
  final response = await http.get(url);
  final responseJson = jsonDecode(response.body);
  return new HomeBean.fromJson(responseJson).items;
}

// try {

// } catch (exception) {}
