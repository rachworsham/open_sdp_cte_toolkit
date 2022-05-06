// Change the path in the next line to your top-level working directory
cd ""

// Change the path below to the directory where you will store programs
global programs "./code"

// Change the path below to the directory where you will store chart output
global figures "./img"

// Change the path below to the directory where you will store mark-up guides
global docs "./docs"

// Change the path below to the directory where you will store data
*global data "./data"

// Set up
clear all
set more off
set linesize 255
graph set window fontface "Open Sans"




// Modify here, bug causes nav to spill behind body on ultra large resolutions






//Comments about this code

// Data for this analysis code should be set up according to the accompanying data specification guide.

// Code below for this analyis should be modified according to your needs. In some places, comments explicitly prompt you to appropriately modify a minimum number of commands for your institution's data, or else the output may not be correct or useful. And of course feel free to modify any other commands, too.

// Stata version 16 or higher is required to run the code below, especially the frames-related commands. Earlier versions of Stata can be used if these commands are removed and replaced with similar functionality like tempfiles.

// The code below varies considerably in complexity depending on which graph is being created. Stata's marginsplot command does not make it easy to create stacked bar graphs, which require  more explicit, longer commands.

// If you do not already have the user-written Stata command svmat2 installed, please see Stata's website for more guidance on how to install this. The appropriate installation approach might depend on the environment in which you are using Stata.

// If you do not alraedy have the user-written Stata command grc1leg2 installed, please type "search grc1leg2" in the Stata  console for more installation information.

// Note that this code does not create margins plots for all pairwise combinations of covariates in the model. Specifically, no plots are created for combinations of two continuous variables. Nor are redundant combinations included (e.g. a margins plot for race/ethnicity and gender is included once in the race/ethnicity graphing section, which appears before the gender graphing section) 

// Step 1. Set up and setting filepaths //

	version 16.1
	clear all
	macro drop all		

// set path to your saved .csv data file matching spec document
	
	global path_to_data "some_directory/perhaps_another_directory/maybe_even_one_more_directory/your_data.csv" 
	
// set path for where you'd like graphs saved on your computer
	
	global saved_graph "some_directory/perhaps_another_directory/finally_the_directory_where_you_would_like_your_graphs_saved" 

// Step 2. Load data set up according to spec //
	
	import delimited "${path_to_data}"

// Label variables as relevant to institution- set these value labels according to your preferred conventions

// male

	label define male_vals 0 "Female" 1 "Male" 
	label values male male_vals

// race

	label define race_vals 1 "Asian" 2 "Black" 3 "Hispanic" 4 "White" 5 "Other"	
	label values race race_vals

// motheredlevel

	label define edlevel_vals 1 "Middle Sch" 2 "High Sch" 3 "Any College" 4 "NA"
	label values motheredlevel edlevel_vals

// pathway
	
	label define pathway_entry_vals 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway" 

	label values pathway pathway_entry_vals//this is just a placeholder example; please modify with the full names associated with each entry pathway code at your institution

// Step 3. Generate additional variables //

// Determine number of terms included in data for each student

	sum cohorttermindex
	global max_term = r(max)		

// Outcome variable at the student level, across terms
	gen outcome = 0
	replace outcome = 1 if pathway == 100 & cohorttermindex == $max_term
	replace outcome = 2 if pathway == 101 & cohorttermindex == $max_term
	bys studentid (cohorttermindex): replace outcome = outcome[$max_term]

// Label outcome

	label define outcome_vals 0 "None" 1 "Completion" 2 "Transfer"
	label values outcome outcome_vals
	label var outcome "student outcome after ${max_term} terms"

// Code in an indicator for a terminating event (first completion or first transfer)

	gen terminating = inlist(pathway, 100, 101)	
	label var terminating "indicator for a terminating event: first completion or transfer"
	
// Generate an indicator for non-enrollment

	gen nonenrolled = pathway == 99
	label var nonenrolled "indicator for non-enrollment in a term"	
	
// Generate an entry pathway code for each student

	bys studentid (cohorttermindex): gen entry_pathway = pathway[1]
	label var entry_pathway "pathway code associated with a student at entry"	
	
// Label entry pathways
	
	label values entry_pathway pathway_entry_vals
	
// Step 4. Run regressions and plot margins //

// Model: outcomes conditional only on initial pathway choice
	
	mlogit outcome i.pathway if cohorttermindex == 1, robust//note that because each student will have multiple rows in the data but with covariate values fixed at values observed at entry, we only need to run the regression with the first entry for each student
		
// Chart: pathway unadjusted margins

	{
	margins pathway, predict(outcome(1)) predict(outcome(2))
	matrix ans = (r(b))'
	cap frame drop working
	frame create working
	frame change working
	svmat2 ans, rnames(estimate_name)
	order estimate_name ans1
	rename ans1 prediction_
	gen outcome_level = ustrregexs(1) if ustrregexm(estimate_name, "^([0-9])")
	destring outcome_level, replace
	gen pathway_level = ustrregexs(1) if ustrregexm(estimate_name, "t.([0-9]+)")
	destring pathway_level, replace
	drop estimate_name
	order outcome_level pathway_level	
	reshape wide prediction_, i(pathway_level) j(outcome_level)//please modify appropriately; unfortunately, value labels do not copy automatically into new frames
	label define pathway_vals 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway" 
	label values pathway_level pathway_vals
		graph bar (asis) prediction_1 prediction_2,title("Probability of Completion First or Transferring First" "by Pathway") ytitle("Probability") b1("Pathway") over(pathway_level) stack ylabel(0(0.2)1) graphregion(fcolor(white)) legend(label(1 "Completion First") label(2 "Transfer First")) xsize(5.5) note("Note: Probabilities for each outcome are stacked.", size(vsmall)) bar(1, fcolor("51 34 136") lcolor(black)) bar(2, fcolor("68 170 153") lcolor(black))//colors chosen for colorblindness accessibility
		graph export "${saved_graphs}/1_main.png", replace
	frame change default
	frame drop working		
	}





// Create adjusted outcome model & chart

// Model: outcomes conditional on baseline student traits //

//note mi_motheredlevel omitted because missingness is already encoded as level 4 of motheredlevel so it's excluded from the full model
	
	mlogit outcome c.age c.age#i.pathway c.hsgpa i.mi_hsgpa c.hsgpa#i.pathway i.male i.male#i.pathway c.pell i.mi_pell c.pell#i.pathway i.motheredlevel i.motheredlevel#i.pathway i.race i.race#i.pathway i.pathway i.institutionid i.cohortyear if cohorttermindex == 1, robust

//note that because each student will have multiple rows in the data but with covariate values fixed at values observed at entry, we only need to run the regression with the first entry for each student
	
// Chart: pathway adjusted margins //

	{
	margins pathway, predict(outcome(1)) predict(outcome(2))
	matrix ans = (r(b))'	
	cap frame drop working
	frame create working
	frame change working
	svmat2 ans, rnames(estimate_name)
	order estimate_name ans1
	rename ans1 prediction_
	gen outcome_level = ustrregexs(1) if ustrregexm(estimate_name, "^([0-9])")
	destring outcome_level, replace
	gen pathway_level = ustrregexs(1) if ustrregexm(estimate_name, "t.([0-9]+)")
	destring pathway_level, replace
	label define pathway_vals 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway"//please modify appropriately; unfortunately, value labels do not copy automatically into new frames
	label values pathway_level pathway_vals
	drop estimate_name
	order outcome_level pathway_level	
	reshape wide prediction_, i(pathway_level) j(outcome_level) 	
		graph bar (asis) prediction_1 prediction_2, title("Adjusted Probability of Completion First" "or Transferring First by 	Pathway") ytitle("Adjusted Probability") b1("Pathway") over(pathway_level) stack ylabel(0(0.2)1) graphregion(fcolor(white))legend(label(1 "Completion First") label(2 "Transfer First")) xsize(5.5) note ("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort. Adjusted" "probabilities for each outcome are stacked.", size(vsmall)) bar(1, fcolor("51 34 136") lcolor(black)) bar(2, fcolor("68 170 153") lcolor(black)) 
		graph export "${saved_graphs}/2_main_adjusted.png", replace
	frame change default
	frame drop working	
	}
	




