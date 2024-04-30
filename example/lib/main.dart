import 'package:flutter/material.dart';
import 'package:pincode_input_fields/pincode_input_fields.dart';

void main() {
  runApp(const PincodeInputFieldsApp());
}

class PincodeInputFieldsApp extends StatelessWidget {
  const PincodeInputFieldsApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: Scaffold(
          body: Center(
            child: PincodeInputFields(),
          ),
        ),
      );
}
