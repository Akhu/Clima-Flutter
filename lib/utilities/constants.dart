import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  color: Colors.black87,
  fontSize: 80.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 80.0,
);


const kInputDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    icon: FaIcon(
      FontAwesomeIcons.city,
      size: 18,
      color: Colors.white,
    ),
    hintText: 'Enter a city name',
    hintStyle: TextStyle(
        color: Colors.grey,
        fontFamily: 'Spartan MB'
    ),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(10.0)
        ),
        borderSide: BorderSide.none
    )
);