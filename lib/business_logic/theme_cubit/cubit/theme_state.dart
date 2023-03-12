part of 'theme_cubit.dart';

@immutable
abstract class ThemeState {
  final CustomTheme theme;

  const ThemeState(this.theme);
}

class ThemeInitial extends ThemeState {
  const ThemeInitial(super.theme);
}

class ThemeUpdatedState extends ThemeState {
  const ThemeUpdatedState(super.theme);
}