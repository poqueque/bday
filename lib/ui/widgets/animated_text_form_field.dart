import 'package:flutter/material.dart';

import 'custom_text_form_field.dart';

enum InputStatus { valid, invalid, none }

// From: https://medium.com/@mjpublicuser/flutter-challenge-animated-text-form-field-884dff3140f0
class AnimatedTextFormField extends StatefulWidget {
  final FormFieldValidator<String> validator;
  final String labelText;
  final String successText;
  final bool suffix;
  final Color errorColor;
  final Color successColor;
  final Color backgroundColor;
  final Color labelColor;
  final Icon successIcon;
  final Icon errorIcon;
  final Icon inputIcon;
  final TextEditingController controller;

  const AnimatedTextFormField(
      {Key key,
      this.validator,
      this.successIcon = const Icon(
        Icons.check,
        color: Colors.white,
      ),
      this.errorIcon = const Icon(
        Icons.warning,
        color: Colors.white,
      ),
      @required this.inputIcon,
      this.labelText,
      this.successText,
      this.suffix = true,
      this.errorColor = Colors.red,
      this.successColor = Colors.green,
      this.backgroundColor = Colors.white,
      this.labelColor = Colors.grey,
      this.controller})
      : super(key: key);

  @override
  _AnimatedTextFormFieldState createState() => _AnimatedTextFormFieldState();
}

class _AnimatedTextFormFieldState extends State<AnimatedTextFormField> {
  InputStatus inputStatus = InputStatus.none;
  String labelText;
  Border border;
  Color labelColor;
  FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode()
      ..addListener(() {
        if (focusNode.hasFocus && inputStatus == InputStatus.none)
          setState(() {
            var color = Colors.blue;
            border = getBorder(color);
            labelColor = color;
          });
      });
    setInputDetails();
  }

  String validator(String text) {
    if (widget.validator == null) return null;
    String error = widget.validator(text);
    InputStatus inst;
    if (error == null)
      inst = InputStatus.valid;
    else
      inst = InputStatus.invalid;

    if (inst != inputStatus) {
      inputStatus = inst;
      setInputDetails(error);
      setState(() {});
    }

    return error;
  }

  Border getBorder(Color color) {
    return Border.all(width: 3, color: color);
  }

  void setInputDetails([String error]) {
    switch (inputStatus) {
      case InputStatus.invalid:
        var color = widget.errorColor;
        labelText = error;
        border = getBorder(color);
        labelColor = color;
        break;
      case InputStatus.valid:
        var color = widget.successColor;
        labelText = widget.successText;
        border = getBorder(color);
        labelColor = color;
        break;
      default:
        labelColor = widget.labelColor;
        labelText = widget.labelText;
        border = getBorder(Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(5),
        border: border,
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (!widget.suffix) getInputIcon(),
            Expanded(
              child: CustomTextFormField(
                focusNode: focusNode,
                style: TextStyle(fontSize: 30),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: labelText,
                    labelStyle: TextStyle(color: labelColor),
                    contentPadding: EdgeInsets.all(10)),
                validator: validator,
                controller: widget.controller,
              ),
            ),
            if (widget.suffix) getInputIcon()
          ],
        ),
      ),
    );
  }

  Widget getInputIcon() {
    return SizedBox(
      width: 50,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Icon(Icons.email),
          buildIcon(
            inputStatus == InputStatus.invalid,
            widget.errorColor,
            widget.errorIcon,
          ),
          buildIcon(
            inputStatus == InputStatus.valid,
            widget.successColor,
            widget.successIcon,
          )
        ],
      ),
    );
  }

  Widget buildIcon(bool shouldAnimate, Color color, Icon icon,
      [Curve curve = Curves.fastOutSlowIn]) {
    final double animVal = shouldAnimate ? 0 : -50;
    return AnimatedPositioned(
      duration: Duration(milliseconds: 500),
      right: widget.suffix ? animVal : null,
      top: 0,
      left: widget.suffix ? null : animVal,
      bottom: 0,
      curve: curve,
      child: Container(
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(5),
            ),
            color: color,
          ),
          child: icon),
    );
  }
}
