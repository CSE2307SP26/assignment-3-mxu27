#!/bin/bash

#making variables, one for expected output and one for student output
expected_output="$1"
student_output="$2"

#while loop to read in names via redirection
while read LINE
do
	git clone "https://github.com/CSE2307SP26/$LINE.git"
	cd "$LINE"
	git checkout cipher
	git checkout `git rev-list -n 1 --first-parent --before="2026-2-12 10:00" cipher`
	javac Cipher.java
	java Cipher > "$student_output" 
	
	stud_output=$(cat "$student_output")
	expe_output=$(cat "$expected_output")	
	
	if [[ "$stud_output" == "$expe_output" ]]
	then
		echo "$LINE 1"
	else
		echo "$LINE 0"
	fi
	git checkout main
	cd ..
	rm -rf "$LINE"	
done
