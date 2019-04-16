BEGIN{ FS = "[;]*" }
	NR == 3 {for(i = 1; i < NF; i++) print i "->" $i "\n"}
END{;}
