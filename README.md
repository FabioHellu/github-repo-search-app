# GitHub Repositories Search APP

APP para consulta de respositórios no GitHub.

## Instalação

É necessário ter instalado o `Ruby 2.5.3` e o `Ruby on Rails ~> 5.2.3` e `MySQL 5+`.

Para configurar o Access Token do GitHub, adicione o arquivo `config/local_env.yml`, com o conteúdo:

```yaml

GITHUB_ACCESS_TOKEN: 'TOKEN'
DB_HOST: 'localhost'
DB_USERNAME: 'root'
DB_PASSWORD: 'root'

```

Passos para inicializar:

`bundle install`

`rails db:create`

`rails db:migrate`

`rails server`

Para executar os testes automatizados, execute:

`rails test`