// Create trends over time chart
	
// Chart: waterfall view of completion/transfer, unenrollment, and continued enrollment over time
	
	{
	cap frame drop working
	frame create working double(pathway term denominator terminated nonenrolled stillenrolled)
	foreach p in $pathways {
	    di _newline(2)
		distinct studentid if entry_pathway == `p'
		local denominator = r(ndistinct)
		forvalues i = 1/$max_term {
			preserve
				keep if entry_pathway == `p' & cohorttermindex <= `i'
				bys studentid: egen any_terminating = max(terminating)
				keep studentid entry_pathway pathway any_terminating cohorttermindex
				keep if cohorttermindex == `i'
				isid studentid
				count if any_terminating == 1
				local terminated = r(N)
				count if pathway == 99
				local nonenrolled = r(N)
				count if pathway != 99 & any_terminating == 0
				local stillenrolled = r(N)
			restore 
			frame post working (`p') (`i') (`denominator') (`terminated') (`nonenrolled')	(`stillenrolled')
		}	
	}
	frame change working
	foreach s in terminated nonenrolled stillenrolled {
		gen pct_`s' = `s'/denominator
	}	
	label define pathway_vals 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway"//please modify appropriately; unfortunately, value labels do not copy automatically into new frames
	label values pathway pathway_vals		
	gen pct_nonenrolled_neg = -1*pct_nonenrolled//useful for getting this portion of cohort to hang below the x axis
	graph bar (asis) pct_stillenrolled pct_terminated pct_nonenrolled_neg, over(term) yline(0, lcolor(gray)) bar(1, fcolor(navy)) bar(2, fcolor(green)) bar(3, fcolor(cranberry)) stack by(pathway, title("First Completion/Transfer Rates by Pathway") b1title("Cohort Term") graphregion(fcolor(white)) legend(position(3)) note("Note: Each stacked bar represents an entire cohort each term.", size(vsmall))) legend(cols(1) label(1 "Still Enrolled") label(2 "Completer/" "Transfer") label(3 "No Longer" "Enrolled") size(small) symxsize(small) textwidth(18)) ytitle("Proportion of Cohort") ylabel(-0.5 "0.5" 0 "0" 0.5 "0.5" 1 "1") bar(1, fcolor("51 34 136") lcolor(black)) bar(2, fcolor("68 170 153") lcolor(black)) bar(3, fcolor("136 34 85") lcolor(black))
	graph export "${saved_graphs}/3_student_status_over_time.png", replace
	frame change default
	frame drop working		
	}	





// Create margins plots

// Charts: high school GPA margins

// Main high school GPA margins
	
	{	
	margins pathway, at(hsgpa = (2(0.25)4)) predict(outcome(1)) predict(outcome(2))				
		marginsplot, bydimension(pathway) byopts(title("Adjusted Probability of Completion First or Transfer First" "by High School GPA") graphregion(fcolor(white)) imargin(medium) note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall))) ytitle("Adjusted Probability") xtitle("High School GPA") ylabel(0(0.2)1) noci legend(order(1 "Completion First" 2 "Transfer First")) plotregion(margin(zero)) yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136"), plot2opts(mcolor("68 170 153") lcolor("68 170 153"))	
		graph export "${saved_graphs}/4_gpa_1.png", replace
	
// High school GPA margins by gender
	
	margins pathway, at(male = (0(1)1) hsgpa = (2(0.25)4)) predict(outcome(1))	
		marginsplot, bydimension(pathway) plotdimension(male) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) ytitle("First Completion") xtitle("") ylabel(0(0.2)1) xlabel(2(0.5)4) plotregion(margin(zero)) yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153")) name(g4_a, replace)	
	margins pathway, at(male = (0(1)1) hsgpa = (2(0.25)4)) predict(outcome(2))
		marginsplot, bydimension(pathway) plotdimension(male) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) ytitle("First Transfer") xtitle("") ylabel(0(0.2)1) xlabel(2(0.5)4) plotregion(margin(zero)) yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153")) name(g4_b, replace)
		grc1leg2 g4_a g4_b, title("Adjusted Probability of First Completion/Transfer" "by Gender and High School GPA") rows(2) graphregion(fcolor(white)) b1title("High School GPA") l1title("Adjusted Probability") position(3) lrows(2) symxsize(small) labsize(small) xsize(7) note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall))
		graph export "${saved_graphs}/4_gpa_2.png", replace
	
// High school GPA margins by mother level of education
	
	margins pathway, at(motheredlevel = (1(1)3) hsgpa = (2(0.25)4)) predict(outcome(1))	
		marginsplot, bydimension(pathway) plotdimension(motheredlevel) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) legend(order(1 "Middle Sch" 2 "High Sch" 3 "Any College")) ytitle("First Completion") xtitle("") ylabel(0(0.2)1) xlabel(2(0.5)4) plotregion(margin(zero)) yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153")) plot3opts(mcolor("136 34 85") lcolor("136 34 85")) name(g4_a, replace)
	margins pathway, at(motheredlevel = (1(1)3) hsgpa = (2(0.25)4)) predict(outcome(2))
		marginsplot, bydimension(pathway) plotdimension(motheredlevel) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) ytitle("First Transfer") xtitle("") ylabel(0(0.2)1) xlabel(2(0.5)4) plotregion(margin(zero)) yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153")) plot3opts(mcolor("136 34 85") lcolor("136 34 85")) name(g4_b, replace)
		grc1leg2 g4_a g4_b, title("Adjusted Probability of First Completion/Transfer" "by Mother's Education Level and High School GPA") rows(2) graphregion(fcolor(white)) b1title("High School GPA") l1title("Adjusted Probability") position(3) lrows(3) symxsize(small) labsize(small) xsize(7) note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall))
		graph export "${saved_graphs}/4_gpa_3.png", replace
	
// High school GPA margins by race/ethnicity
	
	margins pathway, at(race = (1(1)5) hsgpa = (2(0.25)4)) predict(outcome(1))
		marginsplot, bydimension(pathway) plotdimension(race) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) yline(0, lcolor(black)) ytitle("First Completion") xtitle("") ylabel(0(0.2)1) xlabel(2(0.5)4) plotregion(margin(zero)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153")) plot3opts(mcolor("136 34 85") lcolor("136 34 85")) plot4opts(mcolor("136 204 238") lcolor("136 204 238")) plot5opts(mcolor("204 102 119") lcolor("204 102 119")) name(g4_a, replace)
	margins pathway, at(race = (1(1)5) hsgpa = (2(0.25)4)) predict(outcome(2))
		marginsplot, bydimension(pathway) plotdimension(race) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) yline(0, lcolor(black)) ytitle("First Transfer") xtitle("") ylabel(0(0.2)1) xlabel(2(0.5)4) plotregion(margin(zero)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153")) plot3opts(mcolor("136 34 85") lcolor("136 34 85")) plot4opts(mcolor("136 204 238") lcolor("136 204 238")) plot5opts(mcolor("204 102 119") lcolor("204 102 119")) name(g4_b, replace)		
		grc1leg2 g4_a g4_b, title("Adjusted Probability of First Completion/Transfer" "by Race/Ethnicity and High School GPA") rows(2) graphregion(fcolor(white)) b1title("High School GPA") l1title("Adjusted Probability") position(3) lrows(5) symxsize(small) labsize(small) xsize(7) note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall))
		graph export "${saved_graphs}/4_gpa_4.png", replace
		
	}
	
