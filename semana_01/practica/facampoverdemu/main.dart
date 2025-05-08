import 'dart:io';

// Clase para representar las actividades
class Actividad {
  String nombre;
  double horas;

  Actividad(this.nombre, this.horas);

  // Método para calcular el porcentaje de horas dedicadas a la actividad
  double calcularPorcentaje(double totalHoras) {
    return (horas / totalHoras) * 100;
  }
}

void main() {
  // Definir las actividades
  List<Actividad> actividades = [];

  // Solicitar el nombre del usuario
  stdout.write("Ingrese su nombre: ");
  String nombre = stdin.readLineSync() ?? '';

  // Solicitar horas dedicadas a cada actividad
  double horasTrabajo = solicitarHoras("Trabajo");
  double horasEstudio = solicitarHoras("Estudio");
  double horasOcio = solicitarHoras("Ocio");
  double horasSueno = solicitarHoras("Sueño");

  // Calcular el total de horas de la semana
  double totalHorasSemana = 168;

  // Crear las actividades
  actividades.add(Actividad("Trabajo", horasTrabajo));
  actividades.add(Actividad("Estudio", horasEstudio));
  actividades.add(Actividad("Ocio", horasOcio));
  actividades.add(Actividad("Sueño", horasSueno));

  // Generar el informe
  generarInforme(nombre, actividades, totalHorasSemana);
}

// Función para solicitar las horas de una actividad
double solicitarHoras(String actividad) {
  stdout.write("Ingrese las horas dedicadas a $actividad en la semana: ");
  double horas = double.parse(stdin.readLineSync() ?? '0');
  return horas;
}

// Función para generar el informe
void generarInforme(String nombre, List<Actividad> actividades, double totalHorasSemana) {
  double horasTrabajo = actividades[0].horas;
  double horasEstudio = actividades[1].horas;
  double horasOcio = actividades[2].horas;
  double horasSueno = actividades[3].horas;

  print("\n--- Informe de Productividad Personal de $nombre ---\n");

  // Imprimir porcentajes de cada actividad
  for (var actividad in actividades) {
    print("${actividad.nombre}: ${actividad.calcularPorcentaje(totalHorasSemana).toStringAsFixed(2)}%");
  }

  // Análisis de equilibrio de tiempo
  if (horasTrabajo + horasEstudio > 60) {
    print("\nAdvertencia: Está dedicando más de 60 horas a trabajo o estudio. ¡Considere equilibrar su tiempo!");
  }

  if (horasSueno < 40) {
    print("\nSugerencia: Está durmiendo menos de 40 horas. ¡Asegúrese de descansar lo suficiente!");
  }

  // Resumen de hábitos
  print("\nResumen de hábitos:");
  print("Horas de trabajo y estudio: ${horasTrabajo + horasEstudio} horas");
  print("Horas de ocio: $horasOcio horas");
  print("Horas de sueño: $horasSueno horas");

  // Consejos finales
  print("\nConsejo: Mantenga un equilibrio entre el trabajo, el estudio y el descanso para mejorar su productividad.");
}
