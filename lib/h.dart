export 'dart:async';
export 'dart:collection';
export 'dart:convert';
export 'dart:io';
export 'dart:math';

export 'package:flutter/foundation.dart';
export 'package:flutter_map/flutter_map.dart';
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'package:latlong2/latlong.dart' hide pi, Path;
export 'package:provider/provider.dart';

export 'dummy_data.dart';

export 'pop_capture.dart';
export 'crafted_widgets/h.dart';
export 'models/h.dart';
export 'providers/h.dart';
export 'screens/h.dart';
export 'utils/h.dart';

// global constants
const String uri = 'http://192.168.0.14:3000';
const Map<String, String> header = {
  'Content-Type': 'application/json; charset=UTF-8',
};
Map<String, String> headerWithToken(String token) {
  return {
    ...header,
    'x-auth-token': token,
  };
}

late double screenWidth;
late double screenHeight;

const String splashRoute = '/splash';
const String loginRoute = '/login';
const String registerRoute = '/register';
const String homeRoute = '/';
const String imageFeedRoute = '/imageFeed';
const String profileRoute = '/profile';
