# Slack Translator App

Um app Ruby/Sinatra que traduz mensagens de um canal do Slack em tempo real usando a API da OpenAI, exibindo-as lado a lado em uma interface web acessível via internet (ex: Cloudflare Tunnel). Ideal para entrevistas bilíngues ou conversas assistidas.

---

## Funcionalidades

- Captura mensagens do Slack (mock ou API real)
- Tradução em tempo real via OpenAI (gpt-3.5-turbo)
- Interface web (HTML/CSS/JS puro, sem frameworks)
- Caixa de resposta com tradução reversa e confirmação
- Deploy fácil via `ruby main.rb` ou `cloudflared tunnel`

---

## Requisitos

- Ruby 3.1+
- Bundler
- Conta OpenAI com API Key
- App no Slack com token de bot
- Cloudflare CLI (opcional para túnel público)

---

## Instalação

```bash
# Instale as dependências
bundle install

# Copie o arquivo de exemplo e configure suas variáveis
cp .env.example .env
