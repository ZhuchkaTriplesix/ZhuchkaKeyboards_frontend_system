import 'package:flutter/material.dart';

/// Accent seed for [ColorScheme] (Material 3 dark), aligned with Market for one design family.
///
/// UI bar: [`docs/frontend-requirements.md`](https://github.com/ZhuchkaTriplesix/ZhuchkaKeyboards/blob/dev/docs/frontend-requirements.md)
/// (OLED `#000000` scaffold, M3 surfaces; System may use denser layouts later).
const Color kZhuchkaSystemBrandSeed = Color(0xFF2D2640);

/// Project surface tokens layered on Material 3.
@immutable
class ZhuchkaSystemTokens extends ThemeExtension<ZhuchkaSystemTokens> {
  const ZhuchkaSystemTokens({
    this.oledBlack = const Color(0xFF000000),
  });

  /// Root scaffold / app background — strict OLED black (spec §2.1).
  final Color oledBlack;

  @override
  ZhuchkaSystemTokens copyWith({Color? oledBlack}) {
    return ZhuchkaSystemTokens(oledBlack: oledBlack ?? this.oledBlack);
  }

  @override
  ZhuchkaSystemTokens lerp(ThemeExtension<ZhuchkaSystemTokens>? other, double t) {
    if (other is! ZhuchkaSystemTokens) return this;
    return ZhuchkaSystemTokens(
      oledBlack: Color.lerp(oledBlack, other.oledBlack, t)!,
    );
  }
}

/// Dark-only staff console theme: M3, OLED black scaffold, generated [ColorScheme].
ThemeData buildZhuchkaSystemTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: kZhuchkaSystemBrandSeed,
    brightness: Brightness.dark,
  );

  const tokens = ZhuchkaSystemTokens();

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: tokens.oledBlack,
    extensions: const [tokens],
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.surfaceContainerHighest,
      surfaceTintColor: Colors.transparent,
      foregroundColor: colorScheme.onSurface,
    ),
  );
}
