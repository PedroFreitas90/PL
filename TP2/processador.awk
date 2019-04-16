BEGIN {FS = "[;]*" }

        NR > 2 {conta[$4][$3]++}

END { print "\n"
      print "Nº de emigrantes por freguesia:"
        for (conc in conta)
            for (freg in conta[conc])
                print conc "-" freg "->" conta[conc][freg];
      print "\n"
      
      print "Nº de emigrantes por concelho:"
      for (conc in conta){
         r = 0
         for (freg in conta[conc])
                r+=conta[conc][freg]
        print conc "->" r
      };
      print "Nº de utilizadores: " NR-2
}