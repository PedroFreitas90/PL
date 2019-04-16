BEGIN {FS = "[;]*" }
       #NR==3{ print $2 "->" $6 "->" $8 "->" $7 }
        NR>2 {if ($2 != " "){
                split($2,a,"[ ]");conta[a[1]]++;
               }
              if ($6 != "Não tem" && $6 != " "){
                    split($6,a,"[ ]");conta[a[1]]++;
               }
              if ($7 != " "){
                    split($7,a,"[ ]");conta[a[1]]++;
               }
              if ($8 != " "){
                    split($8,a,"[ ]");conta[a[1]]++;
               }
              }
END { 
      print "Nº de ocorrências do nome próprio:"
      for (nome in conta)
        print nome "->" conta[nome];
      print "\n"
      print "Nº de utilizadores: " NR-2
}