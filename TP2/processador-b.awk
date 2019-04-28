BEGIN {
         FS = ";"
         head = "<h1 align=\"center\"> Nº de processos registados </h1>\n";
         head2 = "<h3> %s </h3> <p> %s </p>\n";
         enc = "<html> <head> <meta charset='UTF-8'/> <style>table, th, td {border: 1px solid black; border-collapse: collapse;} th, td {padding: 5px;} th {text-align: left;}</style> </head> <body>";
  	      entrada = "<li><a> %s </a></li>\n";
  	      linha = "<p> %s </p>";
  	      end = "</body> </html>";
  	      elemento = "null";
         table_start = "<table style=\"width:30%\"><tr> <th>%s</th><th>Número de processos registados</th> </tr>";
         table_entry= "<tr> <td> %s </td><td> %d </td> </tr>";
         table_end = "</table>";
         system("mkdir -p output/");
         local = "output/ex-b.html";
}

        NR > 2 {  split($6,a,"[-]|[.]");
                conta[$5][a[1]]++;
                contaA[a[1]]++
         }

END{
   print enc > local;
	print head > local;
   for (conc in conta){
      printf(head2,conc,"") > local;
      printf(table_start,"Ano") > local;
      for (ano in conta[conc])
         printf (table_entry,ano,conta[conc][ano]) > local;
      print table_end > local;
   }
   print "\n<hr>\n" >local;

   printf(head2,"Por Ano","") > local;
   printf(table_start,"Ano") > local;
   for (ano in contaA)
      printf (table_entry,ano,contaA[ano]) > local;
   printf(table_entry,"Total",NR-2) > local;
   print table_end > local;

   print end > local;
}



#END {  print "\n"
#       print "Nº de emigrantes por ano:"
 #       for (conc in conta)
  #         for (ano in conta[conc])
   #           print conc "-" ano "->" conta[conc][ano];
    #   print "\n"

#       print "Nº de emigrantes por concelho:"
 #       for (conc in conta){
  #         r = 0
   #        for (ano in conta[conc])
    #          r+=conta[conc][ano]
     #      print conc "->" r
      # };
       #print "\n"

#       print "Nº de processos por ano:"
 #       for (ano in contaA)
  #         print ano "-" contaA[ano]
   #    print "\n"

    #   print "Nº de utilizadores: " NR-2
#}