// Charts: Pell grant margins

// Main Pell grant margins 
	
	{
	margins pathway, at(pell = (0(1000)6000)) predict(outcome(1)) predict(outcome(2))
		marginsplot, bydimension(pathway) byopts(title("Adjusted Probability of Completion First or Transfer First" "by Pell Grant Dollars") graphregion(fcolor(white)) imargin(medium) note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall))) ytitle("Adjusted Probability") xtitle("Pell Dollars Awarded in First Year") ylabel(0(0.2)1) xlabel(0(1500)6000) noci legend(order(1 "Completion First" 2 "Transfer First")) plotregion(margin(zero)) yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153"))
		graph export "${saved_graphs}/5_pell_1.png", replace
	
// Pell grant margins by gender
	
	margins pathway, at(male = (0 1) pell = (0(1000)6000)) predict(outcome(1))
		marginsplot, bydimension(pathway) plotdimension(male) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) ytitle("First Completion") xtitle("") ylabel(0(0.2)1) xlabel(0(1500)6000) plotregion(margin(zero)) yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153")) name(g5_a, replace)
	margins pathway, at(male = (0 1) pell = (0(1000)6000)) predict(outcome(2))
		marginsplot, bydimension(pathway) plotdimension(male) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) ytitle("First Transfer") xtitle("") ylabel(0(0.2)1) xlabel(0(1500)6000) plotregion(margin(zero)) yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153")  lcolor("68 170 153")) name(g5_b, replace) 		grc1leg2 g5_a g5_b, title("Adjusted Probability of First Completion/Transfer" "by Gender and Pell Grant Dollars") rows(2) graphregion(fcolor(white)) b1title("Pell Dollars Awarded in First Year") l1title("Adjusted Probability") position(3) lrows(2) symxsize(small) labsize(small) xsize(7) note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall))	
		graph export "${saved_graphs}/5_pell_2.png", replace
		
// Pell grant margins by mother level of education
	
	margins pathway, at(motheredlevel = (1(1)3) pell = (0(1000)6000)) predict(outcome(1))
		marginsplot, bydimension(pathway) plotdimension(motheredlevel) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) legend(order(1 "Middle Sch" 2 "High Sch" 3 "Any College")) ytitle("First Completion") xtitle("") ylabel(0(0.2)1) xlabel(0(1500)6000) plotregion(margin(zero)) yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153")) plot3opts(mcolor("136 34 85") lcolor("136 34 85")) name(g5_a, replace)	
	margins pathway, at(motheredlevel = (1(1)3) pell = (0(1000)6000)) predict(outcome(2))
		marginsplot, bydimension(pathway) plotdimension(motheredlevel) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) ytitle("First Transfer") xtitle("") ylabel(0(0.2)1) xlabel(0(1500)6000) plotregion(margin(zero)) yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153")) plot3opts(mcolor("136 34 85") lcolor("136 34 85")) name(g5_b, replace)
		grc1leg2 g5_a g5_b, title("Adjusted Probability of First Completion/Transfer" "by Mother's Education Level and Pell Grant Dollars") rows(2) graphregion(fcolor(white)) b1title("Pell Dollars Awarded in First Year") l1title("Adjusted Probability") position(3) lrows(3) symxsize(small) labsize(small) xsize(7) note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall))	
		graph export "${saved_graphs}/5_pell_3.png", replace
	
// Pell grant margins by race/ethnicity
	
	margins pathway, at(race = (1(1)5) pell = (0(1000)6000)) predict(outcome(1))
		marginsplot, bydimension(pathway) plotdimension(race) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) yline(0, lcolor(black)) ytitle("First Completion") xtitle("") ylabel(0(0.2)1) xlabel(0(1500)6000) plotregion(margin(zero)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153")) plot3opts(mcolor("136 34 85") lcolor("136 34 85")) plot4opts(mcolor("136 204 238") lcolor("136 204 238")) plot5opts(mcolor("204 102 119") lcolor("204 102 119")) name(g5_a, replace)		
	margins pathway, at(race = (1(1)5) pell = (0(1000)6000)) predict(outcome(2))
		marginsplot, bydimension(pathway) plotdimension(race) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) yline(0, lcolor(black)) ytitle("First Transfer") xtitle("") ylabel(0(0.2)1) xlabel(0(1500)6000) plotregion(margin(zero)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153")) plot3opts(mcolor("136 34 85") lcolor("136 34 85")) plot4opts(mcolor("136 204 238") lcolor("136 204 238")) plot5opts(mcolor("204 102 119") lcolor("204 102 119")) name(g5_b, replace)
		grc1leg2 g5_a g5_b, title("Adjusted Probability of First Completion/Transfer" "by Race/Ethnicity and Pell Grant Dollars") rows(2) graphregion(fcolor(white)) b1title("Pell Dollars Awarded in First Year") l1title("Adjusted Probability") position(3) lrows(5) symxsize(small) labsize(small) xsize(7) note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall))	
		graph export "${saved_graphs}/5_pell_4.png", replace
	
	}	
		
// Charts: age at entry margins

// Main age at entry margins
	
	{
	margins pathway, at(age = (18(3)36)) predict(outcome(1)) predict(outcome(2))	
		marginsplot, bydimension(pathway) byopts(title("Adjusted Probability of Completion First or Transfer First" "by Student Age at Entry") graphregion(fcolor(white)) imargin(medium) note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall))) ytitle("Adjusted Probability") xtitle("Student Age at Entry") ylabel(0(0.2)1) xlabel(18(3)36) noci legend(order(1 "Completion First" 2 "Transfer First")) plotregion(margin(zero)) yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153"))
		graph export "${saved_graphs}/6_age_1.png", replace	

// Age at entry margins by gender
	
	margins pathway, at(male = (0 1) age = (18(3)36)) predict(outcome(1))
		marginsplot, bydimension(pathway) plotdimension(male) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) ytitle("First Completion") xtitle("") ylabel(0(0.2)1) xlabel(18(6)36) plotregion(margin(zero)) yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153")  lcolor("68 170 153")) name(g6_a, replace)	
	margins pathway, at(male = (0 1) age = (18(3)36)) predict(outcome(2))
		marginsplot, bydimension(pathway) plotdimension(male) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) ytitle("First Transfer") xtitle("")  ylabel(0(0.2)1) xlabel(18(6)36) plotregion(margin(zero)) yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153")  lcolor("68 170 153")) name(g6_b, replace) 
		grc1leg2 g6_a g6_b, title("Adjusted Probability of First Completion/Transfer" "by Gender and Age at Entry") rows(2) graphregion(fcolor(white)) b1title("Age at Entry") l1title("Adjusted Probability") position(3) lrows(2) symxsize(small) labsize(small) xsize(7) note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall))	
		graph export "${saved_graphs}/6_age_2.png", replace
	
