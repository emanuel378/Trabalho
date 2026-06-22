# Estrutura do Projeto Astrolume

```
lib/
├── main.dart                 # Ponto de entrada da aplicação
├── core/                     # Código central/shared da aplicação
│   ├── constants/            # Constantes globais (cores, strings, chaves)
│   ├── theme/                # Temas (light/dark), text styles, decorações
│   ├── routes/               # Configuração de rotas e navegação
│   └── utils/                # Helpers, extensions, formatters
├── data/                     # Camada de dados
│   ├── database/             # Configuração do banco local (SQLite/Hive/etc)
│   ├── models/               # Modelos de dados (entities, DTOs)
│   └── repositories/         # Implementações dos repositories
├── services/                 # Serviços e integrações externas
│   ├── langchain/            # Integração com LangChain para IA
│   ├── speech/               # Speech-to-text, text-to-speech
│   ├── auth/                 # Autenticação (Firebase, Supabase, etc)
│   └── api/                  # Cliente HTTP, interceptors, endpoints
├── pages/                    # Telas da aplicação (feature-based)
│   ├── splash/               # Tela de splash/loading inicial
│   ├── home/                 # Tela principal/dashboard
│   ├── login/                # Login e cadastro
│   ├── perfil/               # Perfil do usuário
│   ├── missoes/              # Missões/desafios do usuário
│   ├── questoes/             # Questões/quiz
│   ├── ranking/              # Ranking/leaderboard
│   ├── configuracoes/        # Configurações do app
│   └── ia_tutor/             # Chat com tutor de IA
├── widgets/                  # Componentes reutilizáveis
│   ├── cards/                # Cards diversos (missão, ranking, etc)
│   ├── buttons/              # Botões customizados
│   ├── dialogs/              # Dialogs, bottom sheets, modais
│   └── shared/               # Widgets compartilhados (inputs, loaders, etc)
├── providers/                # Estado global (Riverpod, Provider, Bloc)
├── assets/                   # Recursos estáticos
│   ├── images/               # Imagens (png, jpg, webp)
│   ├── icons/                # Ícones customizados (svg, font)
│   ├── sounds/               # Efeitos sonoros, áudios
│   ├── animations/           # Lottie, Rive, animações custom
│   └── fonts/                # Fontes customizadas
└── tests/                    # Testes (unit, widget, integration)
```

## Convenções

- **Feature-first**: Cada tela em `pages/` é uma feature isolada
- **Clean Architecture**: `data/` separa models/repositories dos services
- **Shared UI**: Widgets genéricos em `widgets/shared/`, específicos em subpastas
- **Providers** na raiz para estado global acessível
- **Assets** organizados por tipo para fácil manutenção