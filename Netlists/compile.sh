#!/bin/bash 
mkdir -p syn

if [ $1 == "1" ]; then
	design_vision -no_gui -f k_nns_seq.dcsh
fi
if [ $2 == "1" ]; then
	design_vision -no_gui -f first_nns_seq.dcsh
fi 
if [ $3 == "1" ]; then
	design_vision -no_gui -f first_nns_comb.dcsh
fi 

rm *.pvl *.syn *.mr *.log *.svf
