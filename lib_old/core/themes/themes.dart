

import 'package:flutter/material.dart';
import '../constants/constants.dart' as constants show Colors;
// import '/core/core.dart' as AppConstants show Colors;

part 'light.dart';
part 'dark.dart';

// ثيم التطبيق
class Theme
{
  static ThemeData get light => _light;
  static ThemeData get dark => _dark;
}