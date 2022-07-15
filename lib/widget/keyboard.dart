import 'package:flutter/material.dart';

typedef KeyboardTapCallback = void Function(String text);

class NumericKeyboard extends StatefulWidget {
  /// Color of the text [default = Colors.black]
  final Color textColor;

  /// Display a custom right icon
  final Icon rightIcon;

  /// Action to trigger when right button is pressed
  final Function() rightButtonFn;

  /// Display a custom left icon
  final Text leftIcon;

  /// Action to trigger when left button is pressed
  final Function() leftButtonFn;

  /// Callback when an item is pressed
  final KeyboardTapCallback onKeyboardTap;

  /// Main axis alignment [default = MainAxisAlignment.spaceEvenly]
  final MainAxisAlignment mainAxisAlignment;

  NumericKeyboard(
      {Key key,
        this.onKeyboardTap,
        this.textColor = Colors.black,
        this.rightButtonFn,
        this.rightIcon,
        this.leftButtonFn,
        this.leftIcon,
        this.mainAxisAlignment = MainAxisAlignment.center})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NumericKeyboardState();
  }
}

class _NumericKeyboardState extends State<NumericKeyboard> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return  Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.start,
          crossAxisAlignment:  CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _calcButton('1'),
                _calcButton('2'),
                _calcButton('3'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _calcButton('4'),
                _calcButton('5'),
                _calcButton('6'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _calcButton('7'),
                _calcButton('8'),
                _calcButton('9'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: InkWell(
                      onTap: widget.leftButtonFn,
                      child: Container(
                        color: Colors.white,
                        alignment: Alignment.center,
                        width: 100,
                        height: 60,
                        child: Text(
                          "Clear",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w300,
                              color: Colors.black),
                        ),)),
                ),
                _calcButton('0'),
                Expanded(
                  child: InkWell(
                    splashColor: Colors.orange,
                      onTap: widget.rightButtonFn,
                      child: Container(
                          color: Colors.white,
                          alignment: Alignment.center,
                          width: 100,
                          height: 60,
                          child: Padding(
                              padding: EdgeInsets.only(left: 14),
                              child: widget.rightIcon))),
                )
              ],
            ),
          ],
        ),

    );
  }

  Widget _calcButton(String value) {
    return Expanded(
      child: InkWell(
          onTap: () {
            widget.onKeyboardTap(value);
          },
          child: Padding(
            padding: EdgeInsets.only(left: 1 , top: 1 ),
            child: Container(
              color: Colors.blueGrey,
              alignment: Alignment.center,
              width: double.infinity,
              height: 60,
              child: Text(
                value,
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: widget.textColor),
              ),
            ),
          )),
    );
  }
}