BEGIN{DE="Database Entry: "}
/End of/ { next; }
{ sub("Ship's Database - Dilithium", DE "Dilithium", $0); }
/(Deep Space Hibernation: |Weapons System: )/ { split($0, A, ": "); DB[DE A[1]]=A[2]"\n"; }
{ sub("Log, Day 113", "Log - Mission Day 113", $0); }
{ sub(", Supplemental", " - Mission Day 113, Supplemental", $0); }
/^(Database|Captain's Log)/ { K=$0; DB[K]=""; getline; }
/User/ { K=""; }
{if ( K != "" ) { DB[K]=DB[K]"\n"$0; }}
END{ for (i in DB) { print i":\n"DB[i]; print "------------------------"; } }
