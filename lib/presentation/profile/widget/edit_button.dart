import 'package:flutter/material.dart';
import 'package:meditation_app/data/dimensions.dart';

const int _titleMaxLines = 1;

const animationDuration = Duration(milliseconds: 200);

class EditButton extends StatelessWidget {
  final bool isLoaded;
  final String? label;
  final String? title;
  final String? text;
  final VoidCallback? onPressed;

  const EditButton({
    Key? key,
    this.isLoaded = false,
    this.label,
    this.title,
    this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label != null) ...[
          _buildLabel(context),
          const SizedBox(height: space3),
        ],
        _buildFrame(context),
      ],
    );
  }

  Widget _buildLabel(BuildContext context) {
    return Text(
      label!.toUpperCase(),
      maxLines: _titleMaxLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildFrame(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            clipBehavior: Clip.antiAlias,
            child: _buildContent(context),
          ),
          Material(
            type: MaterialType.transparency,
            borderRadius: BorderRadius.circular(12),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onPressed,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: space4),
        if (title != null)
          Text(
            title!,
            maxLines: _titleMaxLines,
            overflow: TextOverflow.ellipsis,
          ),
        if (title != null && text != null) const SizedBox(width: space4),
        Expanded(
          child: _buildText(context),
        ),
        const SizedBox(width: space4),
        if (onPressed != null)
          Padding(
            padding: const EdgeInsets.only(right: space4),
            child: Icon(
              Icons.chevron_right,
              size: 12,
              color: Colors.black,
            ),
          ),
      ],
    );
  }

  Widget _buildText(BuildContext context) {
    return AnimatedSwitcher(
      duration: animationDuration,
      // textAlign don`t work in Expanded without SizedBox width double.infinity
      child: SizedBox(
        key: Key('$isLoaded/$text'),
        width: double.infinity,
        child: Text(
          isLoaded ? text ?? '' : '',
          maxLines: _titleMaxLines,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.right,
        ),
      ),
    );
  }
}
