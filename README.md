# Gerenciador de Tarefas

Aplicativo desenvolvido em Flutter para o gerenciamento de tarefas, como prova na P2.

## Funcionalidades

- Cadastro e login de usuários.
- Visualização de resumo das tarefas.
- Listagem de tarefas cadastradas.
- Cadastro, edição e exclusão de tarefas.
- Marcação de tarefas como concluídas.
- Definição de prioridades e datas de vencimento.
- Alternância entre tema claro e escuro.
- Tela de informações sobre o aplicativo.

## Tecnologias utilizadas

- Flutter
- Dart
- Firebase Authentication
- Cloud Firestore

## Requisitos

- Flutter instalado e configurado.
- Dart SDK.
- Android Studio e Visual Studio Code.
- Conexão com a internet.

## Como executar o projeto

1. Clone este repositório:

```bash
git clone URL_DO_REPOSITORIO
```

2. Acesse a pasta do projeto:

```bash
cd NOME_DO_PROJETO
```

3. Instale as dependências:

```bash
flutter pub get
```

## Configuração do Firebase

O projeto utiliza Firebase para autenticação de usuários e armazenamento das tarefas no Cloud Firestore.

Para configurar:

1. Acesse o [Firebase Console](https://console.firebase.google.com/).
2. Crie um projeto no Firebase.
3. Adicione um aplicativo Android ao projeto.
4. Configure o Firebase Authentication e habilite o método de login utilizado pelo aplicativo.
5. Crie um banco de dados no Cloud Firestore.
6. Configure a conexão do Flutter com o Firebase utilizando o FlutterFire CLI.

Após a configuração, verifique se o arquivo `firebase_options.dart` está disponível e execute o aplicativo.

## Executar o aplicativo

No terminal, execute:

```bash
flutter run
```

## Desenvolvedor

Leonardo Viana