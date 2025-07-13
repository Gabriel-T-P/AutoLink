## Sumário do Projeto

O **AutoLink** é uma aplicação web desenvolvida em Ruby on Rails 8, projetada para ser um classificado de veículos online. O objetivo principal do projeto é demonstrar uma aplicação Rails básica, porém funcional, com funcionalidades de listagem e pesquisa de carros.

Este projeto utiliza:
* **Ruby 3.4.2**
* **Rails 8.0.2**
* **SQLite3**
* **Bootstrap 5** para estilização e responsividade, gerenciado via `cssbundling-rails`
* **Hotwire (Turbo e Stimulus)** para uma experiência de usuário rápida e interativa.

**Principais funcionalidades:**
* Listagem e visualização detalhada de modelos de carros e carros disponíveis.
* Formulário de contato para interessados nos veículos.
* Funcionalidade de busca de carros por termos gerais e filtros específicos (marca, preço, transmissão, etc.).
* Internacionalização (I18n) para diferentes idiomas.

O projeto foi desenvolvido com foco em boas práticas, incluindo 100% de cobertura de testes com RSpec pela gem SimpleCov.

## Rodando o Projeto Localmente

Siga estas instruções para configurar e executar o projeto AutoLink em sua máquina local.

### Pré-requisitos

Certifique-se de ter as seguintes ferramentas instaladas:

* **Ruby:** Versão 3.4.2.
* **Bundler:** Gerenciador de dependências de Ruby.
    ```bash
    gem install bundler
    ```
* **Node.js e Yarn:** Necessários para o `cssbundling-rails`.
    * Instale o Node.js.
    * Instale o Yarn: `npm install --global yarn`

### Instalação

1.  **Clone o repositório:**
    ```bash
    git clone git@github.com:Gabriel-T-P/AutoLink.git
    cd AutoLink
    ```

2.  **Instale as dependências do Ruby:**
    ```bash
    bundle install
    ```

3.  **Instale as dependências do JavaScript (e CSS):**
    ```bash
    yarn install
    ```

4.  **Configurar o Banco de Dados:**

    * **Crie o banco de dados e execute as migrações:**
        ```bash
        rails db:migrate
        ```

    * **Popule o banco de dados com dados de exemplo:**
        Para ter alguns dados para testar a aplicação, você pode executar as seeds:
        ```bash
        rails db:seed
        ```

## Executando o Servidor

Para rodar o servidor localmente com Bootstrap e CSS em tempo real, use o comando `bin/dev`:
```bash
bin/dev
```

Após iniciar o servidor, você pode acessar a aplicação em seu navegador através do endereço:
```bash
http://localhost:3000
```

## Rodando os Testes

O  projeto possui 100% de cobertura de testes com RSpec. Para executar a suíte de testes:
```bash
bundle exec rspec
```

## Tomada de Decisões

### 1. Separação de `Car` e `CarModel`

A modelagem de dados foi cuidadosamente pensada, resultando na criação de dois modelos distintos: `Car` e `CarModel`.
* **`CarModel`**: Representa as características gerais de um modelo de carro (marca, nome, motor, tipo de combustível, etc.). Essas informações são frequentemente repetidas para diferentes unidades de um mesmo modelo.
* **`Car`**: Representa uma unidade específica e única de carro à venda, com atributos como preço, quilometragem, placa e localização.

Essa separação é uma melhor prática em Rails (e em design de banco de dados em geral) para:
* **Normalização de Dados:** Evita a duplicação de informações, garantindo a integridade e reduzindo a pegada do banco de dados.
* **Organização Lógica:** Espelha a realidade do negócio, onde um "modelo" de carro é diferente de uma "unidade" de carro.
* **Manutenibilidade:** Facilita a gestão de dados; por exemplo, se a especificação de um modelo de motor muda, a alteração é feita em apenas um local (`CarModel`), afetando todos os carros daquele modelo automaticamente.
* **Consultas Eficientes:** Otimiza as consultas, permitindo buscar informações específicas de modelo ou de unidade de forma mais direta.

---

### 2. Reutilização de Formulários com Partials e Gestão de Erros

A criação do formulário de contato como uma partial (`_form.html.erb`) foi uma decisão focada na reutilização de código. Isso permitiu que o mesmo formulário fosse incorporado em múltiplos locais da aplicação, como na página de detalhes de um carro (`cars/show`) e em uma página de contato dedicada (`contact_messages/new`), eliminando a necessidade de reescrever HTML e lógica de formulário.

No entanto, essa abordagem trouxe um problema na renderização de erros de validação. Quando o formulário era submetido com dados inválidos, o `else` do controller de `ContactMessages` originalmente renderizava a `new` action, o que descontextualizava o usuário da página onde ele estava preenchendo o formulário (ex: a página de detalhes do carro).

---

### 3. Desenvolvimento Orientado a Testes (TDD) e Cobertura de Testes

Desenvolvimento Orientado a Testes (TDD) é uma prática fundamental adotada neste projeto. Essa metodologia não apenas **minimiza a ocorrência de erros e bugs** durante o desenvolvimento, mas também serve como uma "rede de segurança". A cada nova funcionalidade ou refatoração, os testes existentes garantem que nenhuma regressão foi introduzida, assegurando a estabilidade da aplicação.

Além disso, atingir e manter 100% de cobertura de testes é um ótimo parâmetro para um projeto. Além de ser um forte indicador da qualidade do código e da robustez da aplicação.

---

### 4. Otimização de Performance com Turbo Frames na Busca de Carros

Na implementação da funcionalidade de busca de carros (`cars/search`), foi feita a escolha de utilizar Turbo Frames do Hotwire. Este é um exemplo clássico de onde o Turbo Frames brilha: quando há uma página que frequentemente "redireciona para si mesma" após uma ação (neste caso, a submissão de um formulário de busca ou filtro). A utilização dele resulta em uma performance maior da página que foi utilizado e mais interatividade.

---

### 5. Escolha de Framework CSS: Bootstrap para Agilidade e Responsividade

Para a estilização do aplicativo, o Bootstrap foi a escolha inicial, priorizando a agilidade no desenvolvimento e a responsividade. O Bootstrap oferece um vasto conjunto de componentes UI pré-estilizados e um sistema de grid robusto, permitindo a rápida prototipagem e a construção de interfaces atraentes e responsivas sem demandar muito tempo em CSS customizado.

Uma vantagem importante do Bootstrap para este projeto é o carrossel de imagens (utilizado na página de detalhes do carro). Diferentemente do Tailwind CSS, onde um carrossel exigiria a implementação manual da lógica via Stimulus (ou JavaScript puro), o Bootstrap já oferece uma solução pronta para uso.

Embora o Bootstrap tenha sido a escolha para acelerar o processo inicial, eu costumo usar o Tailwind que oferece maior flexibilidade para criar uma identidade visual única e personalizada. Se houvesse mais tempo e um foco maior em design de UI/UX customizado, o Tailwind seria a escolha preferencial para atingir uma "personalidade" visual mais distinta.
