import 'package:uol_teacher_admin/data/repositories/settingsRepository.dart';
import 'package:uol_teacher_admin/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

class AppLocalizationState {
  final Locale language;
  AppLocalizationState(this.language);
}

class AppLocalizationCubit extends Cubit<AppLocalizationState> {
  final SettingsRepository _settingsRepository;
  AppLocalizationCubit(this._settingsRepository)
      : super(
          AppLocalizationState(
            Utils.getLocaleFromLanguageCode(
              _settingsRepository.getCurrentLanguageCode(),
            ),
          ),
        );

  void changeLanguage(String languageCode) {
    _settingsRepository.setCurrentLanguageCode(languageCode);
    Get.updateLocale(Utils.getLocaleFromLanguageCode(languageCode));
    emit(AppLocalizationState(Utils.getLocaleFromLanguageCode(languageCode)));
  }
}
