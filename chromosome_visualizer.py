
# Script to create visualizaiton of
# high p-value regions per chromosome.

import math
import matplotlib.pyplot as plt

# Colors per chromosome.
colors=['red', 'green', 'blue', 'cyan', 'magenta', 'yellow', 'black', 'red', 'green', 'blue', 'cyan', 'magenta', 'yellow', 'black', 'red', 'green', 'blue', 'cyan', 'magenta', 'yellow', 'black', 'red', 'green', 'blue', 'cyan', 'magenta', 'yellow', 'black']

# Get max position per chromosome.
max_positions = {}
lines = [line.rstrip() for line in open('data/genes_of_interest_analysis_2.csv')][1:]
for line in lines:
	split_line = line.split(",")
	pos = split_line[0].strip("\"")
	chromosome = split_line[1].strip("\"")
	if chromosome not in max_positions:
		max_positions[chromosome] = int(pos)
	else:
		if int(pos) > max_positions[chromosome]:
			max_positions[chromosome] = int(pos)

# Get x-axis offset per chromosome.
x_axis_offset = {}
chr_to_color = {}
curr_pos = 0
count = 0
chromosome_keys = sorted(max_positions.keys())
print 'X axis labels: ', chromosome_keys
for chromosome in chromosome_keys:
	x_axis_offset[chromosome] = curr_pos
	curr_pos += max_positions[chromosome]
	chr_to_color[chromosome] = colors[count]
	count += 1

print 'X axis offsets: ', x_axis_offset

# Positions and colors.
x_positions = []
y_positions = []
final_colors = []

# Go through file again and get positions.
lines = [line.rstrip() for line in open('data/genes_of_interest_analysis_2.csv')][1:]
for line in lines:
	split_line = line.split(",")
	pos = split_line[0].strip("\"")
	chromosome = split_line[1].strip("\"")
	obs = split_line[-1].strip("\"")
	exp = split_line[-2].strip("\"")
	if abs(float(obs) - float(exp)) > 17.5:
		x_positions.append(x_axis_offset[chromosome] + int(pos))
		y_positions.append(math.log(abs(float(obs) - float(exp))))
		final_colors.append(chr_to_color[chromosome])

# Make the plot.
plt.scatter(x_positions, y_positions, color=final_colors)
plt.show()