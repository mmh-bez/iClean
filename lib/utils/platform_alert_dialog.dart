import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'platform_widget.dart';
/*

class PlatformAlertDialog extends PlatformWidget<CupertinoAlertDialog, AlertDialog> {
  PlatformAlertDialog({
    required this.title,
    required this.content,
    this.cancelText,
    @required this.confirmText,
    this.actions,
    this.onCallBack
  })  : assert(title != null),
        assert(content != null),
        assert(confirmText != null);

  final String title;
  final String content;
  final String cancelText;
  final String confirmText;
  final Function onCallBack;
  final List<String> actions;
  @override
  AlertDialog buildMaterialWidget(BuildContext context) {
    var actionsWidgets = <Widget>[];

    if (this.actions != null){
      this.actions.forEach((actionString){
        actionsWidgets.add(PlatformAlertDialogAction(
          child: Text(actionString),
          onPressed: () => _dismiss(context, actionString),
        ));
      });
    }
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: actions != null ?  actionsWidgets :  _actions(
          context, cancelText?.toUpperCase(), confirmText.toUpperCase()),
    );
  }

  @override
  CupertinoAlertDialog buildCupertinoWidget(BuildContext context) {

    var actionsWidgets = <Widget>[];

    if (this.actions != null){
      this.actions.forEach((actionString){
        actionsWidgets.add(PlatformAlertDialogAction(
          child: Text(actionString),
          onPressed: () => _dismiss(context, actionString),
        ));
      });
    }
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text("\n"+ content),
      actions: actions != null ? actionsWidgets :_actions(context, cancelText, confirmText),
    );
  }


  List<Widget> _actions(
      BuildContext context, String cancelText, String confirmText) {
    var actions = <Widget>[];
    if (cancelText != null) {
      actions.add(PlatformAlertDialogAction(
        child: Text(cancelText),
        onPressed: () => _dismiss(context, cancelText),
      ));
    }
    actions.add(PlatformAlertDialogAction(
      child: Text(confirmText),
      onPressed: () => _dismiss(context, confirmText),
    ));
    return actions;
  }

  Future<bool> show(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: !Platform.isIOS,
      builder: (context) => this,
    );
    // showDialog returns null if the dialog has been dismissed with the back
    // button on Android.
    // here we ensure that we return only true or false
    return Future.value(result ?? false);
  }

  void _dismiss(BuildContext context, dynamic value) {
    Navigator.of(context, rootNavigator: true).pop(false);
    if (onCallBack != null) {
      onCallBack(value);
    }
  }
}

class PlatformAlertDialogAction extends PlatformWidget<CupertinoDialogAction, FlatButton> {
  PlatformAlertDialogAction({this.child, this.onPressed});
  final Widget child;
  final VoidCallback onPressed;

  @override
  FlatButton buildMaterialWidget(BuildContext context) {
    return FlatButton(
      child: child,
      onPressed: onPressed,
    );
  }

  @override
  CupertinoDialogAction buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(
      child: child,
      onPressed: onPressed,
    );
  }
}
*/
