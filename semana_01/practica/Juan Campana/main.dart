import 'dart:io';

/// Clase para calcular y reportar la productividad semanal basada en actividades.
class WeeklyProductivity {
  String userName;
  Map<String, double> activities; // horas dedicadas a cada actividad
  static const double totalHours = 168.0;

  WeeklyProductivity(this.userName, this.activities);

  /// Calcula el porcentaje de tiempo dedicado a cada actividad
  Map<String, double> calculatePercentages() {
    final Map<String, double> percentages = {};
    activities.forEach((activity, hours) {
      percentages[activity] = (hours / totalHours) * 100;
    });
    return percentages;
  }

  /// Genera advertencias o sugerencias según los datos de entrada
  List<String> detectImbalances() {
    List<String> messages = [];
    double workHours = activities['Trabajo'] ?? 0;
    double studyHours = activities['Estudio'] ?? 0;
    double sleepHours = activities['Sueño'] ?? 0;

    if (workHours + studyHours > 60) {
      messages.add(
        '⚠️ Has dedicado más de 60 horas a trabajo/estudio. ¡Atención al equilibrio!'
      );
    }
    if (sleepHours < 40) {
      messages.add(
        '💡 Dormir menos de 40 horas puede afectar tu salud. Considera descansar más.'
      );
    }
    return messages;
  }

  /// Imprime en consola el informe completo
  void printReport() {
    print('\n===== Informe de Productividad Semanal =====');
    print('Usuario: $userName');
    print('Total de horas en la semana: $totalHours\n');

    // Porcentajes
    final percentages = calculatePercentages();
    print('--- Porcentaje de tiempo por actividad ---');
    percentages.forEach((activity, pct) {
      print('${activity.padRight(10)}: ${pct.toStringAsFixed(2)}%');
    });

    // Mensajes de desequilibrio
    final messages = detectImbalances();
    if (messages.isNotEmpty) {
      print('\n--- Recomendaciones y Alertas ---');
      for (var msg in messages) {
        print(msg);
      }
    }

    // Resumen general
    print('\n--- Resumen General ---');
    print('De las $totalHours horas semanales:');
    activities.forEach((activity, hours) {
      print('- $hours horas en $activity');
    });
    print('===========================================');
  }
}

void main() {
  stdout.write('Ingrese su nombre: ');
  String? name = stdin.readLineSync();
  final userName = (name != null && name.isNotEmpty) ? name : 'Usuario';

  // Solicitar horas a distintas actividades
  final Map<String, double> activities = {};
  final List<String> categories = ['Trabajo', 'Estudio', 'Ocio', 'Sueño'];

  for (var category in categories) {
    while (true) {
      stdout.write('Horas dedicadas a $category esta semana: ');
      String? input = stdin.readLineSync();
      if (input != null) {
        final hours = double.tryParse(input);
        if (hours != null && hours >= 0 && hours <= WeeklyProductivity.totalHours) {
          activities[category] = hours;
          break;
        }
      }
      print('Entrada no válida. Ingresa un número entre 0 y ${WeeklyProductivity.totalHours}.');
    }
  }

  // Crear e imprimir informe
  final report = WeeklyProductivity(userName, activities);
  report.printReport();
}