// Age at entry margins by mother level of education
	
	margins pathway, at(motheredlevel = (1(1)3) age = (18(3)36)) predict(outcome(1))
		marginsplot, bydimension(pathway) plotdimension(motheredlevel) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) legend(order(1 "Middle Sch" 2 "High Sch" 3 "Any College")) ytitle("First Completion") xtitle("") ylabel(0(0.2)1) xlabel(18(6)36) plotregion(margin(zero)) yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153")) plot3opts(mcolor("136 34 85") lcolor("136 34 85")) name(g6_a, replace)	
	margins pathway, at(motheredlevel = (1(1)3) age = (18(3)36)) predict(outcome(2))
		marginsplot, bydimension(pathway) plotdimension(motheredlevel) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) ytitle("First Transfer") xtitle("") ylabel(0(0.2)1) xlabel(18(6)36) plotregion(margin(zero)) yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153")) plot3opts(mcolor("136 34 85") lcolor("136 34 85")) name(g6_b, replace) 	
		grc1leg2 g6_a g6_b, title("Adjusted Probability of First Completion/Transfer" "by Mother's Education Level and Age at Entry") rows(2) graphregion(fcolor(white))  b1title("Age at Entry") l1title("Adjusted Probability") position(3) lrows(3) symxsize(small) labsize(small) xsize(7) note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall))	
		graph export "${saved_graphs}/6_age_3.png", replace
	
// Age at entry margins by race/ethnicity
	
	margins pathway, at(race = (1(1)5) age = (18(3)36)) predict(outcome(1))
		marginsplot, bydimension(pathway) plotdimension(race) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) yline(0, lcolor(black)) ytitle("First Completion") xtitle("") ylabel(0(0.2)1) xlabel(18(6)36) plotregion(margin(zero)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153")) plot3opts(mcolor("136 34 85") lcolor("136 34 85")) plot4opts(mcolor("136 204 238") lcolor("136 204 238")) plot5opts(mcolor("204 102 119") lcolor("204 102 119")) name(g6_a, replace)	
	margins pathway, at(race = (1(1)5) age = (18(3)36)) predict(outcome(2))
		marginsplot, bydimension(pathway) plotdimension(race) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) yline(0, lcolor(black)) ytitle("First Transfer") xtitle("") ylabel(0(0.2)1) xlabel(18(6)36) plotregion(margin(zero)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153"))  plot3opts(mcolor("136 34 85") lcolor("136 34 85")) plot4opts(mcolor("136 204 238") lcolor("136 204 238")) plot5opts(mcolor("204 102 119") lcolor("204 102 119")) name(g6_b, replace)	
		grc1leg2 g6_a g6_b, title("Adjusted Probability of First Completion/Transfer" "by Race/Ethnicity and Age at Entry") rows(2) graphregion(fcolor(white)) b1title("Age at Entry") l1title("Adjusted Probability") position(3) lrows(5) symxsize(small) labsize(small) xsize(7) note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall))	
		graph export "${saved_graphs}/6_age_4.png", replace
		
	}
	
	
// Charts: race/ethnicity margins

