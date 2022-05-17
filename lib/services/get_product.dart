
import 'dart:convert';

import 'package:now_app_test/model/product_to_dart_model.dart';
import 'package:http/http.dart' as http;

Future<ProductToDartModel> getProDuct()async{
  final response = await http
      .get(Uri.parse('https://jsonkeeper.com/b/YIDG'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ProductToDartModel.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}