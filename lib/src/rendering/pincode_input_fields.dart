library src.rendering.pincode_input_fields;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../controller/controller.dart';

class PincodeInputFields extends StatefulWidget {
  final PincodeInputFieldsController? controller;
  final int length;
  final bool autoFocus;
  final Function(String)? onChanged;
  final Function()? onInputComplete;
  final bool showError;
  final bool enabled;
  final TextStyle? textStyle;
  final double heigth;
  final double width;
  final double marginBetweenFileds;
  final Duration animationDuration;
  final Border? focusBorder;
  final Border? unfocusBorder;
  final Border? errorBorder;
  final Border? disabledBorder;
  final BoxDecoration? customFieldDecoration;
  final Color? cursorColor;
  final MainAxisAlignment mainAxisAlignment;
  final double cursorHeight;
  final double cursorWidth;
  final BoxShape boxShape;
  final BorderRadius? borderRadius;
  final Radius? cursorBorderRadius;
  final bool focusFieldAfterCodeInsert;
  final List<BoxShadow>? boxShadow;
  final Color? focusFieldColor;
  final Color? unfocusFieldColor;
  final Color? errorFieldColor;
  final Color? disableFieldColor;
  final bool removeAllBorders;
  final bool dismissKeyboardOnTapOutsideOfFields;
  final Function(PointerDownEvent)? onTapOutside;
  final bool obscure;
  final String obscuringCharacter;

  const PincodeInputFields({
    super.key,
    this.controller,
    this.length = 4,
    this.onChanged,
    this.onInputComplete,
    this.autoFocus = false,
    this.showError = false,
    this.enabled = true,
    this.textStyle,
    this.heigth = 40,
    this.width = 40,
    this.marginBetweenFileds = 10,
    this.animationDuration = const Duration(milliseconds: 150),
    this.focusBorder,
    this.unfocusBorder,
    this.errorBorder,
    this.disabledBorder,
    this.customFieldDecoration,
    this.cursorColor,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.cursorHeight = 25,
    this.cursorWidth = 3,
    this.boxShape = BoxShape.rectangle,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(5),
    ),
    this.cursorBorderRadius,
    this.focusFieldAfterCodeInsert = false,
    this.boxShadow,
    this.focusFieldColor,
    this.unfocusFieldColor,
    this.disableFieldColor,
    this.errorFieldColor,
    this.removeAllBorders = false,
    this.dismissKeyboardOnTapOutsideOfFields = true,
    this.onTapOutside,
    this.obscure = false,
    this.obscuringCharacter = '•',
  });

  @override
  State<PincodeInputFields> createState() => _PincodeInputFieldsState();
}

class _PincodeInputFieldsState extends State<PincodeInputFields> {
  PincodeInputFieldsController? _mainController;

  final List<TextEditingController> _controllers = [];
  final List<FocusNode> _focusNodes = [];
  final _fallbackFocusNode = FocusNode();

  void _createControllers() {
    _mainController = widget.controller ?? PincodeInputFieldsController();

    for (int i = 0; i < widget.length; i++) {
      final controller = TextEditingController();
      final focusNode = FocusNode();
      _controllers.add(controller);
      _focusNodes.add(focusNode);
    }
  }

  void _mainControllerListener() => _mainController!.addListener(
        () => setState(() {}),
      );

  void _focusListener() => setState(() {});

  void _addFocusListeners() {
    _removeFocusListeners();

    for (final focus in _focusNodes) {
      focus.addListener(_focusListener);
    }
  }

  void _removeFocusListeners() {
    for (final focus in _focusNodes) {
      focus.removeListener(_focusListener);
    }
  }

  void _disposeFocusNodes() {
    for (final focus in _focusNodes) {
      focus.dispose();
    }
  }

