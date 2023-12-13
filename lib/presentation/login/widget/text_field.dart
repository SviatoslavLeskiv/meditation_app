import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meditation_app/presentation/login/login.dart';

const _cursorWidth = 2.0;
const _cursorHeight = 16.0;

class BorderedTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isError;

  final int minLines;
  final int maxLines;
  final int maxLength;
  final bool hiddenText;
  final bool autocorrect;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;

  final String? labelText;
  final String? hintText;
  final String? errorText;

  const BorderedTextField({
    Key? key,
    required this.controller,
    required this.focusNode,
    this.isError = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength = 1000,
    this.hiddenText = false,
    this.autocorrect = false,
    this.textCapitalization = TextCapitalization.sentences,
    this.keyboardType,
    this.autofillHints,
    this.labelText,
    this.hintText,
    this.errorText,
  })  : assert(hiddenText == false || hiddenText == true && maxLines == 1),
        super(key: key);

  const BorderedTextField.passcode({
    Key? key,
    required this.controller,
    required this.focusNode,
    this.isError = false,
    this.labelText,
    this.hintText,
    this.errorText,
  })  : minLines = 1,
        maxLines = 1,
        maxLength = 20,
        hiddenText = true,
        autocorrect = false,
        textCapitalization = TextCapitalization.none,
        keyboardType = TextInputType.visiblePassword,
        autofillHints = const [AutofillHints.password],
        super(key: key);

  @override
  State<BorderedTextField> createState() => _BorderedTextFieldState();
}

class _BorderedTextFieldState extends State<BorderedTextField> {
  bool isHideText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText != null) _buildLabel(context),
        _buildTextFieldFrame(context),
        if (widget.errorText != null) _buildError(context),
      ],
    );
  }

  Widget _buildLabel(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        widget.labelText!,
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: widget.isError
            ? Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  widget.errorText!,
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildTextFieldFrame(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 40,
          child: GestureDetector(
            onTap: widget.focusNode.requestFocus,
            child: Material(
              borderRadius: BorderRadius.circular(12),
              color: defaultColor.withOpacity(0.2),
              child: Row(
                crossAxisAlignment: widget.maxLines > 1
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 16),
                  Expanded(
                    child: Padding(
                      padding: widget.maxLines > 1
                          ? const EdgeInsets.only(top: 16)
                          : EdgeInsets.zero,
                      child: _buildTextField(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(BuildContext context) {
    final hidden = widget.hiddenText == true ? isHideText : false;
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      autofillHints: widget.autofillHints,
      autocorrect: widget.autocorrect,
      textCapitalization: widget.textCapitalization,
      inputFormatters: _inputFormatters(),
      decoration: _inputDecoration(context),
      cursorColor: Colors.black,
      cursorWidth: _cursorWidth,
      cursorHeight: _cursorHeight,
      cursorRadius: Radius.zero,
      obscuringCharacter: '*',
      obscureText: hidden,
    );
  }

  List<TextInputFormatter> _inputFormatters() {
    return [
      LengthLimitingTextInputFormatter(widget.maxLength),
      FilteringTextInputFormatter.allow(RegExp(r'[^\s].*')),
      if (widget.keyboardType == TextInputType.number)
        FilteringTextInputFormatter.digitsOnly,
    ];
  }

  InputDecoration _inputDecoration(BuildContext context) {
    return InputDecoration(
      hintText: widget.hintText,
      contentPadding: EdgeInsets.zero,
      isCollapsed: true,
      fillColor: Colors.black,
      hoverColor: Colors.black,
      border: const UnderlineInputBorder(
        borderSide: BorderSide.none,
      ),
    );
  }
}
