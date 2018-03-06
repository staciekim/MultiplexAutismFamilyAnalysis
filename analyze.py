
print "Starting analyzing..."

UNAFFECTED_FILES = ["unaffected_AU016203.csv"]
AFFECTED_FILES = ["affected_AU1809303.csv"]

# Mappings from human ID to another mapping of position to variant.
unaffected_variant_info = {}
affected_variant_info = {}

print "Checkpoint 1"

# Populate data structure of unaffected children.
for unaffected_file in UNAFFECTED_FILES:
	unaffected_info = {}
	with open("data/" + unaffected_file, "r") as ins:
		for line in ins:
			pos = line.split(",")[0]
			bp = line.split(",")[2]
			unaffected_info[pos] = bp
	unaffected_variant_info[unaffected_file] = unaffected_info

print "Checkpoint 2"

# Populate data structure of affected children.
for affected_file in AFFECTED_FILES:
	affected_info = {}
	with open("data/" + affected_file, "r") as ins:
		for line in ins:
			pos = line.split(",")[0]
			bp = line.split(",")[2]
			affected_info[pos] = bp
	affected_variant_info[affected_file] = affected_info

print "Checkpoint 3"

# Get varying positions.
varying_positions = set()
for unaffected in unaffected_variant_info:
	for affected in affected_variant_info:
		for pos_unaffected in unaffected:
			if unaffected[pos_unaffected] != affected[pos_affected]:
				varying_positions.add((pos_affected, pos_unaffected))

print "Checkpoint 4"

print "Varing positions: ", varying_positions