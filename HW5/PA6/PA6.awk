BEGIN{DE="Database Entry: "}
/End of/ { next; }
{ sub("Ship's Database - Dilithium", "Database Entry: Dilithium:"); }
/(Deep Space Hibernation|Weapons System)/ { split($0, A, ": "); DB[A[1]]=A[2]"\n"; }
{ sub("Log, Day 113", "Log - Mission Day 113"); }
{ sub(", Supplemental", " - Mission Day 113, Supplemental"); }
/(Database|Captain's Log)/ { K=$0; DB[K]=""; getline; }
/Users/ { K=""; }
{if ( K != "" ) { DB[K]=DB[K]"\n"$0; }}
END{ for (i in DB) { print DB[i]; } print "------------------------"; }
