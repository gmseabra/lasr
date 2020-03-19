#!/bin/awk

BEGIN{
#    INDEX=""; count=""
}
{
    RESNAME = toupper(substr($6,1,1)) tolower(substr($6,2))
    RESNUM = $7 + 5
    INDEX = $2 "\t" $4 "\t" RESNAME RESNUM "\t" $8

    count[INDEX] = count[INDEX]+1

}
END{
    print("Lig\tLigAtom\tResid\tResAtom\tCount")
    for (ind in count)
        print(ind "\t" count[ind])
}
