import 'package:presente_campo/model/caso.dart';
import 'package:presente_campo/model/mensagem.dart';
import 'package:presente_campo/model/motivo.dart';
import 'package:presente_campo/model/status_caso.dart';
import 'package:presente_campo/model/tipo_servico.dart';

DateTime _dia(int mes, int dia) => DateTime(2026, mes, dia);

List<Caso> getAllCasosDemonstracao() {
  return [
    Caso(
      id: '1',
      aluno: 'Mateo Quispe Mamani',
      turma: '6º A',
      responsavel: 'Rosa Mamani',
      idioma: 'Espanhol',
      motivo: Motivo.cuidadoFamiliar,
      status: StatusCaso.aberto,
      urgente: true,
      resumoIa:
          'Mateo falta para cuidar da irmã de 3 anos enquanto a mãe trabalha '
          'em uma oficina de costura. A família não conseguiu vaga em creche.',
      encaminhamento: TipoServico.cras,
      faltas: [_dia(9, 1), _dia(9, 8), _dia(9, 15), _dia(9, 22), _dia(9, 29)],
      mensagens: const [
        Mensagem(
          daFamilia: false,
          textoOriginal:
              'Hola, soy el asistente de la escuela. Notamos que Mateo faltó '
              'algunos días. ¿Está todo bien?',
          textoPortugues:
              'Olá, sou o assistente da escola. Notamos que o Mateo faltou '
              'alguns dias. Está tudo bem?',
        ),
        Mensagem(
          daFamilia: true,
          textoOriginal:
              'Él se queda con su hermanita los lunes porque yo trabajo en el '
              'taller y no tengo con quién dejarla.',
          textoPortugues:
              'Ele fica com a irmãzinha às segundas porque eu trabalho na '
              'oficina e não tenho com quem deixá-la.',
        ),
      ],
    ),
    Caso(
      id: '2',
      aluno: 'Woodline Jean-Baptiste',
      turma: '6º A',
      responsavel: 'Marie Jean-Baptiste',
      idioma: 'Crioulo haitiano',
      motivo: Motivo.saude,
      status: StatusCaso.encaminhado,
      urgente: false,
      resumoIa:
          'Woodline teve febre e crises de asma. A família não sabe como '
          'marcar consulta na UBS e tem receio por não falar português.',
      encaminhamento: TipoServico.ubs,
      faltas: [_dia(9, 2), _dia(9, 3), _dia(9, 4), _dia(10, 6)],
      mensagens: const [
        Mensagem(
          daFamilia: false,
          textoOriginal:
              'Bonjou, se asistan lekòl la. Woodline pa vin lekòl kèk jou. '
              'Èske tout bagay anfòm?',
          textoPortugues:
              'Bom dia, sou o assistente da escola. A Woodline não veio à '
              'escola alguns dias. Está tudo bem?',
        ),
        Mensagem(
          daFamilia: true,
          textoOriginal: 'Pitit fi m malad, li gen lafyèv ak opresyon.',
          textoPortugues: 'Minha filha está doente, tem febre e falta de ar.',
        ),
      ],
    ),
    Caso(
      id: '3',
      aluno: 'Kauã Ferreira dos Santos',
      turma: '7º B',
      responsavel: 'Luciana Ferreira',
      idioma: 'Português',
      motivo: Motivo.transporte,
      status: StatusCaso.aberto,
      urgente: false,
      resumoIa:
          'Kauã mora a 4 km da escola e a família não tem dinheiro para a '
          'condução no fim do mês. Tem direito ao Passe Livre, mas não pediu.',
      encaminhamento: TipoServico.transporte,
      faltas: [_dia(9, 24), _dia(9, 25), _dia(9, 28), _dia(10, 26)],
      mensagens: const [
        Mensagem(
          daFamilia: false,
          textoOriginal:
              'Olá, aqui é o assistente da escola. O Kauã faltou alguns dias. '
              'Aconteceu alguma coisa?',
          textoPortugues:
              'Olá, aqui é o assistente da escola. O Kauã faltou alguns dias. '
              'Aconteceu alguma coisa?',
        ),
        Mensagem(
          daFamilia: true,
          textoOriginal:
              'No fim do mês o dinheiro da condução acaba, aí ele não vai.',
          textoPortugues:
              'No fim do mês o dinheiro da condução acaba, aí ele não vai.',
        ),
      ],
    ),
    Caso(
      id: '4',
      aluno: 'Sofía Condori Choque',
      turma: '7º B',
      responsavel: 'Juana Choque',
      idioma: 'Espanhol',
      motivo: Motivo.clima,
      status: StatusCaso.aberto,
      urgente: false,
      resumoIa:
          'A rua da casa de Sofía alaga quando chove forte e ela não consegue '
          'chegar ao ponto de ônibus.',
      encaminhamento: TipoServico.transporte,
      faltas: [_dia(9, 1), _dia(9, 18), _dia(10, 9), _dia(10, 16)],
      mensagens: const [
        Mensagem(
          daFamilia: true,
          textoOriginal:
              'Cuando llueve mucho la calle se inunda y no podemos salir.',
          textoPortugues:
              'Quando chove muito a rua alaga e não conseguimos sair.',
        ),
      ],
    ),
    Caso(
      id: '5',
      aluno: 'Pedro Henrique Lima',
      turma: '8º A',
      responsavel: 'José Carlos Lima',
      idioma: 'Português',
      motivo: Motivo.trabalho,
      status: StatusCaso.aberto,
      urgente: true,
      resumoIa:
          'Pedro, 14 anos, está ajudando o pai na feira durante a semana. '
          'Possível trabalho infantil: avaliar com o Conselho Tutelar.',
      encaminhamento: TipoServico.conselhoTutelar,
      faltas: [
        _dia(9, 9),
        _dia(9, 16),
        _dia(9, 23),
        _dia(9, 30),
        _dia(10, 7),
        _dia(10, 14),
      ],
      mensagens: const [
        Mensagem(
          daFamilia: true,
          textoOriginal:
              'Ele tá me ajudando na feira na quarta, a gente precisa da renda.',
          textoPortugues:
              'Ele tá me ajudando na feira na quarta, a gente precisa da renda.',
        ),
      ],
    ),
    Caso(
      id: '6',
      aluno: 'Esther Pierre-Louis',
      turma: '8º A',
      responsavel: 'Jean Pierre-Louis',
      idioma: 'Crioulo haitiano',
      motivo: Motivo.moradia,
      status: StatusCaso.encaminhado,
      urgente: false,
      resumoIa:
          'A família foi despejada e está em um abrigo temporário longe da '
          'escola. Precisa de apoio do CRAS para moradia.',
      encaminhamento: TipoServico.cras,
      faltas: [_dia(10, 1), _dia(10, 2), _dia(10, 5)],
      mensagens: const [
        Mensagem(
          daFamilia: true,
          textoOriginal: 'Nou pa gen kay kounye a, nou nan yon abri.',
          textoPortugues: 'Não temos casa agora, estamos em um abrigo.',
        ),
      ],
    ),
    Caso(
      id: '7',
      aluno: 'Lara Cristina Oliveira',
      turma: '6º A',
      responsavel: 'Patrícia Oliveira',
      idioma: 'Português',
      motivo: Motivo.saude,
      status: StatusCaso.resolvido,
      urgente: false,
      resumoIa:
          'Lara faltou por conjuntivite. Já foi atendida na UBS e voltou às '
          'aulas.',
      encaminhamento: TipoServico.ubs,
      faltas: [_dia(9, 10), _dia(9, 11)],
      mensagens: const [
        Mensagem(
          daFamilia: true,
          textoOriginal: 'Ela está com conjuntivite, volta semana que vem.',
          textoPortugues: 'Ela está com conjuntivite, volta semana que vem.',
        ),
      ],
    ),
    Caso(
      id: '8',
      aluno: 'Ahmad Al-Hassan',
      turma: '7º B',
      responsavel: 'Fátima Al-Hassan',
      idioma: 'Árabe',
      motivo: Motivo.transporte,
      status: StatusCaso.aberto,
      urgente: false,
      resumoIa:
          'A família mudou de bairro e Ahmad depende de dois ônibus. Em dias '
          'de chuva a mãe não deixa ele ir sozinho.',
      encaminhamento: TipoServico.transporte,
      faltas: [_dia(9, 18), _dia(10, 9), _dia(10, 20)],
      mensagens: const [
        Mensagem(
          daFamilia: true,
          textoOriginal: 'ابني يحتاج إلى حافلتين للوصول إلى المدرسة.',
          textoPortugues: 'Meu filho precisa de dois ônibus para chegar à escola.',
        ),
      ],
    ),
  ];
}
