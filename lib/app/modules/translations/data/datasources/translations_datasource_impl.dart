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
        'monday': 'Segunda',
        'tuesday': 'Terça',
        'wednesday': 'Quarta',
        'thursday': 'Quinta',
        'friday': 'Sexta',
        'saturday': 'Sábado',
        'sunday': 'Domingo',
      },
      'month': {
        'january': 'Janeiro',
        'february': 'Fevereiro',
        'march': 'Março',
        'april': 'Abril',
        'may': 'Maio',
        'june': 'Junho',
        'july': 'Julho',
        'august': 'Agosto',
        'september': 'Setembro',
        'october': 'Outubro',
        'november': 'Novembro',
        'december': 'Dezembro',
      },
      'week_view': {
        'title': 'Eventos',
        'set_date': 'Definir data',
        'set_time': 'Definir horário',
        'add_event_dialog': {
          'dialog_title': 'Adicionar evento',
          'event_title': 'Título do evento',
          'event_date': 'Data',
          'event_time': 'Horário',
          'event_description': 'Descrição',
          'event_save': 'Salvar',
          'event_discard': 'Descartar',
        },
      },
      'week_tasks': {
        'title': 'Tarefas',
        'is_incremental': 'É incremental',
        'has_time': 'Tem horário',
      },
      'travel_checklist': {
        'title': 'Lista de Viagem',
        'templates': 'Modelos',
        'load_template': 'Usar modelo',
        'create_template': 'Criar modelo',
      },
      'day_diary': {
        'title': 'Diário',
        'require_password': 'Exigir senha',
        'date_time': 'Data e Hora',
      },
    };
  }
}
