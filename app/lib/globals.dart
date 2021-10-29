library globals;

import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'theme/style.dart' as style;

const API_KEY = '3ef82d5ec2c715ea95fbdc10fd8b684a';
String host = 'api.themoviedb.org';

// ========== COMPONENTS ==========

Widget fullLoading = Container(
    child: Center (
        child: (Platform.isAndroid) ?
        CircularProgressIndicator(color: style.highlightColor) :
        Theme(data: ThemeData(cupertinoOverrideTheme: CupertinoThemeData(brightness: Brightness.dark)), child: CupertinoActivityIndicator())
    )
);