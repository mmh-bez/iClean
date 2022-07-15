import 'package:flutter/foundation.dart';
import 'package:i_clean/providers/view_state.dart';


abstract class BaseProvider extends ChangeNotifier{
  ViewState _state = ViewState.Idle;
  ViewState get state => _state;


  void setState(ViewState viewState){
    _state = viewState;
  }
}