library src.controller;

import 'package:flutter/material.dart';

import '../models/models.dart';

part 'events.dart';

class PincodeInputFieldsController extends TextEditingController {
  late PincodeInputFieldData _pincodeInputFieldData;

  PincodeInputFieldData get pincodeInputFieldData => _pincodeInputFieldData;
  set pincodeInputFieldData(PincodeInputFieldData data) {
    if (_pincodeInputFieldData == data) return;
    _pincodeInputFieldData = data;
  }

  PincodeInputFieldsController({
    super.text,
  }) {
    _pincodeInputFieldData = PincodeInputFieldData.empty();
  }
}
