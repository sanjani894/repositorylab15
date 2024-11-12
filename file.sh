#!/bin/bash

# Check if input file is provided
if [ $# -ne 1 ]; then
  echo "Usage: $0 <data_file>"
  exit 1
fi

# Input file
DATA_FILE=$1
TEX_FILE="table.tex"
PDF_FILE="table.pdf"

# Begin LaTeX document
echo "\documentclass{article}" > $TEX_FILE
echo "\usepackage{booktabs}" >> $TEX_FILE
echo "\begin{document}" >> $TEX_FILE
echo "\begin{table}[h!]" >> $TEX_FILE
echo "\centering" >> $TEX_FILE

# Get headers and data from file
header=$(head -n 1 $DATA_FILE)
columns=$(echo $header | awk '{print NF}')
col_format=$(printf '|c'%.0s $(seq 1 $columns))

# Write table structure
echo "\begin{tabular}{$col_format|}" >> $TEX_FILE
echo "\hline" >> $TEX_FILE

# Add header row
echo $header | awk '{for (i=1; i<=NF; i++) printf "%s ", $i; printf "\\\\ \\hline\n"}' >> $TEX_FILE

# Add data rows
tail -n +2 $DATA_FILE | while read -r line; do
  echo $line | awk '{for (i=1; i<=NF; i++) printf "%s ", $i; printf "\\\\ \\hline\n"}' >> $TEX_FILE
done

# End table and document
echo "\end{tabular}" >> $TEX_FILE
echo "\end{table}" >> $TEX_FILE
echo "\end{document}" >> $TEX_FILE

# Compile LaTeX file to PDF
pdflatex $TEX_FILE

# Clean up intermediate files
rm -f table.aux table.log

# Check if PDF was generated
if [ -f $PDF_FILE ]; then
  echo "PDF generated successfully: $PDF_FILE"
else
  echo "Failed to generate PDF."
fi

