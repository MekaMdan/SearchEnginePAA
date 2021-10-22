# README

1. bundle install
2. bundle exec figaro install
3. preencher o arquivo application.yml com:

``` yml
DB_USER: postgres
DB_PASSWORD: postgres
```

4. rodar o postgres localmente ou no docker (recomendo docker)
5. rake db:create
6. rake db:migrate
7. rails s

Isso deve deixar o projeto rodando
versão do ruby 2.7.2 e rails 5.1.6