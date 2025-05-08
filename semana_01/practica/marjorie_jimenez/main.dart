import 'dart:io';

class Actividad {
  String nombre;
  int horas;

  Actividad(this.nombre, this.horas);

  double calcularPorcentaje(int totalHoras) {
    return (horas / totalHoras) * 100;
  }
}

void main() {
  const int horasTotales = 168;
  List<Actividad> actividades = [];

  stdout.write('Ingresa tu nombre: ');
  String nombre = stdin.readLineSync() ?? 'Usuario';

  stdout.writeln('\nHola, $nombre. Vamos a registrar tus actividades semanales.');
  stdout.writeln('Por defecto usaremos: Trabajo, Estudio, Ocio y Sueño.');

  List<String> nombresActividades = ['Trabajo', 'Estudio', 'Ocio', 'Sueño'];

  for (String act in nombresActividades) {
    stdout.write('¿Cuántas horas dedicas a $act por semana?: ');
    int horas = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
    actividades.add(Actividad(act, horas));
  }

  int totalHorasRegistradas = actividades.fold(0, (sum, act) => sum + act.horas);
  int horasRestantes = horasTotales - totalHorasRegistradas;

  stdout.writeln('\n🔍 Informe de Productividad Semanal para $nombre');
  stdout.writeln('------------------------------------------------');

  for (var actividad in actividades) {
    double porcentaje = actividad.calcularPorcentaje(horasTotales);
    stdout.writeln('${actividad.nombre}: ${actividad.horas}h (${porcentaje.toStringAsFixed(2)}%)');

    if (actividad.nombre == 'Trabajo' || actividad.nombre == 'Estudio') {
      if (actividad.horas > 60) {
        stdout.writeln('⚠️  Alerta: Demasiado tiempo dedicado a ${actividad.nombre}.');
      }
    }
    if (actividad.nombre == 'Sueño' && actividad.horas < 40) {
      stdout.writeln('💤 Sugerencia: Intenta dormir al menos 40h por semana.');
    }
  }

  stdout.writeln('------------------------------------------------');
  stdout.writeln('⏳ Total registrado: $totalHorasRegistradas h');
  stdout.writeln('🕳️  Horas sin registrar: $horasRestantes h');

  if (horasRestantes > 0) {
    stdout.writeln('👀 ¡Aún tienes tiempo libre! ¿Cómo planeas usarlo?');
  } else if (horasRestantes < 0) {
    stdout.writeln('⚠️  Has excedido las 168h semanales. Revisa tus datos.');
  }

  stdout.writeln('------------------------------------------------');
  stdout.writeln('✅ Fin del análisis. ¡Gracias por usar la calculadora!');
}
