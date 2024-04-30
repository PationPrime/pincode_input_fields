part of 'controller.dart';

abstract class InputFieldEvent {
  const InputFieldEvent();
}

class ClearInputFieldEvent extends InputFieldEvent {
  const ClearInputFieldEvent();
}

class InputFieldTextChangingEvent extends InputFieldEvent {
  const InputFieldTextChangingEvent();
}
