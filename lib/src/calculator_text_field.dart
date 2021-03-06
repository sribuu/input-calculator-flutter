import 'package:flutter/material.dart';
import 'package:input_calculator/src/themes.dart';

import 'base_text_field.dart';

// ignore: must_be_immutable
class CalculatorTextField extends StatefulWidget with BaseTextField {
  CalculatorTextField({
    Key key,
    this.title,
    this.initialValue = 0.0,
    this.boxDecoration,
    this.appBarBackgroundColor,
    this.operatorButtonColor: Colors.amber,
    this.operatorTextButtonColor: Colors.white,
    this.normalButtonColor: Colors.white,
    this.normalTextButtonColor: Colors.grey,
    this.doneButtonColor: Colors.blue,
    this.doneTextButtonColor: Colors.white,
    this.onSubmitted,
    this.inputDecoration = const InputDecoration(),
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.valueFormat,
    this.allowNegativeResult = true,
    this.theme = CalculatorThemes.flat,
    this.appBar,
    this.aturButton,
    this.enabled,
  }) : super(key: key);

  final String title;
  final double initialValue;
  final BoxDecoration boxDecoration;
  final Color appBarBackgroundColor;
  final Color operatorButtonColor;
  final Color operatorTextButtonColor;
  final Color normalButtonColor;
  final Color normalTextButtonColor;
  final Color doneButtonColor;
  final Color doneTextButtonColor;
  final ValueChanged<double> onSubmitted;
  final InputDecoration inputDecoration;
  final TextStyle style;
  final StrutStyle strutStyle;
  final TextAlign textAlign;
  final ValueFormat<double> valueFormat;
  final bool allowNegativeResult;
  final CalculatorThemes theme;
  final PreferredSizeWidget appBar;
  final Widget aturButton;
  final bool enabled;

  @override
  _CalculatorTextFieldState createState() => _CalculatorTextFieldState();
}

class _CalculatorTextFieldState extends State<CalculatorTextField> {
  final inputController = TextEditingController();

  @override
  void initState() {
    super.initState();

    setValue(widget.initialValue);
  }

  void setValue(double value) {
    inputController.text =
        widget.valueFormat != null ? widget.valueFormat(value) : '$value';
  }

  @override
  Widget build(BuildContext context) {
    if (widget.aturButton != null) {
      return widget.aturButton;
    }

    return TextField(
      enabled: widget.enabled,
      controller: inputController,
      readOnly: true,
      style: widget.style,
      strutStyle: widget.strutStyle,
      textAlign: widget.textAlign,
      decoration: widget.inputDecoration,
      onTap: () async {
        final result = await widget.showInputCalculator(context);
        setState(() {
          setValue(result);

          if (widget.onSubmitted != null) widget.onSubmitted(result);
        });
      },
    );
  }
}
