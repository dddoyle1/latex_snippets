#!/bin/bash

input=$1
shift;

snippet=$(cat $input)
tmp_dir=$(mktemp -d -t latex_snippets-XXXXXXXXXX)
tmp_tex=$tmp_dir/$(basename $input)

cat <<EOF  > $tmp_tex
\documentclass{article}
\usepackage{amsmath}
\begin{document}
${snippet}
\end{document}
EOF

pdflatex $@ -output-directory $tmp_dir $tmp_tex
tmp_pdf=${tmp_tex/.tex/.pdf}
if [ -f $tmp_pdf ]; then
    cp $tmp_pdf $(basename $tmp_pdf)
else
    echo "Failed!"
fi

rm -r $tmp_dir
