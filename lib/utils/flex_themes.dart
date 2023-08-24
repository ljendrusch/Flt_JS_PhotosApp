import 'package:pop_capture/h.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData get flexThemeLight => _dataFromThemeMode(ThemeMode.light);

ThemeData get flexThemeDark => _dataFromThemeMode(ThemeMode.dark);

ThemeData _dataFromThemeMode(ThemeMode themeMode) {
  ThemeData base = (themeMode == ThemeMode.light) ? _light : _dark;

  return base.copyWith(
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            (themeMode == ThemeMode.light) ? Brightness.dark : Brightness.light,
      ),
      actionsIconTheme:
          IconThemeData(color: base.colorScheme.onBackground, size: 24),
      iconTheme: IconThemeData(color: base.colorScheme.onBackground, size: 24),
    ),
  );
}

ThemeData _light = FlexThemeData.light(
  colors: const FlexSchemeColor(
    primary: Color(0xff373f4f),
    primaryContainer: Color(0xffb0b7c5),
    secondary: Color(0xfff54e59),
    secondaryContainer: Color(0xffffb2b8),
    tertiary: Color(0xff29336e),
    tertiaryContainer: Color(0xffa1a9d8),
    appBarColor: Color(0xfff54e59),
    error: Color(0xffb00020),
  ),
  surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
  blendLevel: 20,
  appBarOpacity: 0.9,
  appBarElevation: 4,
  tooltipsMatchBackground: true,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 20,
    blendOnColors: false,
    defaultRadius: 8.0,
    textButtonSchemeColor: SchemeColor.secondary,
    elevatedButtonSchemeColor: SchemeColor.tertiary,
    outlinedButtonSchemeColor: SchemeColor.secondary,
    toggleButtonsSchemeColor: SchemeColor.tertiary,
    fabUseShape: false,
    fabSchemeColor: SchemeColor.secondaryContainer,
    snackBarBackgroundSchemeColor: SchemeColor.tertiary,
    chipSchemeColor: SchemeColor.tertiary,
    appBarBackgroundSchemeColor: SchemeColor.secondary,
    bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.onPrimary,
    bottomNavigationBarUnselectedLabelSchemeColor:
        SchemeColor.onPrimaryContainer,
    bottomNavigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
    bottomNavigationBarUnselectedIconSchemeColor:
        SchemeColor.onPrimaryContainer,
    bottomNavigationBarBackgroundSchemeColor: SchemeColor.secondary,
    bottomNavigationBarOpacity: 0.90,
    bottomNavigationBarElevation: 3.0,
    bottomNavigationBarShowUnselectedLabels: false,
    navigationBarSelectedLabelSchemeColor: SchemeColor.onPrimary,
    navigationBarUnselectedLabelSchemeColor: SchemeColor.onPrimaryContainer,
    navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
    navigationBarUnselectedIconSchemeColor: SchemeColor.onPrimaryContainer,
    navigationBarIndicatorSchemeColor: SchemeColor.onPrimaryContainer,
    navigationBarIndicatorOpacity: 0.50,
    navigationBarBackgroundSchemeColor: SchemeColor.secondary,
    navigationBarOpacity: 0.90,
    navigationBarLabelBehavior:
        NavigationDestinationLabelBehavior.onlyShowSelected,
    navigationRailSelectedLabelSchemeColor: SchemeColor.onPrimary,
    navigationRailUnselectedLabelSchemeColor: SchemeColor.onPrimaryContainer,
    navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
    navigationRailUnselectedIconSchemeColor: SchemeColor.onPrimaryContainer,
    navigationRailIndicatorSchemeColor: SchemeColor.onPrimaryContainer,
    navigationRailIndicatorOpacity: 0.50,
    navigationRailBackgroundSchemeColor: SchemeColor.secondary,
    navigationRailOpacity: 0.90,
    navigationRailElevation: 2.0,
    navigationRailLabelType: NavigationRailLabelType.selected,
  ),
  useMaterial3ErrorColors: true,
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  fontFamily: GoogleFonts.notoSans().fontFamily,
);

ThemeData _dark = FlexThemeData.dark(
  colors: const FlexSchemeColor(
    primary: Color(0xff535353),
    primaryContainer: Color(0xff070707),
    secondary: Color(0xffc76d72),
    secondaryContainer: playdo_red,
    tertiary: playdo_blue, // tertiary: Color(0xff373d5c),
    tertiaryContainer: Color(0xff20243a),
    appBarColor: playdo_red,
    error: Color(0xffcf6679),
  ),
  surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
  blendLevel: 30,
  appBarOpacity: 0.9,
  appBarElevation: 4,
  tooltipsMatchBackground: true,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 30,
    defaultRadius: 8.0,
    textButtonSchemeColor: SchemeColor.secondary,
    elevatedButtonSchemeColor: SchemeColor.tertiary,
    outlinedButtonSchemeColor: SchemeColor.secondary,
    toggleButtonsSchemeColor: SchemeColor.tertiary,
    inputDecoratorSchemeColor: SchemeColor.tertiary,
    fabUseShape: false,
    snackBarBackgroundSchemeColor: SchemeColor.tertiary,
    chipSchemeColor: SchemeColor.tertiary,
    appBarBackgroundSchemeColor: SchemeColor.secondaryContainer,
    bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.onPrimary,
    bottomNavigationBarUnselectedLabelSchemeColor: SchemeColor.surfaceVariant,
    bottomNavigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
    bottomNavigationBarUnselectedIconSchemeColor: SchemeColor.surfaceVariant,
    bottomNavigationBarBackgroundSchemeColor: SchemeColor.secondaryContainer,
    bottomNavigationBarOpacity: 0.90,
    bottomNavigationBarShowUnselectedLabels: false,
    navigationBarSelectedLabelSchemeColor: SchemeColor.onPrimary,
    navigationBarUnselectedLabelSchemeColor: SchemeColor.surfaceVariant,
    navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
    navigationBarUnselectedIconSchemeColor: SchemeColor.surfaceVariant,
    navigationBarIndicatorSchemeColor: SchemeColor.secondary,
    navigationBarIndicatorOpacity: 0.80,
    navigationBarBackgroundSchemeColor: SchemeColor.secondaryContainer,
    navigationBarOpacity: 0.90,
    navigationBarLabelBehavior:
        NavigationDestinationLabelBehavior.onlyShowSelected,
    navigationRailSelectedLabelSchemeColor: SchemeColor.onPrimary,
    navigationRailUnselectedLabelSchemeColor: SchemeColor.surfaceVariant,
    navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
    navigationRailUnselectedIconSchemeColor: SchemeColor.surfaceVariant,
    navigationRailIndicatorSchemeColor: SchemeColor.secondary,
    navigationRailIndicatorOpacity: 0.80,
    navigationRailBackgroundSchemeColor: SchemeColor.secondaryContainer,
    navigationRailOpacity: 0.90,
    navigationRailLabelType: NavigationRailLabelType.selected,
  ),
  useMaterial3ErrorColors: true,
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  fontFamily: GoogleFonts.notoSans().fontFamily,
);
