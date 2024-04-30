import 'package:flutter/material.dart';
import 'package:pincode_input_fields/pincode_input_fields.dart';

void main() {
  runApp(const PincodeInputFieldsApp());
}

class PincodeInputFieldsApp extends StatelessWidget {
  const PincodeInputFieldsApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          backgroundColor: const Color(0xFF1A1B20),
          body: Center(
            child: PincodeInputFields(
              length: 6,
              heigth: 54,
              width: 51,
              borderRadius: BorderRadius.circular(9),
              unfocusBorder: Border.all(
                width: 1,
                color: const Color(0xFF5B6774),
              ),
              focusBorder: Border.all(
                width: 1,
                color: const Color(0xFF9B71F4),
              ),
              cursorColor: Colors.white,
              cursorWidth: 2,
              focusFieldColor: const Color(0xFF2A2B32),
              unfocusFieldColor: const Color(0xFF2A2B32),
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 21,
              ),
            ),
          ),
        ),
      );
}
