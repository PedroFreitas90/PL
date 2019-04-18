BEGIN {
    FS = "[;]*" 
    system("mkdir -p output/");
    local = "output/arvore.dot";  
}
    NR == 1 {
        print "digraph{" > local;
        print "rankdir=LR;" > local;
            } 
    
    NR >2 { 
        if($2 != " " && $6 != " " && $7 != " "){
              print "\""$6"\"""->" "\""$2"\""";" > local;
              print "\""$7"\"""->" "\""$2"\""";" > local;
            }
            else 
                if ($2 != " " && $6 !=" ")
                    print "\""$6"\"""->" "\""$2"\""";" > local;
                else
                    if($2 != " " && $7 !=" ")
                        print "\""$7"\"""->" "\""$2"\""";" > local;
        }
END { 
    print"}" > local;
    system("dot -Tpdf output/arvore.dot -o output/arvore.pdf");
    print "Nº de utilizadores: " NR-2
}