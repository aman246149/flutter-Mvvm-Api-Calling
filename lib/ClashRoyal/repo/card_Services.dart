import 'dart:convert';
import 'dart:io';

import 'package:api/ClashRoyal/models/cards_list_model.dart';

import 'package:api/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CardServices {
  static Future<Map<String, dynamic>> getCards() async {
    List<Cards> cardsList = [];
    try {
      var url = Uri.parse(cardsUrl);
      var response =
          await http.get(url, headers: {'Authorization': 'Bearer ${apiKey}'});

      if (200 == response.statusCode) {
        print(200 == response.statusCode);
        var data = jsonDecode(response.body);

        for (var i = 0; i < data["items"].length; i++) {
          Cards cardsObject = Cards.fromJson(data["items"][i]);
          cardsList.add(cardsObject);
        }

        return {"cardsList": cardsList};
      }

      return {
        "errorResponse": "Invalid Response",
        "code": USER_INVALID_RESPONSE
      };
    } on HttpException {
      return {"errorResponse": "No Internet", "code": NO_INTERNET};
    } on FormatException {
      return {"errorResponse": "INVALID_FORMAT", "code": INVALID_FORMAT};
    } catch (e) {
      print(e.toString());
      return {"errorResponse": "UNKOWN_ERROR", "code": UNKOWN_ERROR};
    }
  }
}
