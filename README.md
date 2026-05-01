# 🎮 GameStore — Flutter + Provider

Mini projeto de loja de games desenvolvido em Flutter com gerenciamento de estado usando **Provider**.

---

## 📱 Telas

| Tela | Descrição |
|------|-----------|
| **Home** | Catálogo de games em grid com banner promocional e badge no carrinho |
| **Detalhe** | Informações completas do game, quantidade no carrinho, botão de adicionar |
| **Carrinho** | Listagem dos itens, controle de quantidade (+/-), resumo e finalização |

---

## 🗂️ Estrutura do Projeto

```
lib/
├── main.dart                    # Ponto de entrada + ChangeNotifierProvider
├── models/
│   ├── game.dart                # Modelo do game (id, nome, preço, etc.)
│   └── cart_item.dart           # Modelo do item do carrinho (game + quantidade)
├── providers/
│   ├── cart_provider.dart       # Estado global do carrinho (ChangeNotifier)
│   └── games_data.dart          # Catálogo de games
└── pages/
    ├── home_page.dart           # Tela principal com grid de games
    ├── detail_page.dart         # Tela de detalhe do game
    └── cart_page.dart           # Tela do carrinho
```

---

## ✅ Requisitos atendidos

- [x] Mínimo de 2 telas (3 telas: Home, Detalhe, Carrinho)
- [x] Uso do Provider para compartilhar dados (`CartProvider` com `ChangeNotifier`)
- [x] Funcionalidade de **adicionar** e **remover** itens
- [x] Exibição de **total**, **contador** (badge no ícone) e **resumo** no carrinho
- [x] Organização em pastas: `models/`, `providers/`, `pages/`

---

## ▶️ Como rodar

```bash
# Clone o repositório
git clone https://github.com/SEU_USUARIO/loja-games-provider

# Acesse a pasta
cd loja-games-provider

# Instale as dependências
flutter pub get

# Rode o projeto
flutter run
```

---

## 📦 Dependências

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.5+1
```

---

## 🔑 Conceitos de Provider aplicados

```dart
// main.dart — Registro do provider na raiz
ChangeNotifierProvider(
  create: (_) => CartProvider(),
  child: MaterialApp(...),
)

// Leitura reativa (rebuild ao mudar)
final cart = Provider.of<CartProvider>(context);

// Leitura sem rebuild (só executa ação)
final cart = Provider.of<CartProvider>(context, listen: false);
```

---

## 🛠️ Tecnologias

- **Flutter** 3.41.9
- **Dart** 3.11.5 
- **Provider** 6.1.5+1
