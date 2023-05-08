# Ruby Engineer Coding Challenge

## Observações

Eu optei por rodar o banco de dados via Docker. Caso for rodar o banco localmente, alterar as credenciais do banco em `database.yml`.

## Como instalar

```
bundle install
bundle exec rake db:drop db:create db:migrate
```

## Como rodar aplicação

```
rails s
```

## Como rodar os testes

```
bundle exec rspec
```

## Endpoints

```
POST /products

Exemplo: `curl -d '{"name": "super produto", "price": 100.2, "photo_url": "https://google.com/img.jpg"}' -H "Content-Type: application/json" -X POST http://localhost:3000/products`
```

```
GET /products
Exemplo: `curl -H "Content-Type: application/json" -X GET http://localhost:3000/products\?page\=0&name=sup`
```

```
PATCH /products/:id/deactivate
Exemplo: `curl -H "Content-Type: application/json" -X PATCH http://localhost:3000/products/deactivate/1`
```
