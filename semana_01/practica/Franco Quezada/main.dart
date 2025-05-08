import 'dart:io';
class Actividad {
  String nombre;
  double horas;

  Actividad(this.nombre, this.horas);

  double calcularPorcentaje() => (horas / 168) * 100;
}
void mostrarAnalisis(List<Actividad> actividades) {
  for (var act in actividades) {
    double porcentaje = act.calcularPorcentaje();
    print("${act.nombre}: ${porcentaje.toStringAsFixed(2)}%");
    if ((act.nombre == 'trabajo' || act.nombre == 'estudio') && act.horas > 60) {
      print(" Advertencia: demasiadas horas en ${act.nombre}.");
    }
    if (act.nombre == 'sueño' && act.horas < 40) {
      print(" Sugerencia: deberías dormir más.");
    }
  }

  double totalHoras = actividades.fold(0, (sum, act) => sum + act.horas);
  if (totalHoras > 168) {
    print("❗ Excediste el límite semanal de horas (168h).");
  } else {
    print(" Total de horas ingresadas: $totalHoras");
  }
}

void main() {
  stdout.write("Ingrese su nombre: ");
  String nombre = stdin.readLineSync()!;

  List<Actividad> actividades = [];

  List<String> nombresActividades = ['trabajo', 'estudio', 'ocio', 'sueño'];

  for (var nombreAct in nombresActividades) {
    stdout.write("Ingrese horas dedicadas a $nombreAct: ");
    double horas = double.parse(stdin.readLineSync()!);
    actividades.add(Actividad(nombreAct, horas));
  }

  print("\n Informe de productividad semanal para $nombre\n");
  mostrarAnalisis(actividades);
}

