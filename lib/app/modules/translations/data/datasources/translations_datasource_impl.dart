import 'package:personal_planner/app/modules/translations/data/datasources/translations_datasource.dart';
import 'package:personal_planner/app/modules/translations/data/models/translation_not_found_exception.dart';
import 'package:personal_planner/app/modules/translations/data/models/translations_model.dart';
import 'package:personal_planner/app/shared/error/exception.dart';
import 'package:personal_planner/app/shared/utils/map_utils.dart';

class TranslationsDatasourceImpl implements TranslationsDatasource {
  TranslationsModel _cachedTranslations = TranslationsModel(translations: {});

  @override
  Future<TranslationsModel> fetchTranslations() async {
    try {
      return TranslationsModel(translations: _placeholderTranslations);
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<void> cacheTranslations(TranslationsModel translations) {
    try {
      _cachedTranslations = translations;
      return Future.value();
    } catch (_) {
      throw LocalStorageException();
    }
  }

  @override
  TranslationsModel getCachedTranslations() {
    try {
      return _cachedTranslations;
    } catch (_) {
      throw LocalStorageException();
    }
  }

  @override
  String getTranslation(String key) {
    if (_cachedTranslations.translations.isEmpty) {
      throw TranslationNotFoundException();
    }

    String? value;

    try {
      value = MapUtils.getNestedValue(_cachedTranslations.translations, key);
    } catch (_) {
      throw DataParsingException();
    }

    if (value == null) {
      throw TranslationNotFoundException();
    }

    return value;
  }

  Map<String, dynamic> get _placeholderTranslations {
    return {
      'weekday': {
        'monday': 'Monday',
        'tuesday': 'Tuesday',
        'wednesday': 'Wednesday',
        'thursday': 'Thursday',
        'friday': 'Friday',
        'saturday': 'Saturday',
        'sunday': 'Sunday',
      },
      'month': {
        'january': 'January',
        'february': 'February',
        'march': 'March',
        'april': 'April',
        'may': 'May',
        'june': 'June',
        'july': 'July',
        'august': 'August',
        'september': 'September',
        'october': 'October',
        'november': 'November',
        'december': 'December',
      },
      'week_view': {
        'title': 'Events',
        'set_date': 'Set date',
        'set_time': 'Set time',
      },
      'week_tasks': {
        'title': 'Tasks',
        'is_incremental': 'Is incremental',
        'has_time': 'Has time',
      },
      'travel_checklist': {
        'title': 'Travel Checklist',
        'templates': 'Templates',
        'load_template': 'Use template',
        'create_template': 'Create template',
      },
      'day_diary': {
        'title': 'Diary',
        'require_password': 'Require password',
        'date_time': 'Date & Time',
      },
    };
  }
}
