import 'package:dio/dio.dart';

import '../../constants/strings.dart';

class WebServices {
  late Dio dio;

  WebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
    );

    dio = Dio(options);
  }

  Future<Map<String, dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('character');
      print(response.data.toString()); // Debugging: Check what you get
      return response.data; // Return the whole response for parsing
    } catch (e) {
      print(e.toString());
      return {}; // Return an empty map on error
    }
  }

  Future<Map<String, dynamic>> getAllLocations() async {
    try {
      Response response = await dio.get('location');
      print(response.data.toString()); // Debugging: Check what you get
      return response.data; // Return the whole response for parsing
    } catch (e) {
      print(e.toString());
      return {}; // Return an empty map on error
    }
  }
}
