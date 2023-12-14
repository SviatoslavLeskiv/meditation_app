import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlainDialog extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final bool showProgressIndicator;

  final Map<String, Function()>? actions;

  const PlainDialog({
    super.key,
    this.title,
    this.subtitle,
    this.actions,
    this.showProgressIndicator = false,
  });

  @override
  Widget build(BuildContext context) {
    final titleWidget = title != null ? textWidget(title!, context) : null;
    final subtitleWidget = textWidget(subtitle!, context);
    if (Platform.isIOS) {
      if (actions!.isEmpty) {
        return titleWidget != null
            ? CupertinoAlertDialog(
                title: titleWidget,
                content: _buildCupertinoUI(subtitleWidget, context),
              )
            : CupertinoAlertDialog(
                content: _buildCupertinoUI(subtitleWidget, context),
              );
      } else {
        return titleWidget != null
            ? CupertinoAlertDialog(
                title: titleWidget,
                content: _buildCupertinoUI(subtitleWidget, context),
                actions: _composeActions(),
              )
            : CupertinoAlertDialog(
                content: _buildCupertinoUI(subtitleWidget, context),
                actions: _composeActions(),
              );
      }
    } else {
      if (actions!.isEmpty) {
        return titleWidget != null
            ? AlertDialog(
                title: titleWidget,
                content: _buildAndroidUI(subtitleWidget, context),
              )
            : AlertDialog(
                content: _buildAndroidUI(subtitleWidget, context),
              );
      } else {
        return titleWidget != null
            ? AlertDialog(
                title: titleWidget,
                content: _buildAndroidUI(subtitleWidget, context),
                actions: _composeActions(),
              )
            : AlertDialog(
                content: _buildAndroidUI(subtitleWidget, context),
                actions: _composeActions(),
              );
      }
    }
  }

  Column _buildAndroidUI(Widget subtitleWidget, BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          subtitleWidget,
          showProgressIndicator
              ? Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: LinearProgressIndicator(
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.2),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      );

  Column _buildCupertinoUI(Widget subtitleWidget, BuildContext context) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          subtitleWidget,
          showProgressIndicator
              ? Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: LinearProgressIndicator(
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.2),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      );

  Widget textWidget(
    String text,
    BuildContext context,
  ) =>
      Text(text);

  List<Widget> _composeActions() {
    var actionList = actions!.entries
        .map((entry) => Action(entry.key, entry.value))
        .toList()
        .reversed;

    var actionWidgets = actionList.map((action) {
      if (Platform.isIOS) {
        return CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: action.onPressed,
          child: Text(action.text),
        );
      } else {
        return TextButton(
          onPressed: action.onPressed,
          child: Text(action.text),
        );
      }
    }).toList();

    return actionWidgets;
  }
}

class Action {
  String text;
  Function() onPressed;

  Action(this.text, this.onPressed);
}

void showAppDialog(
  BuildContext context, {
  Map<String, Function()>? actions,
  String? title,
  String? subtitle,
  bool showProgressIndicator = false,
}) =>
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PlainDialog(
        title: title,
        actions: actions,
        subtitle: subtitle,
        showProgressIndicator: showProgressIndicator,
      ),
    );
