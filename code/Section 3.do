/*******************************************************************************
	Section 3 Code
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
	global graph_ready					"some_directory/perhaps_another_directory/maybe_even_one_more_directory/graph_ready.dta" // set path to where you'd like to save an intermediate .dta data file before final analysis
	
	
	/***************************************
	 Load data set up according to spec
	***************************************/

	import delimited "${path_to_data}", clear
	
	
	/***************************************
	 Create label for entry pathway codes
	***************************************/	
	
	//label define entry_pathway_vals 0 "General" 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway" // optional, leave commented out if you prefer numeric pathway codes be used in chart titles; otherwise, uncomment and fill out appropriately
	label dir
	if regexm("`r(names)'", "entry_pathway_vals") { // this code will not run when the code defining entry_pathway_vals remains commented out
		ssc install labutil2 // this quickly installs additional Stata commands used just below
		labellist entry_pathway_vals
		local entry_pathway_vals_labels `r(entry_pathway_vals_labels)'
		local entry_pathway_vals_values `r(entry_pathway_vals_values)'		
	    if `: word count `entry_pathway_vals_values'' == `: word count `entry_pathway_vals_labels'' {
		    gen entry_pathway_label = ""
			label var entry_pathway_label "pathway code label associated with a student at entry"
			order entry_pathway_label, after(pathway)
			forvalues i = 1/`: word count `entry_pathway_vals_values'' {
			    replace entry_pathway_label = `"`: word `i' of `entry_pathway_vals_labels''"' if pathway == `: word `i' of `entry_pathway_vals_values''
			}
			replace entry_pathway_label = subinstr(entry_pathway_label, `"""', "", .)
			assert !missing(entry_pathway_label)
		} 
		else {
		    di in red "The number of entry pathway code values and entry pathway label values does not match."
			exit
		}		
	}
	save "${graph_ready}", replace // if entry_pathway_vals is not uncommented and set above, then this save command just re-saves the intial data, unmodified, as a .dta file
	
	
	/*************************************
	 Chart set up
	*************************************/
	
* Plotly Scatterplot with tooltip hover
python

import plotly.express as px
import numpy as np
import pandas as pd

# Read in prepped data
df = pd.read_stata("${graph_ready}")

# Add column to be passed to color argument
df['color_val'] = "constant"

# Set up list for accummulating scatterplot charts
charts = list()

# Establish dictionary of pathway code labels to be used in chart titles, if entry_pathway_vals label set in Stata above
pathway_label_titles = dict()
if 'entry_pathway_label' in df.columns:
	for c in sorted(list(df.pathway.unique())):
		pathway_label_titles[c] = list(df[df['pathway'] == c].entry_pathway_label.unique())[0]
	df = df.drop('entry_pathway_label', 1) # drop column of labels now that it is no longer needed
		
# Round proportion_failing, prob_completer_pass, prob_completer_fail, prob_completer_diff for better display
df['proportion_failing'] = np.round(df['proportion_failing'], 2)
df['prob_completer_pass'] = np.round(df['prob_completer_pass'], 2)
df['prob_completer_fail'] = np.round(df['prob_completer_fail'], 2)
df['prob_completer_diff'] = np.round(df['prob_completer_diff'], 2)
	
# Set up the charts
for c in sorted(list(df['pathway'].unique())):
	# Subset to data for a single pathway
	df_display = df[df['pathway'] == c]
	# Set min and max for axes
	if np.amin(df_display['prob_completer_diff']) < 0:
		y_min = np.amin(df_display['prob_completer_diff']) - 0.02
	else:
		y_min = 0
	if np.amax(df_display['prob_completer_diff']) < 0.5:
		y_max = 0.5
	else:
		y_max = np.amax(df_display['prob_completer_diff']) + 0.02
	x_min = 0 # cannot have less than 0% of students fail a course
	if np.amax(df_display['proportion_failing']) < 0.6:
		x_max = 0.6
	else:
		x_max = np.amax(df_display['proportion_failing']) + 0.02
	
	# Create scatterplot
	fig = px.scatter(df_display,
					 x = "proportion_failing", 
					 y = "prob_completer_diff",
					 size = "total_attempters",
					 hover_name = "course_label",
					 hover_data = {"total_attempters":True, "prob_completer_pass":True, "prob_completer_fail":True, "prob_completer_diff":False, "proportion_failing":False, "color_val":False},
					 range_x = [x_min, x_max],
					 range_y = [y_min, y_max],
					 labels = {'proportion_failing':'Proportion Students Who Failed Course During First Attempt',
							   'prob_completer_diff':'Difference in Predicted Probability of First Completion',
							   'total_attempters':'Number Students Attempting Course at Least Once',
							   'course_label':'Course Name',
							   'prob_completer_fail':'Probability of First Completion Conditional on Failing',
							   'prob_completer_pass':'Probability of First Completion Conditional on Passing'},
					 color = "color_val",
					 color_discrete_sequence = ["rgb(51,34,136)"])
	if len(pathway_label_titles) > 0:
		pathway_title_display_val = pathway_label_titles[c]
	else:
		pathway_title_display_val = "{:.0f}".format(c)	
	fig.update_layout(title_text = "Difference in the Probability of First Completion for Those Who Pass, Fail Course on First Attempt: {} Pathway".format(pathway_title_display_val),
					  font_size = 15,
					  plot_bgcolor = "rgba(0,0,0,0)",
					  showlegend = False)
	fig.update_xaxes(showline = True,
					 linewidth = 2,
					 linecolor = "gray",
					 showgrid = True,
					 gridwidth = 1,
					 gridcolor = "rgb(192,192,192)")
	fig.update_yaxes(showline = True,
					 linewidth = 2,
					 linecolor = "gray",
					 showgrid = True,
					 gridwidth = 1,
					 gridcolor = "rgb(192,192,192)")
	
	# Highlight y = 0 line for reference if y range extends below 0
	if y_min < 0:
		fig.add_hline(y=0, line_color="black", opacity = 1)

	# Append chart to list
	charts.append(fig)
	
# Render all the charts
for g in charts:
	g.show()
						   
end
	