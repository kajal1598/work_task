import 'package:flutter/material.dart';

class CounterBloc extends ChangeNotifier{
  int _count =0;
  int get counter => _count;

CounterBloc(){}
  void incrementCount(){
    _count++;
    notifyListeners();
  }
}