// Main race/ethnicity margins

	{
	margins pathway, at(race = (1(1)5)) predict(outcome(1)) predict(outcome(2))
	matrix ans = (r(b))'
	cap frame drop working
	frame create working
	frame change working
	svmat2 ans, rnames(estimate_name)
	order estimate_name ans1
	rename ans1 prediction_
	gen outcome_level = ustrregexs(1) if ustrregexm(estimate_name, "^([0-9])")
	destring outcome_level, replace
	gen race_level = ustrregexs(1) if ustrregexm(estimate_name, "predict#([0-9])")
	destring race_level, replace
	label define race_vals 1 "Asian" 2 "Black" 3 "Hispanic" 4 "White" 5 "Other"//unfortunately these value labels must be re-copied from above; value labels created in one frame are not accessible in another
	label values race_level race_vals
	gen pathway_level = ustrregexs(1) if ustrregexm(estimate_name, "_at#([0-9]+)")
	destring pathway_level, replace
	label define pathway_vals 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway"//please modify appropriately; unfortunately, value labels do not copy automatically into new frames	
	label values pathway_level pathway_vals
	drop estimate_name
	order race_level pathway_level outcome_level	
	reshape wide prediction_, i(race_level pathway_level) j(outcome_level)
		graph bar (asis) prediction_1 prediction_2, by(pathway_level, title("Adjusted Probability of First Completion/Transfer" "by Race/Ethnicity") b1title("Race/Ethnicity", size(medium)) imargin(medium) note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort. Adjusted probabilities" "for each outcome are stacked.", size(vsmall)) graphregion(fcolor(white)) legend(position(3))) ytitle("Adjusted Probability") over(race_level, label(angle(45))) stack ylabel(0(0.2)1) legend(order(1 "Completion First" 2 "Transfer First") rows(2) symxsize(2) size(small) width(35)) bar(1, fcolor("51 34 136") lcolor(black)) bar(2, fcolor("68 170 153") lcolor(black))		
		graph export "${saved_graphs}/7_race_1.png", replace		
	frame change default
	frame drop working
	
// Race/ethnicity margins by gender	
	
	margins pathway, at(race = (1(1)5) male = (0 1)) predict(outcome(1))	
		marginsplot, graphdimension(pathway) bydimension(male) xdimension(race) noci byopts(title("") l1title("") b1title("") graphregion(fcolor(white)) imargin(vsmall)) recast(bar) plotopts(ylabel(0(0.2)1) xlabel(,angle(45)) plotregion(margin(zero))) plotdimension(race) plot1opts(fcolor("51 34 136") lcolor("51 34 136")) plot2opts(fcolor("68 170 153") lcolor("68 170 153")) plot3opts(fcolor("136 34 85") lcolor("136 34 85")) plot4opts(fcolor("136 204 238") lcolor("136 204 238")) plot5opts(fcolor("204 102 119") lcolor("204 102 119")) name(g7_a, replace)
	margins pathway, at(race = (1(1)5) male = (0 1)) predict(outcome(2))
		marginsplot, graphdimension(pathway) bydimension(male) xdimension(race) noci byopts(title("") l1title("") b1title("") graphregion(fcolor(white)) imargin(vsmall)) recast(bar) plotopts(ylabel(0(0.2)1) xlabel(,angle(45)) plotregion(margin(zero))) plotdimension(race) plot1opts(fcolor("51 34 136") lcolor("51 34 136")) plot2opts(fcolor("68 170 153") lcolor("68 170 153")) plot3opts(fcolor("136 34 85") lcolor("136 34 85")) plot4opts(fcolor("136 204 238") lcolor("136 204 238")) plot5opts(fcolor("204 102 119") lcolor("204 102 119")) name(g7_b, replace)
	levelsof entry_pathway, local(pathways)
	local named_graphs
	forvalues i = 1/`: word count `pathways'' {
		local named_graphs `named_graphs' g7_a`i'
		}
	forvalues i = 1/`: word count `pathways'' {
		local named_graphs `named_graphs' g7_b`i'
		}	
		grc1leg2 `named_graphs', title("Adjusted Probability of First Completion/Transfer" "by Gender and Race/Ethnicity") l2title("Adjusted Probability") l1title("First Transfer First Completion", size(small)) graphregion(fcolor(white)) rows(2) lrows(5) position(3) symxsize(small) labsize(small) xsize(7) note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall))//the l1title() approach used here is admittedly a little informal, but it is a useful approach given how we needed to set up this graph
		graph export "${saved_graphs}/7_race_2.png", replace
	
// Race/ethnicity margins by mother level of education
	
	margins pathway, at(race = (1(1)5) motheredlevel = (1(1)3)) predict(outcome(1))
		marginsplot, graphdimension(pathway) bydimension(motheredlevel) xdimension(race) noci recast(bar) byopts(title("") l1title("") b1title("") rows(1) graphregion(fcolor(white)) imargin(small)) plotopts(ylabel(0(0.2)1) xlabel(,angle(45)) plotregion(margin(zero))) plotdimension(race) plot1opts(fcolor("51 34 136") lcolor("51 34 136")) plot2opts(fcolor("68 170 153") lcolor("68 170 153")) plot3opts(fcolor("136 34 85") lcolor("136 34 85")) plot4opts(fcolor("136 204 238") lcolor("136 204 238"))  plot5opts(fcolor("204 102 119") lcolor("204 102 119")) name(g7_a, replace)
	margins pathway, at(race = (1(1)5) motheredlevel = (1(1)3)) predict(outcome(2))
		marginsplot, graphdimension(pathway) bydimension(motheredlevel) xdimension(race) noci recast(bar) byopts(title("") l1title("") b1title("") rows(1) graphregion(fcolor(white)) imargin(small)) plotopts(ylabel(0(0.2)1) xlabel(,angle(45)) plotregion(margin(zero))) plotdimension(race) plot1opts(fcolor("51 34 136") lcolor("51 34 136")) plot2opts(fcolor("68 170 153") lcolor("68 170 153")) plot3opts(fcolor("136 34 85") lcolor("136 34 85")) plot4opts(fcolor("136 204 238") lcolor("136 204 238")) plot5opts(fcolor("204 102 119") lcolor("204 102 119")) name(g7_b, replace)
	levelsof entry_pathway, local(pathways)
	local named_graphs
	forvalues i = 1/`: word count `pathways'' {
		local named_graphs `named_graphs' g7_a`i'
		}
	forvalues i = 1/`: word count `pathways'' {
		local named_graphs `named_graphs' g7_b`i'	
		}	
		grc1leg2 `named_graphs', title("Adjusted Probability of First Completion/Transfer" "by Mother's Education Level and Race/Ethnicity") l2title("Adjusted Probability") l1title("First Transfer First Completion", size(small)) graphregion(fcolor(white)) rows(2) lrows(5) position(3) symxsize(small) labsize(small) xsize(9) note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall)) // the l1title() approach used here is admittedly a little informal, but it is a useful approach given how we needed to set up this graph
		graph export "${saved_graphs}/7_race_3.png", replace		
	}
	
	
// Charts: mother's ed.
	
// Main mother level of education margins
	
	{
	margins pathway, at(motheredlevel = (1(1)4)) predict(outcome(1)) predict(outcome(2))
	matrix ans = (r(b))'	
	cap frame drop working
	frame create working
	frame change working
	svmat2 ans, rnames(estimate_name)
	order estimate_name ans1
	rename ans1 prediction_
	gen outcome_level = ustrregexs(1) if ustrregexm(estimate_name, "^([0-9])")
	destring outcome_level, replace
	gen mothered_level = ustrregexs(1) if ustrregexm(estimate_name, "predict#([0-9]+)")
	destring mothered_level, replace
	label define edlevel_vals 1 "Middle Sch" 2 "High Sch" 3 "Any College" 4 "NA"//unfortunately these value labels must be re-copied from above; value labels created in one frame are not accessible in another
	label values mothered_level edlevel_vals
	gen pathway_level = ustrregexs(1) if ustrregexm(estimate_name, "_at#([0-9]+)")
	destring pathway_level, replace
	label define pathway_vals 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway"//please modify appropriately; unfortunately, value labels do not copy automatically into new frames	
	label values pathway_level pathway_vals
	drop estimate_name
	order mothered_level pathway_level outcome_level	
	reshape wide prediction_, i(mothered_level pathway_level) j(outcome_level)
		graph bar (asis) prediction_1 prediction_2, by(pathway_level, title("Adjusted Probability of First Completion/Transfer" "by Mother's Education Level") b1title("Mother's Eduation Level") imargin(medium) note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort. Adjusted probabilities" "for each outcome are stacked.", size(vsmall)) graphregion(fcolor(white))) ytitle("Adjusted Probability") over(mothered_level, relabel(1 `" "Middle" "Sch" "' 2 `" "High" "Sch" "' 3 `" "Any" "College" "') label(labsize(small))) stack ylabel(0(0.2)1) legend(order(1 "Completion First" 2 "Transfer First")) bar(1, fcolor("51 34 136") lcolor(black)) bar(2, fcolor("68 170 153") lcolor(black))
		graph export "${saved_graphs}/8_mothered_1.png", replace	
	frame change default	
	frame drop working
	
// Mother level of education margins by gender
	
	margins pathway, at(male = (0 1) motheredlevel = (1(1)3)) predict(outcome(1))
		marginsplot, graphdimension(pathway) bydimension(male) xdimension(motheredlevel) noci recast(bar) byopts(title("") l1title("") b1title("") graphregion(fcolor(white)) imargin(small)) plotopts(ylabel(0(0.2)1) xlabel(,angle(45)) plotregion(margin(zero))) plotdimension(motheredlevel) plot1opts(fcolor("51 34 136") lcolor("51 34 136"))  plot2opts(fcolor("68 170 153") lcolor("68 170 153")) plot3opts(fcolor("136 34 85") lcolor("136 34 85")) name(g8_a, replace)
	margins pathway, at(male = (0 1) motheredlevel = (1(1)3)) predict(outcome(2))
		marginsplot, graphdimension(pathway) bydimension(male) xdimension(motheredlevel) noci recast(bar) byopts(title("") l1title("") b1title("") graphregion(fcolor(white)) imargin(small)) plotopts(ylabel(0(0.2)1) xlabel(,angle(45)) plotregion(margin(zero))) plotdimension(motheredlevel) plot1opts(fcolor("51 34 136") lcolor("51 34 136")) plot2opts(fcolor("68 170 153") lcolor("68 170 153")) plot3opts(fcolor("136 34 85") lcolor("136 34 85")) name(g8_b, replace)
	levelsof entry_pathway, local(pathways)
	local named_graphs
	forvalues i = 1/`: word count `pathways'' {
		local named_graphs `named_graphs' g8_a`i'
		}
	forvalues i = 1/`: word count `pathways'' {
		local named_graphs `named_graphs' g8_b`i'
		}
		grc1leg2 `named_graphs', title("Adjusted Probability of First Completion/Transfer" "by Gender and Mother's Education Level") l2title("Adjusted Probability") l1title("First Transfer First Completion", size(small)) graphregion(fcolor(white)) rows(2) lrows(3) position(3) symxsize(small) labsize(small) xsize(7) note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall)) //the l1title() approach used here is admittedly a little informal, but it is a useful approach given how we needed to set up this graph
		graph export "${saved_graphs}/8_mothered_2.png", replace	
	}
	
	
// Charts: gender margins

// Main gender margins

	{
	margins pathway, at(male = (0 1)) predict(outcome(1)) predict(outcome(2))
	matrix ans = (r(b))'
	cap frame drop working
	frame create working
	frame change working
	svmat2 ans, rnames(estimate_name)
	order estimate_name ans1
	rename ans1 prediction_
	gen outcome_level = ustrregexs(1) if ustrregexm(estimate_name, "^([0-9])")
	destring outcome_level, replace
	gen male_level = ustrregexs(1) if ustrregexm(estimate_name, "predict#([0-9])")
	destring male_level, replace
	label define male 1 "Female" 2 "Male"//unfortunately these value labels must be re-copied from above; value labels created in one frame are not accessible in another
	label values male_level male
	gen pathway_level = ustrregexs(1) if ustrregexm(estimate_name, "_at#([0-9]+)")
	destring pathway_level, replace
	label define pathway_vals 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway"//please modify appropriately; unfortunately, value labels do not copy automatically into new frames	
	label values pathway_level pathway_vals
	drop estimate_name
	order male_level pathway_level outcome_level	
	reshape wide prediction_, i(male_level pathway_level) j(outcome_level) 	
		graph bar (asis) prediction_1 prediction_2, by(pathway_level, title("Adjusted Probability of First Completion/Transfer" "by Gender") b1title("Gender") imargin(medium) note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort. Adjusted probabilities" "for each outcome are stacked.", size(vsmall)) graphregion(fcolor(white))) ytitle("Adjusted Probability") over(male_level) stack ylabel(0(0.2)1) legend(label(1 "Completion First") label(2 "Transfer First")) xsize(5.5) bar(1, fcolor("51 34 136") lcolor(black)) bar(2, fcolor("68 170 153") lcolor(black))			
		graph export "${saved_graphs}/9_gender.png", replace	
	frame change default
	frame drop working			
	}
	




// Comments about this code
	
// Data for this analysis code should be set up according to the accompanying data specification guide.
	
// Code below for this analyis should be modified according to your needs. In some places, comments explicitly prompt you to appropriately modify a minimum number of commands for your institution's data, or else the output may not be correct or useful. And of course feel free to modify any other commands, too.	
	
// Stata version 16 or higher is required to run the code below because of the python components. Earliear versions of Stata cannot interact with python. If you do not have access to version 16, you can copy the python code to a separate python script to run.
	
// Set up and setting filepaths
	
	version 16.1
	clear all
	macro drop all

// set path to your saved .csv data file matching spec document	

	global path_to_data "some_directory/perhaps_another_directory/maybe_even_one_more_directory/your_data.csv" 

// set path for where to save a collapsd data set that will actually be used for graphing
	
	global path_to_save_collapsed_data "some_directory/perhaps_another_directory/maybe_even_one_more_directory/collapsed_data.dta" 
	
// Load data set up according to spec

	import delimited "${path_to_data}", clear
	
// Create label for entry pathway codes

// label define entry_pathway_vals 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway" optional, leave commented out if you prefer numeric pathway codes be used in chart titles; otherwise, uncomment and fill out appropriately
	
	label dir
	if regexm("`r(names)'", "entry_pathway_vals") {//this code (regexm) will not run when the code defining entry_pathway_vals remains commented out
		ssc install labutil2 // this quickly installs additional Stata commands used just below
		labellist entry_pathway_vals
		local entry_pathway_vals_labels `r(entry_pathway_vals_labels)'
		local entry_pathway_vals_values `r(entry_pathway_vals_values)'
		}
	
