import 'package:flutter/material.dart';
import 'package:presente_campo/model/onboarding_item.dart';

List<OnboardingItem> getAllOnboardingItems() {
  return const [
    OnboardingItem(
      icone: Icons.school_outlined,
      titulo: 'Toda falta tem um motivo',
      descricao:
          'Transporte, saúde, trabalho, chuva... O Presente! ajuda a escola a '
          'descobrir por que o aluno está faltando, antes que ele abandone.',
    ),
    OnboardingItem(
      icone: Icons.chat_outlined,
      titulo: 'Conversa no WhatsApp, em qualquer língua',
      descricao:
          'A família conversa com o bot pelo WhatsApp, no idioma dela. '
          'Aqui você vê a conversa original e a tradução para o português.',
    ),
    OnboardingItem(
      icone: Icons.alt_route,
      titulo: 'Encaminhamento para a rede certa',
      descricao:
          'Cada caso chega com um motivo provável e um encaminhamento sugerido: '
          'CRAS, UBS, Conselho Tutelar ou Passe Livre.',
    ),
    OnboardingItem(
      icone: Icons.handshake_outlined,
      titulo: 'Você decide',
      descricao:
          'A IA organiza, mas quem decide é o agente de busca ativa. '
          'Revise o caso, encaminhe e acompanhe até o aluno voltar.',
    ),
  ];
}
