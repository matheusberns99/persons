# CRUD de Pessoas e Endereços

# Postmann
Por ser um projeto API-Only, abaixo está o link da coleção do Postman:
https://drive.google.com/file/d/1oRowTgdCRKQPtLvlC4qzC-okP9_vw8RS/view?usp=drive_link

## Tecnologias Utilizadas

- Ruby on Rails
- PostgreSQL
- RSpec

## Instalação e Configuração

1. Clone o repositório:

   ```sh
   git clone https://github.com/matheusberns99/persons.git
   cd persons
   ```

2. Instale as dependências:

   ```sh
   bundle install
   ```

3. Configure o banco de dados:

   ```sh
   rails db:create db:migrate
   ```

4. Inicie o servidor:

   ```sh
   rails server
   ```

O servidor estará disponível em `http://localhost:3000` ou `127.0.0.1:3000`.

## Executando os Testes

Para rodar os testes automatizados, execute:

```sh
rspec
```

# Cobertura de testes

Para verificar a cobertura de testes, acesse:

http://localhost:63342/persons/coverage/index.html#_AllFiles

## Endpoints Principais

- **Pessoas**
    - `GET /persons` – Lista todas as pessoas
    - `POST /persons` – Cria uma nova pessoa
    - `GET /persons/:id` – Obtém os detalhes de uma pessoa
    - `PUT/PATCH /persons/:id` – Atualiza uma pessoa
    - `DELETE /persons/:id` – Inativa uma pessoa
    - `PUT/PATCH /persons/:id/recover` – Reativa uma pessoa

- **Endereços**
    - `GET /persons/:person_id/addresses` – Lista os endereços de uma pessoa
    - `POST /persons/:person_id/addresses` – Cria um novo endereço
    - `GET /persons/:person_id/addresses/:id` – Obtém os detalhes de um endereço
    - `PUT/PATCH /persons/:person_id/addresses/:id` – Atualiza um endereço
    - `DELETE /persons/:person_id/addresses/:id` – Inativa um endereço
    - `PUT/PATCH /persons/:person_id/addresses/:id/recover` – Reativa um endereço
