import 'package:flutter/material.dart';

// ========== COLORS ==========

Color backgroundDarkColor = const Color(0xFF171717);
Color backgroundMediumColor = const Color(0xFF28231D);
Color highlightColor = const Color(0xFFb59773);
Color defaultColor = const Color(0xFFf3e9db);
Color darkBrown = const Color(0xFF483d2e);


// ========== TEXTS ==========

TextStyle itemTitle = TextStyle (
    color: defaultColor,
    fontSize: 22,
    fontFamily: 'Fairview'
);

TextStyle highlightText = TextStyle (
    color: highlightColor,
    fontFamily: 'Fairview',
    fontSize: 16
);

TextStyle defaultText = TextStyle (
    color: defaultColor,
    fontSize: 18,
    fontFamily: 'Fairview'
);

TextStyle smallText = TextStyle (
    color: highlightColor,
    fontSize: 14,
    fontFamily: 'Fairview'
);

// ========== BUTTON ==========

ButtonStyle defaultStyleButton = TextButton.styleFrom(
    primary: defaultColor,
    elevation: 2,
    padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 40
    ),
    backgroundColor: darkBrown
);

