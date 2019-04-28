BEGIN {
    FS = ";"
    system("mkdir -p output/");
    local = "output/arvore.dot";
}
    NR == 1 {
        print "digraph{" > local;
        print "rankdir=LR;" > local;
            }

    NR >2 {
        if($2 ~ /[A-Za-z]/ ){
            if($7 ~ /[A-Za-z]/ && $7 != "Não tem" )
              print "\x22" $7 "\" -> \"" $2 "\"[color=red,label=\x22 Pai de \x22];" > local;
            if($9 ~ /[A-Za-z]/  )
              print "\x22" $9 "\" -> \"" $2 "\"[color=red,label=\x22 Mae de \x22];" > local;
            if($11 ~ /[A-Za-z]/ )
              print "\x22" $11 "\" -> \"" $2 "\"[color=blue,label=\x22 Conjuge\x22];" > local;
            }


        }
END {
    print"}" > local;
    system("dot -Tpdf output/arvore.dot -o output/arvore.pdf");
    print "Nº de utilizadores: " NR-2
}
