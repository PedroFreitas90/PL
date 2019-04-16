BEGIN {FS = "[;]*" }
    NR == 1 {print "digraph{" > "arvore.dot";
             print "rankdir=LR;" > "arvore.dot"
             } 
    NR >2 { if($2 != " " && $6 != " " && $7 != " "){
              print "\""$6"\"""->" "\""$2"\""";" > "arvore.dot";
              print "\""$7"\"""->" "\""$2"\""";" > "arvore.dot";
            }
            else 
                if ($2 != " " && $6 !=" ")
                    print "\""$6"\"""->" "\""$2"\""";" > "arvore.dot";
                else
                    if($2 != " " && $7 !=" ")
                        print "\""$7"\"""->" "\""$2"\""";" > "arvore.dot";
        }
END { 
    print"}" > "arvore.dot"

      print "Nº de utilizadores: " NR-2
}