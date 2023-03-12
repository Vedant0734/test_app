import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/theme.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial(CustomTheme(SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark ? CustomTheme.darkTheme : CustomTheme.lightTheme)));

  void toggleTheme() {
    final currentTheme = state.theme.currentTheme;
    if(currentTheme == CustomTheme.darkTheme){
      emit(ThemeUpdatedState(CustomTheme(CustomTheme.lightTheme)));
    } else {
      emit(ThemeUpdatedState(CustomTheme(CustomTheme.darkTheme)));
    }
  }
}
