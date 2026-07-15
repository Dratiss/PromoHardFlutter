# PromoHard

App Flutter de promoções de tecnologia.

## Como rodar

Se você **ainda não tem** as pastas `android/`, `ios/`, etc. (esse pacote só
tem `lib/`, `pubspec.yaml` e `assets/`), gere o esqueleto do projeto primeiro:

```bash
flutter create --org com.seudominio --project-name promohard .
```

Isso vai criar `android/`, `ios/`, `web/`, etc. **sem sobrescrever** o `lib/`
e o `pubspec.yaml` que já estão prontos aqui (responda "y" se ele perguntar
para manter os arquivos existentes, ou copie estes arquivos por cima depois).

Se você **já tem** o projeto completo e só quer atualizar o código, é só
substituir a pasta `lib/`, o `pubspec.yaml`, o `.gitignore` e o
`analysis_options.yaml` pelos deste pacote.

Depois:

```bash
flutter pub get
flutter analyze     # confere que não há erros
flutter run          # roda no emulador/dispositivo conectado
```

## Subir no GitHub

```bash
git init
git add .
git commit -m "PromoHard - versão inicial corrigida"
git branch -M main
git remote add origin https://github.com/SEU_USUARIO/SEU_REPOSITORIO.git
git push -u origin main
```

O `.gitignore` incluso já ignora `build/`, `.dart_tool/` e outros arquivos
gerados que não devem ir para o repositório.

---

## O que foi corrigido / organizado

1. **Estrutura de pastas**: os arquivos estavam soltos; agora seguem a
   estrutura que os próprios `import`s do código esperam:
   - `lib/main.dart`, `lib/main_navigation.dart`
   - `lib/pages/*.dart`
   - `lib/services/*.dart`
   - `lib/widgets/*.dart`
2. **Erro real de compilação**: `PromoCard` (em `widgets/promocard.dart`)
   **não tem** um parâmetro `category`, mas `home.dart`,
   `category_products_page.dart` e `favorites_page.dart` estavam passando
   `category: promo["category"]` na hora de criar o card — isso não
   compilava (`The named parameter 'category' isn't defined`). Removido nos
   três lugares.
3. **`pubspec.yaml`**: a chave de configuração do `flutter_launcher_icons`
   (>=0.10) é `flutter_launcher_icons:`, não `flutter_icons:` (a antiga não
   quebra o build do app, mas faz o gerador de ícones simplesmente ignorar a
   configuração). Corrigido.
4. **Assets ausentes**: o `pubspec.yaml` referenciava `assets/` e
   `assets/icon/`, mas essas pastas não existiam — isso quebra
   `flutter run`/`flutter build` com "unable to find directory entry".
   Criei ícones de placeholder (`icon.png` e `icon_foreground.png`) em
   preto e dourado com "PH" para o app buildar; troque pela arte final
   quando tiver.
5. **`share_plus` 10.x**: `Share.share(...)` está depreciado nessa versão
   em favor de `SharePlus.instance.share(ShareParams(...))`. Atualizado em
   `promo_details_page.dart` (o código antigo ainda funcionaria, só geraria
   aviso de depreciação).
6. **`PromoCard` virou `StatefulWidget`**: no código original, tocar no
   coração de favoritos chamava `FavoritesService.addFavorite/removeFavorite`
   mas nada dava rebuild no ícone (ele é `StatelessWidget` e a tela pai não
   chamava `setState`). Na prática, o coração só "atualizava" visualmente se
   a tela inteira recarregasse por outro motivo. Agora o próprio card
   gerencia seu estado local e atualiza na hora.
7. **Pequenos ajustes de robustez**: `errorBuilder` nas imagens de rede
   (evita crash visual se a URL da imagem falhar), guarda de `mounted` no
   timer da splash screen (evita erro se o usuário sair da tela antes dos
   3 segundos), `const` em vários construtores, `LoadingWidget` (que estava
   sem uso) agora é usado nos estados de carregamento do Home e da tela de
   categoria.
8. **`analysis_options.yaml` e `.gitignore`**: não existiam; adicionados
   (padrão Flutter) para o repositório ficar completo e o `flutter analyze`
   funcionar com as regras do `flutter_lints`.

## Observações (não são erros, só pra você saber)

- **Paleta de cores inconsistente**: `main.dart`, `main_navigation.dart`,
  `splash_page.dart` e `promocard.dart` usam a paleta "Black & Gold"
  (`AppColors`), mas a maioria das telas (`home`, `categories`,
  `favorites_page`, `build_pc`, `profile`, `settings_page`, `about_page`,
  `category_products_page`, `promo_details_page`) usa cores roxas/vermelhas
  fixas (`Colors.purpleAccent`, `Colors.redAccent` etc.) em vez do
  `AppColors`. Funciona normalmente, só não é 100% visualmente consistente.
  Se quiser, eu unifico tudo para o tema dourado.
- **Categorias x API**: `category_products_page.dart` filtra promoções
  comparando `categoryName` (ex.: "Placas de Vídeo") com o campo
  `category` que vem da API. Se a API não usar exatamente os mesmos nomes
  (acentos, maiúsculas etc.), a lista pode aparecer vazia — isso depende do
  conteúdo do `Promotions.json`, não do código Dart em si.
- **`widgets/product_card.dart`**: não é usado em nenhuma tela hoje (ficou
  como componente alternativo). Pode ser removido com segurança se não for
  usar, ou aproveitado depois.
- **`services/api_service.dart`**: está vazio (só um comentário), reservado
  para uma futura camada de API. Quem realmente busca as promoções hoje é
  `promo_service.dart`.
