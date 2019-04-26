BEGIN {
      FS = "[;]*"
      head = "<h1 align=\"center\"> Nº de ocorrências de nomes próprios </h1>\n";
      head2 = "<h3> %s </h3> <p> %s </p>\n";
      enc = "<html> <head> <meta charset='UTF-8'/> <style>table, th, td {border: 1px solid black; border-collapse: collapse;} th, td {padding: 5px;} th {text-align: left;}</style> </head> <body>";
      entrada = "<li><a> %s </a></li>\n";
  	linha = "<p> %s </p>";
  	end = "</body> </html>";
  	elemento = "null";
      table_start = "<table style=\"width:30%\"><tr> <th>%s</th><th>Número de ocorrências</th> </tr>";
      table_entry= "<tr> <td> %s </td><td> %d </td> </tr>";
      table_end = "</table>";
      system("mkdir -p output/");
      local = "output/ex-c.html";
}
        NR>2 {if ($2 ~ /[A-Z].+/ ){
                split($2,a," ");
                for (nome in a)
                  if(a[nome]!="de" && a[nome]!="do"&& a[nome]!="dos"&& a[nome]!="da" && a[nome]!="e"&& a[nome]!="")
                conta[a[nome]]++;contaPessoal[a[nome]]++;
               }
              if ($6 != "Não tem" && ($6 ~/[A-Z].+/)){
                    split($6,a," ");
                    for (nome in a)
                    if(a[nome]!="de" && a[nome]!="do"&& a[nome]!="dos"&& a[nome]!="da" && a[nome]!="e"&& a[nome]!="")
                    conta[a[nome]]++;contaPar[a[nome]]++;
               }
              if ( $7 ~ /[A-Z].+/ ){
                    split($7,a," ");
                    for (nome in a)
                    if(a[nome]!="de" && a[nome]!="do"&& a[nome]!="dos"&& a[nome]!="da" && a[nome]!="e"&& a[nome]!="")
                    conta[a[nome]]++;contaPar[a[nome]]++;
               }
              if ($8 ~ /[A-Z].+/){
                    split($8,a," ");
                    for (nome in a)
                    if(a[nome]!="de" && a[nome]!="do"&& a[nome]!="dos"&& a[nome]!="da" && a[nome]!="e"&& a[nome]!="")
                    conta[a[nome]]++;contaConj[a[nome]]++;
              }
              }

END{
      print enc > local;
	print head > local;
      #No total
      printf(head2,"Total","") > local;
      printf(table_start,"Nome Próprio") > local;
      for (nome in conta)
            printf (table_entry,nome,conta[nome]) > local;
      print table_end > local;
      print "\n<hr>\n" >local;
      #Relação ao nome do requerente
      printf(head2,"Requerentes","") > local;
      printf(table_start,"Nome Próprio") > local;
      for (nome in contaPessoal)
            printf (table_entry,nome,contaPessoal[nome]) > local;
      print table_end > local;
      print "\n<hr>\n" >local;
      #Nome de um dos pais
      printf(head2,"Parentes de um dos requerentes","") > local;
      printf(table_start,"Nome Próprio") > local;
      for (nome in contaPar)
            printf (table_entry,nome,contaPar[nome]) > local;
      print table_end > local;
      print "\n<hr>\n" >local;
      #Nome do Conjuge
      printf(head2,"Conjuge de um dos requerentes","") > local;
      printf(table_start,"Nome Próprio") > local;
      for (nome in contaConj)
            printf (table_entry,nome,contaConj[nome]) > local;
      print table_end > local;
      print "\n<hr>\n" >local;

}



#END {
#      print "Nº de ocorrências do nome próprio:"
#      for (nome in conta)
#        print nome "->" conta[nome];
#      print "\n"
#
#      print "Nº de ocorrências do nome como nome pessoal do requerente:"
#        for (nome in contaPessoal)
#            print nome "->" contaPessoal[nome];
#      print "\n"
#
#      print "Nº de ocorrências do nome como nome pessoal de um dos pais do requerente:"
#        for (nome in contaPar)
#            print nome "->" contaPar[nome];
#      print "\n"
#
#      print "Nº de ocorrências do nome como nome do conjugue do requerente:"
#        for (nome in contaConj)
#            print nome "->" contaConj[nome];
#      print "\n"#
#
#      print "Nº de utilizadores: " NR-2
#}