// Collapse data in prep for graphing

// Identify the number of terms included for students in each initial pathway; should be equal for all students entering that pathway, even if multiple entering cohorts are included, though it can differ across initial pathways*/

	local initial_pathways_num_terms
	levelsof pathway if cohorttermindex == 1, local(initial_pathways)
	foreach p in `initial_pathways' {
		preserve
		bys studentid (cohorttermindex): gen initial_pathway = pathway[1]
		keep if initial_pathway == `p'
		bys studentid: gen record_count = _N
		distinct record_count
		assert r(ndistinct) == 1//making sure that indeed each student for a specific initial pathway has same number of terms included
		levelsof record_count, local(rec_count)
		drop initial_pathway record_count
		restore
		local initial_pathways_num_terms `initial_pathways_num_terms' `rec_count'
		}
	di "`initial_pathways_num_terms'"

// Collapsing will include, within each value of initial pathway, a separate collapse for each semester-to-semester transition

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

// Label variables

	label var entry_pathway "pathway code associated with a student at entry"
	label var semester_transition "the semester-to-semester transition index (max will be one less than number of semesters included for that initial pathway)"
	label var pathway_origin "pathway code associated with a student for the origin term of a transition"
	label var pathway_target "pathway code associated with a student for the next term of a transition"
	label var num_students "number of students described"

// Generate a variable called entry_pathway_label, if entry_pathway_vals was set above as a label

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
	

// Save out collapsed data

	save "${path_to_save_collapsed_data}", replace 

// Run Sankey diagrams

	python:
	import plotly.graph_objects as go
	import pandas as pd

//  Read in preppped data

	df_full = pd.read_stata("${path_to_save_collapsed_data}")
	df_full.head()

//  Establish list to contain Sankey charts

	charts = []

//  Establish dictionary of pathway code labels to be used in chart titles, if entry_pathway_vals label set in Stata above

	pathway_label_titles = dict()
	if 'entry_pathway_label' in df_full.columns:
	for e in sorted(list(df_full.entry_pathway.unique())):
		pathway_label_titles[e] = list(df_full[df_full['entry_pathway'] == e].entry_pathway_label.unique())[0]
		df_full = df_full.drop('entry_pathway_label', 1)//drop column of labels now that is no longer needed; want numeric indexing statements below to be the same whether entry_pathway_vals defined or not
	
//  Loop over entry pathway codes and create a Sankey chart for each, across all available transition periods

	for e in sorted(list(df_full.entry_pathway.unique())):
		print('Creating Sankey chart for entry pathway: {}'.format(e))
	df = df_full[df_full['entry_pathway'] == e]//Subset to just the students entering that pathway
	d = dict()//Set up dictionary that will be used to do indexing of source and target nodes
	counter = 1
	transitions = sorted(list(df.semester_transition.unique()))
	last_trans = max(transitions)
	for s in transitions: 
		print('Transition: {}'.format(s))
		trans_s_df = df[df['semester_transition'] == s]//Subset to just the records for the transition period s
		if s < last_trans://Only need the first pathway codes for non-last transitions; the first pathway codes of the next transition are the second pathway codes of the transition before
			print(counter)
			d[counter] = list(trans_s_df.pathway_origin.unique())
			counter = counter + 1
		else://For the last transition, we do need to add both the first and last pathway codes
			print(counter)
			d[counter] = list(trans_s_df.pathway_origin.unique())
			counter = counter + 1
			print(counter)
			d[counter] = list(trans_s_df.pathway_target.unique())
			counter = counter + 1			
	
	list_lengths = [len(d[x]) for x in d]//Repackage the contents of the dictionary as tuples that include required indexing bump
	index_bumps = []//pathway codes will (and must) appear multiple times in lables_list; have to make sure you index the right one
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
	
