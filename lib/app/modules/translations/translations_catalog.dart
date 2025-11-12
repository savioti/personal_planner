import 'package:personal_planner/app/shared/enums/recurrence_type.dart';

class WeekdayTranslations {
  static const String monday = 'Segunda';
  static const String tuesday = 'Terça';
  static const String wednesday = 'Quarta';
  static const String thursday = 'Quinta';
  static const String friday = 'Sexta';
  static const String saturday = 'Sábado';
  static const String sunday = 'Domingo';

  static String getWeekDayNameByIndex(int index) {
    switch (index) {
      case 1:
        return monday;
      case 2:
        return tuesday;
      case 3:
        return wednesday;
      case 4:
        return thursday;
      case 5:
        return friday;
      case 6:
        return saturday;
      case 7:
        return sunday;
      default:
        return '';
    }
  }

  static String getWeekdayFirstLetterByIndex(int index) {
    return getWeekDayNameByIndex(index).substring(0, 1);
  }
}

class RecurrenceTypeTranslations {
  static const String none = 'Nenhum';
  static const String daily = 'Diário';
  static const String weekly = 'Semanal';
  static const String monthly = 'Mensal';
  static const String yearly = 'Anual';
  static const String firstWeekdayOfTheMonth = 'Primeiro do mês';

  static String getRecurrenceTypeName(RecurrenceType type) {
    switch (type) {
      case RecurrenceType.none:
        return none;
      case RecurrenceType.daily:
        return daily;
      case RecurrenceType.weekly:
        return weekly;
      case RecurrenceType.monthly:
        return monthly;
      case RecurrenceType.yearly:
        return yearly;
      case RecurrenceType.firstWeekdayOfTheMonth:
        return firstWeekdayOfTheMonth;
    }
  }
}

class RelativeDayTranslations {
  static const String today = 'Hoje';
  static const String tomorrow = 'Amanhã';
  static const String yesterday = 'Ontem';
}

class MonthTranslations {
  static const String january = 'Janeiro';
  static const String february = 'Fevereiro';
  static const String march = 'Março';
  static const String april = 'Abril';
  static const String may = 'Maio';
  static const String june = 'Junho';
  static const String july = 'Julho';
  static const String august = 'Agosto';
  static const String september = 'Setembro';
  static const String october = 'Outubro';
  static const String november = 'Novembro';
  static const String december = 'Dezembro';
}

class WeekViewTranslations {
  static const String title = 'Planejamento Semanal';
  static const String setDate = 'Definir data';
  static const String setTime = 'Definir horário';

  static const String dialogTitle = 'Adicionar evento';
  static const String eventTitle = 'Título';
  static const String eventDate = 'Data';
  static const String eventTime = 'Horário';
  static const String eventDescription = 'Descrição';
  static const String eventSave = 'Salvar';
  static const String eventFormCancel = 'Cancelar';
  static const String eventDelete = 'Excluir';
  static const String eventRecurrence = 'Recorrência';
}

class UpcomingEventsTranslations {
  static const String title = 'Próximos Eventos';
  static const String nextWeek = 'Próxima Semana';
  static const String nextMonth = 'Restante do Mês';
  static const String future = 'Futuros';
}

class WeekTasksTranslations {
  static const String title = 'Tarefas';
  static const String isIncremental = 'É incremental';
  static const String hasTime = 'Tem horário';

  static const String dialogTitle = 'Adicionar tarefa';
  static const String taskTitle = 'Título';
  static const String taskDescription = 'Descrição';
  static const String taskDeadline = 'Prazo';
  static const String taskSave = 'Salvar';
  static const String taskDiscard = 'Descartar';

  static const String overdueTasksTitle = 'Atrasadas';
  static const String thisWeekTasksTitle = 'Pendentes';
  static const String backlogTasksTitle = 'Backlog';
}

class ExtraFeaturesTranslations {
  static const String title = 'Extras';
  static const String shoppingList = 'Lista de compras';
  static const String finances = 'Finanças';
  static const String dayDiary = 'Diário';
  static const String travelChecklist = 'Lista de Viagem';
  static const String mealPlan = 'Plano de Refeições';
  static const String settings = 'Configurações';
}

class TravelChecklistTranslations {
  static const String title = 'Lista de Viagem';
  static const String templates = 'Modelos';
  static const String loadTemplate = 'Usar modelo';
  static const String createTemplate = 'Criar modelo';
}

class DayDiaryTranslations {
  static const String title = 'Diário';
  static const String requirePassword = 'Exigir senha';
  static const String dateTime = 'Data e Hora';
}

class SettingsTranslations {
  static const String title = 'Configurações';
  static const String theme = 'Tema';
}
