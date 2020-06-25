cat Ganguly_Debasis.bib |awk '{if (index($0,"article")>0)f=1; else if (f==1&&index($0,"}")==1) {f=0; print "\n"} else if (f==1) print $0;}' > journals.tmp

#echo | awk '{printf("%s\t%s\t%s\t%s\t%s\t%s\n", "pub_date", "title", "venue", "excerpt", "citation", "url_slug", "paper_url")}' > journals.tsv

cat journals.tmp | awk '{if (NF<1) {print b; b=""} else b=b" "$0;}' > journals_pp.tmp
cat journals_pp.tmp |sed 's/{//g' | sed 's/}//g'|awk -F ',' '{if (NF>0) {print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $NF}}'|awk -F '\t' '{print "* " $1"," $2 "," $3 "," $4 "," $NF}'|sed 's/author//g'|sed 's/title//g' | sed 's/journal//g'|sed 's/year//g' |sed 's/=//g'|awk '{if (NF>0) print $0}' | sed -E 's/[ ]+/ /g' | sed "s/\\\//g" |sed "s/'//g" >> journals.tsv


cat Ganguly_Debasis.bib |awk '{if (index($0,"inproceedings")>0)f=1; else if (f==1&&index($0,"}")==1) {f=0; print "\n"} else if (f==1) print $0;}' > confs.tmp

#echo | awk '{printf("%s\t%s\t%s\t%s\t%s\t%s\n", "pub_date", "title", "venue", "excerpt", "citation", "url_slug", "paper_url")}' > confs.tsv
cat confs.tmp | awk '{if (NF<1) {print b; b=""} else b=b" "$0;}' > confs_pp.tmp
cat confs_pp.tmp |sed 's/{//g' | sed 's/}//g'|awk -F ',' '{if (NF>0) {print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $NF}}'|awk -F '\t' '{print "* " $1"," $2 "," $3 "," $4 "," $NF}'|sed 's/author//g'|sed 's/booktitle//g' | sed 's/title//g'|sed 's/year//g' |sed 's/=//g'|awk '{if (NF>0) print $0}' | sed -E 's/[ ]+/ /g' |sed "s/\\\//g" |sed "s/'//g" >> confs.tsv

PUBFILE=../_pages/pubs.md

cat > $PUBFILE << EOF1
---
layout: archive
title: "Publications"
permalink: /pubs/
author_profile: true
---

EOF1

echo "### Conferences" >> $PUBFILE
echo "" >> $PUBFILE
cat confs.tsv >> $PUBFILE

echo "" >> $PUBFILE
echo "### Journals" >> $PUBFILE
echo "" >> $PUBFILE
cat journals.tsv >> $PUBFILE

rm confs.tsv
rm journals.tsv
rm *tmp

