import 'package:flutter/material.dart';
import 'package:meditation_app/data/dimensions.dart';

class AppDialogFrame extends StatelessWidget {
  final String? title;
  final String? negativeButtonText;
  final String? positiveButtonText;
  final VoidCallback? onNegativePress;
  final VoidCallback? onPositivePress;
  final VoidCallback? onBackgroundPress;
  final Widget? body;

  const AppDialogFrame({
    Key? key,
    this.title,
    this.negativeButtonText,
    this.positiveButtonText,
    this.onNegativePress,
    this.onPositivePress,
    this.onBackgroundPress,
    this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onBackgroundPress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          title != null ? _buildTitle(context) : const SizedBox(height: space8),
          if (body != null) _buildBody(context),
          negativeButtonText != null || positiveButtonText != null
              ? _buildButtons(context)
              : const SizedBox(height: space8),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(space8, space8, space8, 0),
      child: Text(
        title!.toUpperCase(),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(space8, space6, space8, 0),
      child: body,
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        space8,
        space8,
        space8,
        space8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: onNegativePress,
            child: Text(negativeButtonText ?? 'Ні'),
          ),
          TextButton(
            onPressed: onPositivePress,
            child: Text(positiveButtonText ?? 'Так'),
          ),
        ],
      ),
    );
  }
}
