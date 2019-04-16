BEGIN {FS = "[;]*" }
        NR>2 {if ($2 != " "){
                split($2,a,"[ ]");conta[a[1]]++;contaPessoal[a[1]]++;
               }
              if ($6 != "Não tem" && $6 != " "){
                    split($6,a,"[ ]");conta[a[1]]++;contaPar[a[1]]++;
               }
              if ($7 != " "){
                    split($7,a,"[ ]");conta[a[1]]++;contaPar[a[1]]++;
               }
              if ($8 != " "){
                    split($8,a,"[ ]");conta[a[1]]++;contaConj[a[1]]++;
               }
              }
END { 
      print "Nº de ocorrências do nome próprio:"
      for (nome in conta)
        print nome "->" conta[nome];
      print "\n"
      
      print "Nº de ocorrências do nome como nome pessoal do requerente:"
        for (nome in contaPessoal)
            print nome "->" contaPessoal[nome];
      print "\n" 
      
      print "Nº de ocorrências do nome como nome pessoal de um dos pais do requerente:"
        for (nome in contaPar)
            print nome "->" contaPar[nome];
      print "\n"

      print "Nº de ocorrências do nome como nome do conjugue do requerente:"
        for (nome in contaConj)
            print nome "->" contaConj[nome];
      print "\n"

      print "Nº de utilizadores: " NR-2
}