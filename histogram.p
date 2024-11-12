set terminal pngcairo size 800,600
set output 'gender_heart_disease_histogram.png'

set title "Gender vs Number of People with Heart Disease"
set xlabel "Gender (0 = Female, 1 = Male)"
set ylabel "Number of People with Heart Disease"

set boxwidth 0.5
set style fill solid
set xtics ("Female" 0, "Male" 1)

plot 'gender_heart_disease.dat' using 1:2 with boxes title "Heart Disease"
