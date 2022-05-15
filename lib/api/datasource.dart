
import 'dart:developer' as dev;

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riadh_pfe/api/constants.dart';

import 'package:riadh_pfe/models/history.dart';

import '../utils/exception.dart';

class UbidotsRepository{

  final http.Client client = http.Client();
  UbidotsRepository();

  Future<HistoryModel> getHistory() async {
    dev.log("getHistory");
    final response =
    await client.get(
      Uri.parse(Constants.fetchHistoryUrl),
      headers: {"X-Auth-Token": Constants.token}
    );

    if (response.statusCode == 200) {
      return HistoryModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException("${response.statusCode}");
    }
  }

  Future<String> getLastValue() async {
    dev.log("getLastValue");
    final response =
    await client.get(
      Uri.parse(Constants.fetchLastValueUrl),
        headers: {"X-Auth-Token": Constants.token}
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw ServerException("${response.statusCode}");
    }
  }

}