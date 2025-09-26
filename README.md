# Action Network Rails API

API construída com Rails 8 (modo API) para integrar mensagens do Slack com traduções automáticas fornecidas pela OpenAI. O projeto expõe um endpoint REST que retorna as mensagens do canal já acompanhadas de suas traduções em português brasileiro.

## Pré-requisitos

- Ruby 3.2.3
- Bundler
- SQLite 3 (ambiente de desenvolvimento)
- Tokens válidos do Slack e da OpenAI

## Configuração

1. Instale as dependências:

   ```bash
   bundle install
   ```

2. Configure as variáveis de ambiente necessárias. Crie um arquivo `.env` (não versionado) com, pelo menos:

   ```dotenv
   OPENAI_API_KEY=...
   OPENAI_URL=https://api.openai.com/v1/chat/completions
   SLACK_URL=https://slack.com/api/
   SLACK_CHANNEL_ID=...
   SLACK_BOT_TOKEN=...
   ```

3. Prepare o banco de dados (SQLite por padrão):

   ```bash
   bin/rails db:prepare
   ```

## Execução

Inicie o servidor de desenvolvimento:

```bash
bin/dev
```

O serviço estará disponível em `http://localhost:3000`.

## Endpoints

### `GET /messages`

- Obtém o histórico do canal informado via Slack API.
- Traduz cada mensagem (exceto mensagens de bot) com a API da OpenAI.
- Usa um cache em arquivo (`tmp/cache/messages.json`) para evitar traduções repetidas.

Resposta de exemplo:

```json
{
  "messages": [
    {
      "ts": "1715012345.000100",
      "user": "U123456",
      "text": "Good morning!",
      "subtype": null,
      "translated_text": "Bom dia!"
    }
  ]
}
```

## Testes

Execute a suíte de testes padrão do Rails:

```bash
bundle exec rails test
```
