# Plano de implementação

## Arquitetura (pastas)
```
lib/
  main.dart                    PresenteCampoApp (MaterialApp + onGenerateRoute)
  app_theme.dart               tema
  model/                       caso, mensagem, motivo, status_caso, servico_rede,
                               clima_dia, resultado_padrao, resumo_painel, view_state,
                               onboarding_item
  data/                        api_config, caso_repository (interface),
                               caso_local_repository, caso_api_repository,
                               clima_service, prefs_service, rede_repository,
                               onboarding_data, casos_fake
  logic/                       casos_filtro, caso_regras, painel_calculo,
                               analisador_padroes   (Dart puro, testado)
  navigation/                  app_routes, app_navigation
  ui/components/               app_logo, caso_card, motivo_chip, status_badge,
                               stat_card, estado_view, onboarding_page,
                               mensagem_bubble, servico_card, secao_titulo
  ui/screens/                  splash, onboarding, principal (abas), painel, casos,
                               caso_detalhe, rede, padroes
assets/images/logo.png
test/                          model/, logic/, data/, ui/
```

## Fluxo de telas
Splash → (Onboarding) → Principal [Painel | Casos | Rede | Padrões] → Detalhe do caso → volta

## Etapas
1. Spec e plano (este arquivo).
2. TDD: escrever os testes das regras (`logic/`), dos models (`fromJson`) e do
   `PrefsService`, e ver falhar.
3. Código: models → data → logic até os testes passarem → componentes → telas → navegação.
4. Revisão: `flutter analyze`, `flutter test`, `flutter build apk`, conferência da rubrica.
5. README, commit e push.

## Fonte de cada conceito (apostilas)
| Conceito | Apostila |
|---|---|
| Stateless/Stateful, setState, Scaffold, assets | PrimeiroApp |
| Componentes por construtor + callback | Componentes-Pokemon |
| Enum de estado + switch, Future.delayed | Chapéu Seletor |
| Tema, TextField/Controller, CheckboxListTile, Switch, Dropdown, enum + extension, interface | Inputs (IronKey) |
| Pastas model/repository/ui, Card, Chip, ListView, filtro com where, equatable | Listas (BoardGames) |
| AppRoutes + onGenerateRoute, telas com callbacks, retorno de dados no pop, Splash | Navegação (DevFest) |
| Parâmetros entre telas, GridView | Lottery |
| http, fromJson, jsonDecode, try/catch/finally, mounted, card de erro | Webservices (ViaCEP) |
| Testes AAA, closeTo, throwsArgumentError, copyWith | Testes (Simulador de Frete) |
