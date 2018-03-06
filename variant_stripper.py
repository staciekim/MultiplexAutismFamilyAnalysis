
# Script to strip a variant CSV file to only the columns we need.

# Change this file name to the CSV file downloaded from AWS that
# contains all of the variant information for a particular person
# that we want to condense the file for.
FILE_TO_STRIP = "unaffected_AU016203.csv"

output_file_lines = ""

with open("data/" + FILE_TO_STRIP, "r") as ins:
	for line in ins:
		info = line.split(",")
		output_file_lines += info[0] + "," + info[2] + "," + info[-1] + "\n"

f = open("data/" + FILE_TO_STRIP + ".stripped.csv", "w")
f.write(output_file_lines)
f.close()