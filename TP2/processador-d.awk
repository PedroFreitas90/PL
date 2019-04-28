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
              print "\x22" $9 "\" -> \"" $2 "\"[color=red,label=\x22 Mãe de \x22];" > local;
            if($11 ~ /[A-Za-z]/ ){
              print "\x22" $2 "\" -> \"" $11 "\"[color=blue,label=\x22 Cônjuge\x22];" > local;
             }
             if($9 ~ /[A-Za-z]/ && $7 ~ /[A-Za-z]/ && $7 != "Não tem" ){
                print "rankdir=BT;" > local;
                print "\x22" $9 "\" -> \"" $7 "\"[color=green];" > local;
                print "rankdir=LR;" > local;
             }
            }


        }
END {
    print"}" > local;
    system("dot -Tpdf output/arvore.dot -o output/arvore.pdf");
    print "Nº de utilizadores: " NR-2
}
