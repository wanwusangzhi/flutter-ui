import 'package:dio/dio.dart';
import 'dart:io';

class RestApi {
  RestApi();
  static Dio _dio;
  static getDio([options]) {
    if (RestApi._dio != null) {
      return RestApi._dio;
    }
    Dio dio = new Dio(options);
    // proxy
    dio.onHttpClientCreate = (HttpClient client) {
      // client.findProxy = (uri) {
      //   print(Index.proxyUrl);
      //   return Index.proxyUrl;
      // };
    };
    RestApi._dio = dio;
    return dio;
  }

  static request({method, url, data}) async {
    Response<dynamic> response;
    if (method == 'get') {
      response = await RestApi.getDio().get(url, data: data);
    } else {
      response = await RestApi.getDio().post(url, data: data);
    }
    return response.data;
  }

  // dio.post('/test', data: {id:'123'})
  static post(url, [data]) async{
    return await RestApi.getDio().post(url, data: data);
  }

  // dio.get('/test', {data: {}})
  // dio.get('/test?id=123')
  static get(url, [data]) async {
    return await RestApi.getDio().get(url, data: data);
  }
}
