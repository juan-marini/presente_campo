# Especificação — Presente! Campo

## Problema
Na busca ativa escolar, o agente (coordenador, orientador ou assistente social) precisa
acompanhar alunos com faltas recorrentes. As famílias são atendidas pelo WhatsApp (bot do
Presente!), que gera um **caso** com a conversa, o motivo provável da falta e um
encaminhamento sugerido. O agente precisa de um app de campo para ver, filtrar e agir
sobre esses casos.

## Usuário
Agente de busca ativa da escola. Não é um app para as famílias.

## Requisitos funcionais
| ID | Requisito | Critério de aceite |
|---|---|---|
| RF01 | Splash | Mostra o logo (`Image.asset`), espera ~2 s e lê `onboarding_visto` no SharedPreferences: `true` → Principal; `false`/ausente → Onboarding. |
| RF02 | Onboarding | 4 páginas com ícone, título e descrição; botões Voltar/Avançar (Voltar desabilitado na 1ª); checkbox "Não mostrar novamente"; ao concluir grava `onboarding_visto = valor do checkbox`. Sem marcar, aparece de novo na próxima abertura. |
| RF03 | Navegação | Rotas nomeadas (`AppRoutes` + `onGenerateRoute`). Principal com 4 abas (Painel, Casos, Rede, Padrões) via `BottomNavigationBar`. Caso → Detalhe com o `Caso` como argumento; Detalhe devolve o caso atualizado no `pop`. |
| RF04 | Painel | Cards de resumo: casos abertos, urgentes, encaminhados; motivos mais comuns; lista de urgentes (toque abre o Detalhe). |
| RF05 | Casos | Lista (`ListView.builder`) de `CasoCard`; busca por nome do aluno; filtro por motivo (chips) e por status (dropdown); botão atualizar; estrela "acompanhando" no card; lista vazia com mensagem. |
| RF06 | Detalhe | Dados do caso, status, motivo, resumo da IA, encaminhamento sugerido, faltas, conversa com alternância "ver original / ver em português"; botões Encaminhar, Marcar acompanhando, Marcar resolvido. |
| RF07 | Rede de apoio | Lista de serviços (CRAS, UBS, Conselho Tutelar, transporte) com os motivos que atendem; filtro por tipo. |
| RF08 | Padrões | Estado **inicial** real ("escolha a turma e toque em Analisar"); consulta a Open-Meteo e mostra "X% das faltas foram em dia de chuva". |
| RF09 | Favoritos | IDs de casos "acompanhando" salvos no SharedPreferences; ícone muda na hora. |

## WebService (requisito 4)
- **Open-Meteo Archive** (pública, sem chave):
  `GET https://archive-api.open-meteo.com/v1/archive?latitude=..&longitude=..&start_date=AAAA-MM-DD&end_date=AAAA-MM-DD&daily=precipitation_sum&timezone=America/Sao_Paulo`
- **API própria do MVP** (`GET /casos`, `PATCH /casos/{id}`): usada quando `ApiConfig.casosBaseUrl`
  estiver preenchida; senão o app usa o repositório local de demonstração (mesma interface).
- Pacote `http`, `jsonDecode`, models com `fromJson`.
- Estados `ViewState { inicial, carregando, sucesso, erro }`, mensagem amigável e botão "Tentar novamente".

## Interações (mínimo 3)
1. Toque no caso → Detalhe (obrigatória)
2. Busca + filtro por motivo/status
3. Favoritar "acompanhando" (persistido)
4. Encaminhar/Resolver muda status e a cor do badge
5. Alternar original/tradução da conversa
6. Atualizar a lista

## Regras de negócio (testadas, fora dos widgets)
- **Filtro**: busca sem diferenciar maiúsculas; motivo e status opcionais; combinam com E.
- **Resumo**: abertos = status ≠ resolvido; urgentes = urgente e ≠ resolvido; motivos ordenados por quantidade.
- **Status**: encaminhar só de `aberto`; resolver de `aberto` ou `encaminhado`; transição inválida → `ArgumentError`.
- **Favoritos**: alternar adiciona se ausente, remove se presente.
- **Padrões**: dia de chuva = precipitação ≥ 1,0 mm; percentual = faltas em dia de chuva / faltas com dado de clima × 100; sem faltas → 0%.

## Não funcionais
- Gerenciamento de estado só com `setState`.
- Build sem erros (`flutter analyze` limpo, `flutter test` verde, `flutter build apk`).
- Permissão INTERNET no AndroidManifest.

## Fora do material do curso (exigido pela rubrica)
`shared_preferences` (requisitos 1 e 2 da GS) e `BottomNavigationBar` (apenas citado na apostila PrimeiroApp).
