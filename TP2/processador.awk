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
        local = "output/ex-a.html";
}

        NR > 2 {conta[$5][$4]++}

END{
        print enc > local;
	print head > local;
        for (conc in conta){
                printf(head2,conc,"") > local;
                printf(table_start,"Freguesia") > local;
                for (freg in conta[conc])
                        printf (table_entry,freg,conta[conc][freg]) > local;
  	        print table_end > local;
        }
        print "\n<hr>\n" >local;

        printf(head2,"Concelhos","") > local;
        printf(table_start,"Concelho") > local;
        for (conc in conta){
                r = 0
                for (freg in conta[conc])
                        r+=conta[conc][freg]
                printf (table_entry,conc,r) > local;

        };
        printf (table_entry,"Total:",NR-2) > local;
        print table_end > local;
        print end > local;
}
