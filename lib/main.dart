import 'package:flutter/material.dart';
import 'package:world_time/interfaces/home.dart';
import 'package:world_time/interfaces/loading.dart';
import 'package:world_time/interfaces/choose_location.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => Loading(),
    '/home': (context) => Home(),
    '/location': (context) => ChooseLocation(),
  },
));

