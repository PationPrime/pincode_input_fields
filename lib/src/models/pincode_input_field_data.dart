library src.models.pincode_input_field_data;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class PincodeInputFieldData {
  final String text;
  final int length;
  final int? focusFieldIndex;

  const PincodeInputFieldData({
    this.text = "",
    this.length = 4,
    this.focusFieldIndex,
  });

  factory PincodeInputFieldData.empty() => const PincodeInputFieldData();

  PincodeInputFieldData copyWith({
    String? text,
    int? length,
    int? focusFieldIndex,
  }) =>
      PincodeInputFieldData(
        text: text ?? this.text,
        length: length ?? this.length,
        focusFieldIndex: focusFieldIndex ?? this.focusFieldIndex,
      );

  @override
  bool operator ==(Object other) =>
      other is PincodeInputFieldData &&
      other.runtimeType == runtimeType &&
      other.text == text &&
      other.length == length &&
      other.focusFieldIndex == focusFieldIndex;

  @override
  int get hashCode => Object.hashAll(
        [
          text,
          length,
          focusFieldIndex,
        ],
      );
}
