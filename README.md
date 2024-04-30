# Pincode input fields
A Flutter plugin that provides a pin/otp code input widget.

## Quick start

```dart
    ...
    MaterialApp(
      home: Scaffold(
        body: Center(
            child: PincodeInputFields(),
          ),
        ),
      );
    ...
```

If you want to controll input, use PincodeInputFieldsController

```dart
...

final _controller = PincodeInputFieldsController();

    ...
    MaterialApp(
      home: Scaffold(
        body: Center(
            child: PincodeInputFields(
                controller: _controller,
            ),
          ),
        ),
      );
    ...
```
