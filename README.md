# PL

# COMO CORRER:

1º Passo:
- Fazer download do ficheiro xml em: http://natura.di.uminho.pt/~jj/pl-19/wiki/ptwikiquote/ e descompactar para ficar em formato XML.

2º Passo:
- Abrir terminal na diretoria onde está a pasta com estes ficheiros;

- Fazer: 
            make exY
onde Y é o número do exercício e apenas toma os valores 1, 2 ou 3.

- Fazer:
            ./exY < YOUR_PATH/ptwikiquote-20190301-pages-articles.xml
onde YOUR_PATH é o caminho até à diretoria onde está o ficheiro XML baixado.

NOTA:

    Como limpar?
        - Para limpar os outputs e executável de um exercício específico:
                            make clean-exY
        - Para limpar todos os outputs e executáveis:
                            make clean


Último passo:
    HAVE FUN 😎😎😎