//Next step is to go line by line through data frame, calculating for each row: source node index, target node index, value, accummulating these in three separate lists (the list of node labels will just be all the dictionary pathway list values appended together, in order)

	labels_list = list()
	source_list = list()
	target_list = list()
	value_list = list()
	for s in transitions:
		print('Getting info for transition {}'.format(s))
		trans_s_df = df[df['semester_transition'] == s]//Subset to just the records for the transition period s
		for r in range(trans_s_df.shape[0])://Now iterate through all rows for that transition
			print('Getting info for row {}'.format(r))//Get the indices of the first and second pathway codes for each transition, using info stored in final_d, including index bump
			source_node = final_d[s][0].index(trans_s_df.iat[r, 2]) + final_d[s][1]//first pathway code
			target_node = final_d[s+1][0].index(trans_s_df.iat[r, 3]) + final_d[s+1][1]//second pathway code
			source_list.append(source_node)//Append values to relevant lists
			target_list.append(target_node)
			value_list.append(trans_s_df.iat[r, 4])
		if s < last_trans:
			labels_list.extend(final_d[s][0])
		else:
			labels_list.extend(final_d[s][0])
			labels_list.extend(final_d[s+1][0])
	labels_list_str = [str(x) for x in labels_list]//Convert labels_list to string elements with 'Unenrolled' replacing 99, 'Completer' for 100,'Transfer' for 101
	labels_list_99 = ['Unenrolled' if x == '99' else x for x in labels_list_str]
	labels_list_100 = ['Completer' if x == '100' else x for x in labels_list_99]
	labels_list_final = ['Transfer' if x == '101' else x for x in labels_list_100]

// Review all newly created lists

	print(final_d)
	print(labels_list_final)
	print(source_list)		
	print(target_list)
	print(value_list)

//Create the Sankey chart

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

// Append Sankey to list of charts
	
	charts.append(fig)

//Render all the Sankey charts

	for g in charts:
		g.show()	
	end






// Comments about this code

// Data for this analysis code should be set up according to the accompanying data specification guide.

// Code below for this analyis should be modified according to your needs. In some places, comments explicitly prompt you to appropriately modify a minimum number of commands for your institution's data, or else the output may not be correct or useful. And of course feel free to modify any other commands, too.	

// Stata version 16 or higher is required to run the code below because of the python components. Earliear versions of Stata cannot interact with python. If you do not have access to version 16, you can copy the python code to a separate python script to run.

// Set up and setting filepaths

	version 16.1
	clear all
	macro drop all

// set path to your saved .csv data file matching spec document

	global path_to_data "some_directory/perhaps_another_directory/maybe_even_one_more_directory/your_data.csv" 

// set path to where you'd like to save an intermediate .dta data file before final analysis

	global graph_ready "some_directory/perhaps_another_directory/maybe_even_one_more_directory/graph_ready.dta" 

// Load data set up according to spec

	import delimited "${path_to_data}", clear

// Create label for entry pathway codes

	label define entry_pathway_vals 0 "General" 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway"//optional, leave commented out if you prefer numeric pathway codes be used in chart titles; otherwise, uncomment and fill out appropriately
	label dir
	if regexm("`r(names)'", "entry_pathway_vals") {//this code will not run when the code defining entry_pathway_vals remains commented out
		ssc install labutil2//this quickly installs additional Stata commands used just below
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
	save "${graph_ready}", replace//if entry_pathway_vals is not uncommented and set above, then this save command just re-saves the intial data, unmodified, as a .dta file

// Chart set up

// Plotly Scatterplot with tooltip hover

	python
	import plotly.express as px
	import numpy as np
	import pandas as pd

// Read in prepped data

	df = pd.read_stata("${graph_ready}")

// Add column to be passed to color argument
	
	df['color_val'] = "constant"

// Set up list for accummulating scatterplot charts
	
	charts = list()

//Establish dictionary of pathway code labels to be used in chart titles, if entry_pathway_vals label set in Stata above
	
	pathway_label_titles = dict()
		if 'entry_pathway_label' in df.columns:
			for c in sorted(list(df.pathway.unique())):
			pathway_label_titles[c] = list(df[df['pathway'] == c].entry_pathway_label.unique())[0]
		df = df.drop('entry_pathway_label', 1)//drop column of labels now that it is no longer needed
		
//Round proportion_failing, prob_completer_pass, prob_completer_fail, prob_completer_diff for better display
	
	df['proportion_failing'] = np.round(df['proportion_failing'], 2)
	df['prob_completer_pass'] = np.round(df['prob_completer_pass'], 2)
	df['prob_completer_fail'] = np.round(df['prob_completer_fail'], 2)
	df['prob_completer_diff'] = np.round(df['prob_completer_diff'], 2)
	
// Set up the charts

	for c in sorted(list(df['pathway'].unique())):
		df_display = df[df['pathway'] == c]//Subset to data for a single pathway
		if np.amin(df_display['prob_completer_diff']) < 0://Set min and max for axes
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
	
// Create scatterplot

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
	
// Highlight y = 0 line for reference if y range extends below 0
	
	if y_min < 0:
		fig.add_hline(y=0, line_color="black", opacity = 1)

// Append chart to list

	charts.append(fig)
	
// Render all the charts

	for g in charts:
	g.show()
						   
	end





// Comments about this code

// Data for this analysis code should be set up according to the accompanying data specification guide.

// Code below for this analyis should be modified according to your needs. In some places, comments explicitly prompt you to appropriately modify a minimum number of commands for your institution's data, or else the output may not be correct or useful. And of course feel free to modify any other commands, too.	

// Stata version 16 or higher is required to run the code below because of the frames commands. Earliear versions of Stata do not allow for different frames. If you do not have access to version 16, you can modify the appropriate commands to use tempfiles instead and achieve a similar result.			

// Set up and setting filepaths

	version 16.1
	clear all
	macro drop all		
	
// set path to your saved .csv data file matching spec document

	global path_to_data "some_directory/perhaps_another_directory/maybe_even_one_more_directory/your_data.csv" 

// set path for where you'd like graphs saved on your computer		

	global saved_graphs "some_directory/perhaps_another_directory/finally_the_directory_where_you_would_like_your_graphs_saved"

// Load data set up according to spec

	import delimited "${path_to_data}", clear		

// Generate and label an entry pathway

// Generate an entry pathway code for each student

	bys studentid (cohorttermindex): gen entry_pathway = pathway[1]
	label var entry_pathway "pathway code associated with a student at entry"	

// Label pathway

	label define pathway_entry_vals 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway"//this is just a placeholder example; please modify with the full names associated with each entry pathway code at your institution
	label values pathway pathway_entry_vals		

// A few additional calculations to complement initial data file

// Generate cumulative college-level credits earned by term

	bys studentid (cohorttermindex): gen cumcollegecreditsearned = sum(collegecreditsearned)
	label var cumcollegecreditsearned "cumulative college-level credits earned by a student term to term"

// Generate cumulative credits earned by term

	bys studentid (cohorttermindex): gen cumcreditsearned = sum(creditsearned)
	label var cumcreditsearned "cumulative credits earned by a student term to term, whether college-level or developmental credits"

// Generate cumulative college-level credits attempted by term

	bys studentid (cohorttermindex): gen cumcollegecreditsattempted = sum(collegecreditsattempted)
	label var cumcollegecreditsattempted "cumulative college-level credits attempted by a student term to term"

// Determine number of terms included in data for each student

	sum cohorttermindex
	global max_term = r(max)	

// Generate ideal credits earned and cumulative credits earned amounts

	gen idealcreditsearned = 0
	label var idealcreditsearned "ideal number of credits a student would earn each term"
	replace idealcreditsearned = 15 if inrange(cohorttermindex, 1, 4)
	bys studentid (cohorttermindex): gen cumidealcreditsearned = sum(idealcreditsearned)
	label var cumidealcreditsearned "cumulative ideal number of credits a student would have earned each term"

// Code in an indicator for a terminating event (first completion or first transfer)

	gen terminating = inlist(pathway, 100, 101)	
	label var terminating "indicator for a terminating event: first completion or transfer"

// Create cumulative credit charts

// Avg. college-level cumulative credits attempted vs. earned

	preserve
	collapse (mean) cumcollegecreditsearned cumcollegecreditsattempted cumidealcreditsearned, by(entry_pathway cohorttermindex)
		twoway (line cumcollegecreditsearned cohorttermindex, lcolor("51 34 136")) (line cumcollegecreditsattempted cohorttermindex, lcolor("68 170 153") lpattern(dash)) (line cumidealcreditsearned cohorttermindex, lcolor("136 34 85")), by(entry_pathway, graphregion(fcolor(white)) imargin(medium) title("Average Cumulative College-Level Credits" "Attempted vs. Earned") note("Note: College-level credit counts exclude developmental coursework.", size(vsmall))) legend(label(1 "Earned") label(2 "Attempted") label(3 "On-Track")) yline(0, lcolor(black)) plotregion(margin(zero)) ytitle("Avg. Cumulative College-Level Credits") xtitle("Cohort Term") ylabel(0(15)60) xlabel(1(1)${max_term})//colors specifically chosen to be colorblind accessible
		graph export "${saved_graphs}/1_avg_cum_college-level_credits_attempted_vs_earned.png", replace
	restore	





// Create credits earned by early momentum charts

// Avg. college-level cumulative credits earned by early momentum

	preserve
	sum cumcollegecreditsearned if cohorttermindex == 1, detail
	scalar p25 = r(p25)
	scalar p75 = r(p75)
	gen bin = 0
	replace bin = 1 if cohorttermindex == 1 & cumcollegecreditsearned <= p25
	replace bin = 2 if cohorttermindex == 1 & (cumcollegecreditsearned > p25 & cumcollegecreditsearned <= p75)
	replace bin = 3 if cohorttermindex == 1 & cumcollegecreditsearned > p75
	bys studentid (cohorttermindex): replace bin = bin[1]
	assert !missing(bin)
	label define early_credits_bin 1 "< 25th Percentile" 2 "25th - 75th Percentile" 3 "> 75th Percentile"
	label values bin early_credits_bin
	collapse (mean) cumcollegecreditsearned, by(entry_pathway cohorttermindex bin)
		twoway (line cumcollegecreditsearned cohorttermindex if bin == 1, lcolor("51 34 136")) (line cumcollegecreditsearned cohorttermindex if bin == 2, lcolor("68 170 153")) (line cumcollegecreditsearned cohorttermindex if bin == 3, lcolor("136 34 85")), by(entry_pathway, title("Average College-Level Credit Accummulation" "by Entry Term College-Level Credits Earned") graphregion(fcolor(white)) note("Note: College-level credit counts exclude developmental coursework.", size(vsmall)) imargin(medium)) xtitle("Cohort Term") ytitle("Avg. College-Level Credit Accumulation") legend(title("Entry Term College-Level Credits Earned Percentile", size(small)) label(1 "< 25th") label(2 "25th - 75th") label(3 "> 75th")) xlabel(1(1)${max_term}) yline(0, lcolor(black)) plotregion(margin(zero))
		graph export "${saved_graphs}/2_avg_cum_college-level_credits_by_early_momentum.png", replace
	restore






// Create completer/transfer rate charts

// Data set up for completion/transfer rates by college-level credits earned

	cap frame drop complete_trans_entry_college_credits
	frame copy default complete_trans_college_credits
	frame change complete_trans_college_credits
	drop if cumcollegecreditsearned > 21 & cohorttermindex == 1//exclude students who earned more than 21 college credits in their first term as outliers; though this threshold is somewhat arbitrary
	bys studentid: egen min_cohorttermindex = min(cohorttermindex)
	drop if min_cohorttermindex != 1
	drop min_cohorttermindex
	gen credit_bin_in_first_term = 0
	local lower_bound = 0
	forvalues c = 3(3)21 {
		di in red `lower_bound'
		di in red `c'
		table credit_bin_in_first_term if cohorttermindex == 1, c(min cumcollegecreditsearned max cumcollegecreditsearned)
		if `lower_bound' == 0 {
			replace credit_bin_in_first_term = `c' if cohorttermindex == 1 & (cumcollegecreditsearned <= `c')
		} 
		else {
			replace credit_bin_in_first_term = `c' if cohorttermindex == 1 & (cumcollegecreditsearned > `lower_bound' & cumcollegecreditsearned <=`c')
		}
		local lower_bound = `c'
	}
	table credit_bin_in_first_term if cohorttermindex == 1, c(min cumcollegecreditsearned max cumcollegecreditsearned)
	bys studentid: egen any_terminating = max(terminating)
	bys studentid (cohorttermindex): replace credit_bin_in_first_term = credit_bin_in_first_term[1]
	collapse (mean) any_terminating, by(entry_pathway credit_bin_in_first_term)
	gen credit_type = "college-level"
	tempfile college_credits
	save `college_credits'	

