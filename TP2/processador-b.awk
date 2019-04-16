BEGIN {FS = "[;]*" }
        #NR=2 {for (i = 1; i <= NF ; i++) {print i "->" $i} }
        #NR==2 {for (i = 1; i <= NF ; i++){print i "->" $i}
        NR>2 {split($5,a,"[-]|[.]");conta[$4][a[1]]++}
END { print "\n"
       print "Nº de emigrantes por ano:"
      for (conc in conta)
        for (ano in conta[conc])
                print conc "-" ano "->" conta[conc][ano];
      print "\n"
      print "Nº de emigrantes por concelho:"
      for (conc in conta){
        r = 0
        for (ano in conta[conc])
                r+=conta[conc][ano]
        print conc "->" r
      };
      print "Nº de utilizadores: " NR-2
}