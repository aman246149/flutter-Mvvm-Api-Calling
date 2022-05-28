import 'package:api/ClashRoyal/models/cards_list_model.dart';

import 'package:api/ClashRoyal/repo/card_Services.dart';
import "package:flutter/material.dart";

class CardsViewModel extends ChangeNotifier {
  //constructor
  CardsViewModel() {
    print("called");
    getCards();
  }

  //variables

  bool _loading = false;
  List<Cards> _cardslistModel = [];
  bool _isError = false;
  Map<String, dynamic> _errorMessageWithCode = {};

//getters
  bool get loading => _loading;
  List<Cards> get cardsListModel => _cardslistModel;
  bool get isError => _isError;
  Map<String, dynamic> get errorMessageWithCode => _errorMessageWithCode;

//setters

  setError(bool error) {
    _isError = error;
  }

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setCardListModel(List<Cards> cardsListModel) {
    _cardslistModel = cardsListModel;
  }

  setErrorMessageWithCode(Map<String, dynamic> erorrMessageWithCode) {
    _errorMessageWithCode = erorrMessageWithCode;
  }

  //calling our services

  getCards() async {
    setLoading(true);
    var response = await CardServices.getCards();

    if (response["errorResponse"] != null) {
      setError(true);
      setErrorMessageWithCode(response);

    } else {
      setCardListModel(response["cardsList"]);
    }
    setLoading(false);
  }
}
