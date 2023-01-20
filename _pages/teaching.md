---
title: "Resources"
permalink: /teaching/
author_profile: true
---

## Software Resources

### Convertor from .bib to .md

You don't need to install anything. All you need to have is a bash shell on Linux/MAC OSX or [Cygwin](https://www.cygwin.com/) on Windows.

Simply download the [script](https://github.com/gdebasis/gdebasis.github.io/blob/master/markdown_generator/bib2md.sh) and invoke it with
```
sh bib2md ".bib file name" "your name"
```
It creates two itemized files named `confs.md` and `journals.md` in the current folder.

For creating this page, I clicked on the `Export bibtex` option on DBLP to download the .bib file and executed the following on my Mac shell.
```
sh bib2md Ganguly_Debasis.bib "Debasis Ganguly"
```

## Slides of Talks
* Slides of the talk on Query Performance Prediction (talk available on YouTube at this [(link)](https://www.youtube.com/watch?v=0KeAjdE2wEs)) [(slides)](http://gdebasis.github.io/files/qpp.pdf).


## Teaching Resources 
### Resources for assignments of the "Text as Data (COMPSCI5096)" course.

* A preprocessed version of Reddit posts for word embedding assignments [(file)](http://gdebasis.github.io/files/reddit_posts.txt).
* The MEN dataset for word pair similarities [(file)](http://gdebasis.github.io/files/men.txt).
* A subset of the Glove word vectors (only for the vocab of the MEN dataset) [(file)](http://gdebasis.github.io/files/men.vocab.glovesubset.txt).
