/*******************************************************************************
	Section 2 Code
*******************************************************************************/

	/*****************************************
	 Comments about this code
	*****************************************/
	
	// Data for this analysis code should be set up according to the accompanying data specification guide.
	
	// Code below for this analyis should be modified according to your needs. In some places, comments explicitly prompt
	// you to appropriately modify a minimum number of commands for your institution's data, or else the output may not be
	// correct or useful. And of course feel free to modify any other commands, too.	
	
	// Stata version 16 or higher is required to run the code below because of the python components. Earliear versions of
	// Stata cannot interact with python. If you do not have access to version 16, you can copy the python code to a separate 
	// python script to run.
	

	/***************************************
	 Set up and setting filepaths
	***************************************/
	
	version 16.1
	clear all
	macro drop all
	
	global path_to_data					"some_directory/perhaps_another_directory/maybe_even_one_more_directory/your_data.csv" // set path to your saved .csv data file matching spec document
	global path_to_save_collapsed_data	"some_directory/perhaps_another_directory/maybe_even_one_more_directory/collapsed_data.dta" // set path for where to save a collapsd data set that will actually be used for graphing

		
	/***************************************
	 Load data set up according to spec
	***************************************/

	import delimited "${path_to_data}", clear
	
	
	/***************************************
	 Create label for entry pathway codes
	***************************************/
	
	//label define entry_pathway_vals 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway" // optional, leave commented out if you prefer numeric pathway codes be used in chart titles; otherwise, uncomment and fill out appropriately
	label dir
	if regexm("`r(names)'", "entry_pathway_vals") { // this code will not run when the code defining entry_pathway_vals remains commented out
		ssc install labutil2 // this quickly installs additional Stata commands used just below
		labellist entry_pathway_vals
		local entry_pathway_vals_labels `r(entry_pathway_vals_labels)'
		local entry_pathway_vals_values `r(entry_pathway_vals_values)'
	}
	
	
	/********************************************
	 Collapse data in prep for graphing
	********************************************/
	
	* Identify the number of terms included for students in each initial pathway; should be equal for all students entering that pathway, even 
	* if multiple entering cohorts are included, though it can differ across initial pathways
	local initial_pathways_num_terms
	levelsof pathway if cohorttermindex == 1, local(initial_pathways)
	foreach p in `initial_pathways' {
		preserve
			bys studentid (cohorttermindex): gen initial_pathway = pathway[1]
			keep if initial_pathway == `p'
			bys studentid: gen record_count = _N
			distinct record_count
			assert r(ndistinct) == 1 // making sure that indeed each student for a specific initial pathway has same number of terms included
			levelsof record_count, local(rec_count)
			drop initial_pathway record_count
		restore
		local initial_pathways_num_terms `initial_pathways_num_terms' `rec_count'
	}
	di "`initial_pathways_num_terms'"
	
	* Collapsing will include, within each value of initial pathway, a separate collapse for each 
	* semester-to-semester transition
	reshape wide pathway, i(studentid) j(cohorttermindex)
	local overall_counter = 1
	local pathway_counter = 1
	foreach p in `initial_pathways' {
		di _newline(3)
		di in red "Pathway: `p'"
		local num_of_collapses = `: word `pathway_counter' of `initial_pathways_num_terms'' - 1
		di in red "Number of collapses: `num_of_collapses'"
		forvalues i = 1/`num_of_collapses' {		
			di in red "Collapse number: `i'"
			preserve
				keep if pathway1 == `p'
				local first = `i' 
				local second = `i' + 1				
				collapse (count) num_students = studentid, by(pathway`first' pathway`second')
				rename (pathway`first' pathway`second') (pathway_origin pathway_target)
				gen semester_transition = `i'
				gen entry_pathway = `p'
				order entry_pathway semester_transition pathway_origin pathway_target num_students
				if `overall_counter' == 1 {
					tempfile collapsed_results
					save `collapsed_results'								
				} 
				else if `overall_counter' > 1 {
					append using `collapsed_results'
					save `collapsed_results', replace
				}
			restore
			local overall_counter = `overall_counter' + 1
		}
		local pathway_counter = `pathway_counter' + 1
	}
	use `collapsed_results', clear
	sort entry_pathway semester_transition
	
	* Label variables
	label var entry_pathway "pathway code associated with a student at entry"
	label var semester_transition "the semester-to-semester transition index (max will be one less than number of semesters included for that initial pathway)"
	label var pathway_origin "pathway code associated with a student for the origin term of a transition"
	label var pathway_target "pathway code associated with a student for the next term of a transition"
	label var num_students "number of students described"
	
	* Generate a variable called entry_pathway_label, if entry_pathway_vals was set above as a label
	if !missing(`"`entry_pathway_vals_values'"') & !missing(`"`entry_pathway_vals_labels'"') {
	    if `: word count `entry_pathway_vals_values'' == `: word count `entry_pathway_vals_labels'' {
		    gen entry_pathway_label = ""
			label var entry_pathway_label "pathway code label associated with a student at entry"
			order entry_pathway_label, after(entry_pathway)
			forvalues i = 1/`: word count `entry_pathway_vals_values'' {
			    replace entry_pathway_label = `"`: word `i' of `entry_pathway_vals_labels''"' if entry_pathway == `: word `i' of `entry_pathway_vals_values''
			}
			replace entry_pathway_label = subinstr(entry_pathway_label, `"""', "", .)
			assert !missing(entry_pathway_label)
		} 
		else {
		    di in red "The number of entry pathway code values and entry pathway label values does not match."
			exit
		}
	}
	
	* Save out collapsed data
	save "${path_to_save_collapsed_data}", replace 
	
	
/**************************************************
 Run Sankey diagrams
**************************************************/

python:

import plotly.graph_objects as go
import pandas as pd

# Read in preppped data
df_full = pd.read_stata("${path_to_save_collapsed_data}")
df_full.head()

# Establish list to contain Sankey charts
charts = []

# Establish dictionary of pathway code labels to be used in chart titles, if entry_pathway_vals label set in Stata above
pathway_label_titles = dict()
if 'entry_pathway_label' in df_full.columns:
	for e in sorted(list(df_full.entry_pathway.unique())):
		pathway_label_titles[e] = list(df_full[df_full['entry_pathway'] == e].entry_pathway_label.unique())[0]
	df_full = df_full.drop('entry_pathway_label', 1) # drop column of labels now that is no longer needed; want numeric indexing statements below to be the same whether entry_pathway_vals defined or not
		
# Loop over entry pathway codes and create a Sankey chart for each, across all available transition periods
for e in sorted(list(df_full.entry_pathway.unique())):
	print('Creating Sankey chart for entry pathway: {}'.format(e))

	# Subset to just the students entering that pathway
	df = df_full[df_full['entry_pathway'] == e] 

	# Set up dictionary that will be used to do indexing of source and target nodes
	d = dict()
	counter = 1
	transitions = sorted(list(df.semester_transition.unique()))
	last_trans = max(transitions)
	for s in transitions: 
		print('Transition: {}'.format(s))
		# Subset to just the records for the transition period s
		trans_s_df = df[df['semester_transition'] == s]
		# Only need the first pathway codes for non-last transitions; the first pathway codes of the next transition are the second pathway codes of the transition before
		if s < last_trans:
			print(counter)
			d[counter] = list(trans_s_df.pathway_origin.unique())
			counter = counter + 1
		# For the last transition, we do need to add both the first and last pathway codes
		else:
			print(counter)
			d[counter] = list(trans_s_df.pathway_origin.unique())
			counter = counter + 1
			print(counter)
			d[counter] = list(trans_s_df.pathway_target.unique())
			counter = counter + 1			

	# Repackage the contents of the dictionary as tuples that include required indexing bump
	list_lengths = [len(d[x]) for x in d]
	index_bumps = [] # pathway codes will (and must) appear multiple times in lables_list; have to make sure you index the right one
	for k in d:
		print('Getting index bump for transition {}'.format(k))
		if k == 1:
			index_bumps.append(0)
		elif k == 2:
			index_bumps.append(list_lengths[0])
		elif k > 2:
			index_bumps.append(sum(list_lengths[0:(k-1)])) 
	final_d = dict()	
	for k in d:
		print('Setting up final tuple for transition {}'.format(k))
		final_d[k] = (d[k], index_bumps[k-1])
	print(final_d)

	# Next step is to go line by line through data frame, calculating for each row: source node index, target node index, value, accummulating these
	# in three separate lists (the list of node labels will just be all the dictionary pathway list values appended together, in order)
	labels_list = list()
	source_list = list()
	target_list = list()
	value_list = list()
	for s in transitions:
		print('Getting info for transition {}'.format(s))
		# Subset to just the records for the transition period s
		trans_s_df = df[df['semester_transition'] == s]
		# Now iterate through all rows for that transition
		for r in range(trans_s_df.shape[0]):
			print('Getting info for row {}'.format(r))
			# Get the indices of the first and second pathway codes for each transition, using info stored in final_d, including index bump
			source_node = final_d[s][0].index(trans_s_df.iat[r, 2]) + final_d[s][1] # first pathway code
			target_node = final_d[s+1][0].index(trans_s_df.iat[r, 3]) + final_d[s+1][1] # second pathway code
			# Append values to relevant lists
			source_list.append(source_node)
			target_list.append(target_node)
			value_list.append(trans_s_df.iat[r, 4])
		if s < last_trans:
			labels_list.extend(final_d[s][0])
		else:
			labels_list.extend(final_d[s][0])
			labels_list.extend(final_d[s+1][0])
		
	# Convert labels_list to string elements with 'Unenrolled' replacing 99, 'Completer' for 100,
	# 'Transfer' for 101
	labels_list_str = [str(x) for x in labels_list]
	labels_list_99 = ['Unenrolled' if x == '99' else x for x in labels_list_str]
	labels_list_100 = ['Completer' if x == '100' else x for x in labels_list_99]
	labels_list_final = ['Transfer' if x == '101' else x for x in labels_list_100]
	
	# Review all newly created lists
	print(final_d)
	print(labels_list_final)
	print(source_list)		
	print(target_list)
	print(value_list)
	
	# Create the Sankey chart
	fig = go.Figure(data=[go.Sankey(
		node = dict(
			pad = 15,
			thickness = 20,
			line = dict(color = "black", width = 0.5),
			label = labels_list_final,
			color = "rgb(51,34,136)"
		),
		link = dict(
			source = source_list,
			target = target_list,
			value = value_list
		))])
	if len(pathway_label_titles) > 0:
		pathway_title_display_val = pathway_label_titles[e]
	else:
		pathway_title_display_val = "{:.0f}".format(e)
	fig.update_layout(title_text = "Semester by Semester Movement Across Pathways for Students Who Entered {} Pathway in First Term".format(pathway_title_display_val), font_size = 15)

	# Append Sankey to list of charts
	charts.append(fig)

# Render all the Sankey charts
for g in charts:
	g.show()
		
end