// Data set up for completion/transfer rates by credits earned in first term, whether credits were college-level or not

	cap frame drop complete_trans_credits
	frame copy default complete_trans_credits
	frame change complete_trans_credits
	drop if cumcreditsearned > 21 & cohorttermindex == 1//exclude students who earned more than 21 college credits in their first term as outliers; though this threshold is somewhat arbitrary
	bys studentid: egen min_cohorttermindex = min(cohorttermindex)
	drop if min_cohorttermindex != 1
	drop min_cohorttermindex
	gen credit_bin_in_first_term = 0
	local lower_bound = 0
	forvalues c = 3(3)21 {
		di in red `lower_bound'
		di in red `c'
		table credit_bin_in_first_term if cohorttermindex == 1, c(min cumcreditsearned max cumcreditsearned)
		if `lower_bound' == 0 {
			replace credit_bin_in_first_term = `c' if cohorttermindex == 1 & (cumcreditsearned <= `c')
		} 
		else {
			replace credit_bin_in_first_term = `c' if cohorttermindex == 1 & (cumcreditsearned > `lower_bound' & cumcreditsearned <=`c')
		}
		local lower_bound = `c'
	}
	table credit_bin_in_first_term if cohorttermindex == 1, c(min cumcreditsearned max cumcreditsearned)
	bys studentid: egen any_terminating = max(terminating)
	bys studentid (cohorttermindex): replace credit_bin_in_first_term = credit_bin_in_first_term[1]
	collapse (mean) any_terminating, by(entry_pathway credit_bin_in_first_term)
	gen credit_type = "any"

// Combine data sets for completion/transfer rates by both credit types in first term: any credit and college-level credit

	append using `college_credits'

// Completion/transfer rates by pathway and first-term credit-type bins

	twoway (line any_terminating credit_bin_in_first_term if credit_type == "any", lcolor("51 34 136")) (line any_terminating credit_bin_in_first_term  if credit_type == "college-level", lcolor("68 170 153")), by(entry_pathway, graphregion(fcolor(white)) title("First Completion/Transfer Rates by Pathway" "and Entry Term Credits Earned") imargin(medium) note("Note: Credits earned in the first term are grouped into three-credit intervals, labeled by the maximum of the interval. Developmental" "credits are included in the Any Credits sum, but not the College-Level sum.", size(vsmall))) xtitle("Credits Earned in First Term") ytitle("3 Yr. First Completion/Transfer Rate") ylabel(0(0.2)1.05)  xlabel(3(3)21) plotregion(margin(zero)) yline(0, lcolor(black))  legend(label(1 "Any Credits") label(2 "College-Level Credits"))
	graph export "${saved_graphs}/3_student_status_at_6_terms_by_entry_term_credits_earned.png", replace