  void _disposeControllers() {
    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].dispose();
    }
  }

  void _clearAllControllers() {
    for (final controller in _controllers) {
      controller.clear();
    }
  }

  void _insertCode(
    String code,
  ) {
    if (code.isEmpty) {
      _clearAllControllers();
      return;
    }

    for (int i = 0; i < code.length; i++) {
      _controllers[i].text = code[i];
    }

    if (widget.focusFieldAfterCodeInsert) {
      _focusNodes.last.requestFocus();
    }
  }

  void _onChanged(String value, int i) {
    String codeString = "";

    if (_controllers[i].value.text.isNotEmpty && i < _controllers.length - 1) {
      _focusNodes[i].nextFocus();
    } else {
      if (i > 0 && value.isEmpty) {
        _focusNodes[i].previousFocus();
      }
    }

    for (final controller in _controllers) {
      codeString += controller.value.text;
    }

    _mainController!.text = codeString;

    if (codeString.isEmpty) {
      _focusNodes.first.requestFocus();
    } else if (codeString.length == _controllers.length) {
      _focusNodes.last.requestFocus();
    }

    widget.onChanged?.call(codeString);

    if (codeString.length == widget.length) {
      widget.onInputComplete?.call();
    }
  }

  @override
  void initState() {
    super.initState();
    _createControllers();
    _mainControllerListener();
    _addFocusListeners();
  }

  void _unfocusEachField() {
    for (final focusNode in _focusNodes) {
      focusNode.unfocus();
    }
  }

  @override
  void didUpdateWidget(covariant PincodeInputFields oldWidget) {
    if (oldWidget.enabled != widget.enabled && !widget.enabled) {
      _unfocusEachField();
      _fallbackFocusNode.unfocus();
    }

    if (oldWidget.controller != widget.controller) {
      _controllers.clear();
      _createControllers();
      setState(() {});
    }

    if (oldWidget.autoFocus != widget.autoFocus && widget.autoFocus) {
      _focusNodes.first.requestFocus();
    }

    if (widget.enabled) {
      _insertCode(_mainController!.text);
    }

    if (oldWidget.length != widget.length) {
      _controllers.clear();
      _focusNodes.clear();
      _createControllers();
      _addFocusListeners();
      setState(() {});
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _disposeControllers();
    _removeFocusListeners();
    _disposeFocusNodes();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final selectionStyle = DefaultSelectionStyle.of(context);

    final Color cursorColor;

    switch (theme.platform) {
      case TargetPlatform.iOS:
        final CupertinoThemeData cupertinoTheme = CupertinoTheme.of(context);
        cursorColor = widget.cursorColor ??
            selectionStyle.cursorColor ??
            cupertinoTheme.primaryColor;
      case TargetPlatform.macOS:
        final CupertinoThemeData cupertinoTheme = CupertinoTheme.of(context);
        cursorColor = widget.cursorColor ??
            selectionStyle.cursorColor ??
            cupertinoTheme.primaryColor;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        cursorColor = widget.cursorColor ??
            selectionStyle.cursorColor ??
            theme.colorScheme.primary;
      case TargetPlatform.linux:
        cursorColor = widget.cursorColor ??
            selectionStyle.cursorColor ??
            theme.colorScheme.primary;
      case TargetPlatform.windows:
        cursorColor = widget.cursorColor ??
            selectionStyle.cursorColor ??
            theme.colorScheme.primary;

      default:
        cursorColor = widget.cursorColor ??
            selectionStyle.cursorColor ??
            theme.colorScheme.primary;
    }

    final defaultTextStyle = TextStyle(
      color: theme.brightness == Brightness.dark ? Colors.white : Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );

    final focusBorder = widget.focusBorder ??
        Border.all(
          color: Colors.blueAccent,
          width: 2,
        );

    final unfocusBorder = widget.unfocusBorder ??
        Border.all(
          color: Colors.black,
          width: 2,
        );

    final errorBorder = widget.errorBorder ??
        Border.all(
          color: Colors.red,
          width: 2,
        );

    final disabledBorder = widget.disabledBorder ??
        Border.all(
          color: Colors.grey,
          width: 2,
        );

    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      children: [
        for (int i = 0; i < _controllers.length; i++)
          Flexible(
            child: AnimatedContainer(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                left: i == 0 ? 0 : widget.marginBetweenFileds / 2,
                right: i == _controllers.length - 1
                    ? 0
                    : widget.marginBetweenFileds / 2,
              ),
              height: widget.heigth,
              width: widget.width,
              duration: widget.animationDuration,
              decoration: widget.customFieldDecoration ??
                  BoxDecoration(
                    shape: widget.boxShape,
                    border: widget.removeAllBorders
                        ? null
                        : widget.showError
                            ? errorBorder
                            : !widget.enabled
                                ? disabledBorder
                                : _focusNodes[i].hasFocus
                                    ? focusBorder
                                    : unfocusBorder,
                    borderRadius: widget.borderRadius,
                    boxShadow: widget.boxShadow,
                    color: widget.showError
                        ? widget.errorFieldColor
                        : _focusNodes[i].hasFocus
                            ? widget.focusFieldColor
                            : widget.unfocusFieldColor,
                  ),
              child: Padding(
                padding: _controllers[i].text.isEmpty
                    ? EdgeInsets.zero
                    : EdgeInsets.only(
                        left: widget.cursorWidth,
                      ),
                child: EditableText(
                  obscureText: widget.obscure,
                  obscuringCharacter: widget.obscuringCharacter,
                  cursorRadius: widget.cursorBorderRadius,
                  cursorHeight: widget.cursorHeight.clamp(
                    0,
                    widget.heigth,
                  ),
                  cursorWidth: widget.cursorWidth,
                  onTapOutside: !widget.dismissKeyboardOnTapOutsideOfFields
                      ? null
                      : widget.onTapOutside ??
                          (_) => FocusManager.instance.primaryFocus?.unfocus(),
                  readOnly: !widget.enabled,
                  autofocus: i == 0 ? widget.autoFocus : false,
                  controller: _controllers[i],
                  focusNode:
                      !widget.enabled ? _fallbackFocusNode : _focusNodes[i],
                  textAlign: TextAlign.center,
                  scrollPadding: EdgeInsets.zero,
                  keyboardType: TextInputType.number,
                  textInputAction: i < _controllers.length - 1
                      ? TextInputAction.next
                      : TextInputAction.done,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: widget.textStyle ?? defaultTextStyle,
                  cursorColor: cursorColor,
                  backgroundCursorColor: Colors.transparent,
                  onChanged: !widget.enabled
                      ? null
                      : (value) => _onChanged(
                            value,
                            i,
                          ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
