import 'package:presente_campo/model/motivo.dart';

class ResumoPainel {
  final int abertos;
  final int urgentes;
  final int encaminhados;
  final List<MapEntry<Motivo, int>> motivosMaisComuns;

  const ResumoPainel({
    required this.abertos,
    required this.urgentes,
    required this.encaminhados,
    required this.motivosMaisComuns,
  });
}
