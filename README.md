# Product Storage

Este projeto foi concebido como um teste técnico cujo objetivo é cadastrar lojas e produtos e amarrar ambos através de um estoque.
O projeto está disponível no Heroku, e a documentação da api pode ser acessada através deste [link](https://radiant-plateau-23828.herokuapp.com/documentation).

## Executando o projeto
* Dependências  

  Este projeto foi concebido com o Docker, para executá-lo, é necessário possuir o Docker instalado na máquina, o mesmo pode ser baixado através deste [link](https://docs.docker.com/get-docker/).

* Configuração

  Para rodar o projeto localmente, já com o Docker instalado, navegue até o diretório raíz do projeto e digite: `docker-compose build`

  Após construir as imagens, deverá ser exibido no terminal, na última linha, a instrução `LOG:  database system is ready to accept connections`, isso significa que a imagem já está pronta para se conectar com um banco de dados, então é necessário abrir outro terminal, navegar até a raíz do projeto e digitar o seguinte comando: `docker-compose run web rake db:create db:migrate`, após esse comando, a imagem já possuirá um banco de dados postgresql configurado, para popular o banco com dados iniciais, também é possível executar o comando `docker-compose run web rake db:data`, essa task irá criar 5 produtos, 5 lojas e 5 estoques aleatóriamente ligados as lojas e produtos.
  
  Com o projeto já em funcionamento, é possível navegar até [localhost:3000/documentation](http:\\localhost:3000/documentation) para verificar a documentação e começar a usar as APIs.

