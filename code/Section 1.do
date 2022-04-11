/*******************************************************************************
	Section 1 Code
*******************************************************************************/

	/*****************************************
	 Comments about this code
	*****************************************/
	
	// Data for this analysis code should be set up according to the accompanying data specification guide.
	
	// Code below for this analyis should be modified according to your needs. In some places, comments explicitly prompt
	// you to appropriately modify a minimum number of commands for your institution's data, or else the output may not be
	// correct or useful. And of course feel free to modify any other commands, too.
	
	// Stata version 16 or higher is required to run the code below, especially the frames-related commands. Earlier versions of 
	// Stata can be used if these commands are removed and replaced with similar functionality like tempfiles.
	
	// The code below varies considerably in complexity depending on which graph is being created. Stata's marginsplot command does
	// not make it easy to create stacked bar graphs, which require more explicit, longer commands.
	
	// If you do not already have the user-written Stata command svmat2 installed, please see Stata's website for more guidance on 
	// how to install this. The appropriate installation approach might depend on the environment in which you are using Stata.
	
	// If you do not alraedy have the user-written Stata command grc1leg2 installed, please type "search grc1leg2" in the Stata 
	// console for more installation information.
	
	// Note that this code does not create margins plots for all pairwise combinations of covariates in the model. Specifically, no 
	// plots are created for combinations of two continuous variables. Nor are redundant combinations included (e.g. a margins plot 
	// for race/ethnicity and gender is included once in the race/ethnicity graphing section, which appears before the gender 
	// graphing section).
		
	
	
	/***************************************
	 Set up and setting filepaths
	***************************************/
	
	version 16.1
	clear all
	macro drop all		
	
	global path_to_data		"some_directory/perhaps_another_directory/maybe_even_one_more_directory/your_data.csv" // set path to your saved .csv data file matching spec document
	global saved_graphs		"some_directory/perhaps_another_directory/finally_the_directory_where_you_would_like_your_graphs_saved" // set path for where you'd like graphs saved on your computer
	
	
	
	/***************************************
	 Load data set up according to spec
	***************************************/
	
	import delimited "${path_to_data}"
	
	
	/********************************************
	 Label variables as relevant to institution
	********************************************/
	
	* male
	label define male_vals 0 "Female" 1 "Male" // set these value labels according to your preferred conventions
	label values male male_vals
	
	* race
	label define race_vals 1 "Asian" 2 "Black" 3 "Hispanic" 4 "White" 5 "Other"	
	label values race race_vals
	
	* motheredlevel
	label define edlevel_vals 1 "Middle Sch" 2 "High Sch" 3 "Any College" 4 "NA"	
	label values motheredlevel edlevel_vals
	
	* pathway
	label define pathway_entry_vals 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway" // this is just a placeholder example; please modify with the full names associated with each entry pathway code at your institution
	label values pathway pathway_entry_vals
	
	
	/******************************************
	 Generate additional variables
	******************************************/
	
	* Determine number of terms included in data for each student
	sum cohorttermindex
	global max_term = r(max)		
	
	* Outcome variable at the student level, across terms
	gen outcome = 0
	replace outcome = 1 if pathway == 100 & cohorttermindex == $max_term
	replace outcome = 2 if pathway == 101 & cohorttermindex == $max_term
	bys studentid (cohorttermindex): replace outcome = outcome[$max_term]
	
	* Label outcome
	label define outcome_vals 0 "None" 1 "Completion" 2 "Transfer"
	label values outcome outcome_vals
	label var outcome "student outcome after ${max_term} terms"
	
	* Code in an indicator for a terminating event (first completion or first transfer)
	gen terminating = inlist(pathway, 100, 101)	
	label var terminating "indicator for a terminating event: first completion or transfer"
	
	* Generate an indicator for non-enrollment
	gen nonenrolled = pathway == 99
	label var nonenrolled "indicator for non-enrollment in a term"	
	
	* Generate an entry pathway code for each student
	bys studentid (cohorttermindex): gen entry_pathway = pathway[1]
	label var entry_pathway "pathway code associated with a student at entry"	
	
	* Label entry pathways
	label values entry_pathway pathway_entry_vals
	
	
	
	/**********************************
	 Run regressions and plot margins
	**********************************/		
	
	* Model: outcomes conditional only on initial pathway choice
	mlogit outcome i.pathway if cohorttermindex == 1, robust // note that because each student will have multiple rows in the data but with covariate values fixed at values observed at entry,
															 // we only need to run the regression with the first entry for each student
		
	* Chart: pathway unadjusted margins
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
	reshape wide prediction_, i(pathway_level) j(outcome_level) 	
	label define pathway_vals 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway" // please modify appropriately; unfortunately, value labels do not copy automatically into new frames
	label values pathway_level pathway_vals
	graph bar (asis) prediction_1 prediction_2, title("Probability of Completion First or Transferring First" "by Pathway") ytitle("Probability") b1("Pathway") over(pathway_level) ///
												stack ylabel(0(0.2)1) graphregion(fcolor(white)) legend(label(1 "Completion First") label(2 "Transfer First")) ///
												xsize(5.5) note("Note: Probabilities for each outcome are stacked.", size(vsmall)) bar(1, fcolor("51 34 136") lcolor(black)) bar(2, fcolor("68 170 153") ///
												lcolor(black)) // colors chosen for colorblindness accessibility
	graph export "${saved_graphs}/1_main.png", replace
	frame change default
	frame drop working		
	}
	
	
	* Model: outcomes conditional on baseline student traits
	# delimit ; // note mi_motheredlevel omitted because missingness is already encoded as level 4 of motheredlevel so it's excluded from the full model
	mlogit outcome c.age c.age#i.pathway c.hsgpa i.mi_hsgpa c.hsgpa#i.pathway i.male i.male#i.pathway 
	c.pell i.mi_pell c.pell#i.pathway i.motheredlevel i.motheredlevel#i.pathway i.race 
	i.race#i.pathway i.pathway i.institutionid i.cohortyear if cohorttermindex == 1, robust;
	# delimit cr	// note that because each student will have multiple rows in the data but with covariate values fixed at values observed at entry,
					// we only need to run the regression with the first entry for each student
	
	
	* Chart: pathway adjusted margins
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
	label define pathway_vals 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway" // please modify appropriately; unfortunately, value labels do not copy automatically into new frames
	label values pathway_level pathway_vals
	drop estimate_name
	order outcome_level pathway_level	
	reshape wide prediction_, i(pathway_level) j(outcome_level) 	
	graph bar (asis) prediction_1 prediction_2, title("Adjusted Probability of Completion First" "or Transferring First by Pathway") ytitle("Adjusted Probability") b1("Pathway") over(pathway_level) stack ylabel(0(0.2)1) ///
												graphregion(fcolor(white)) legend(label(1 "Completion First") label(2 "Transfer First")) xsize(5.5) ///
												note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort. Adjusted" "probabilities for each outcome are stacked.", size(vsmall)) ///
												bar(1, fcolor("51 34 136") lcolor(black)) bar(2, fcolor("68 170 153") lcolor(black)) 
	graph export "${saved_graphs}/2_main_adjusted.png", replace
	frame change default
	frame drop working	
	}
	
	
	* Chart: waterfall view of completion/transfer, unenrollment, and continued enrollment over time
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
	label define pathway_vals 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway" // please modify appropriately; unfortunately, value labels do not copy automatically into new frames
	label values pathway pathway_vals		
	gen pct_nonenrolled_neg = -1*pct_nonenrolled // useful for getting this portion of cohort to hang below the x axis
	graph bar (asis) pct_stillenrolled pct_terminated pct_nonenrolled_neg, over(term) yline(0, lcolor(gray)) ///
			   bar(1, fcolor(navy)) bar(2, fcolor(green)) bar(3, fcolor(cranberry)) stack ///
			   by(pathway, title("First Completion/Transfer Rates by Pathway") b1title("Cohort Term") graphregion(fcolor(white)) legend(position(3)) note("Note: Each stacked bar represents an entire cohort each term.", size(vsmall))) ///
			   legend(cols(1) label(1 "Still Enrolled") label(2 "Completer/" "Transfer") label(3 "No Longer" "Enrolled") size(small) symxsize(small) textwidth(18)) ytitle("Proportion of Cohort") ylabel(-0.5 "0.5" 0 "0" 0.5 "0.5" 1 "1") ///
			   bar(1, fcolor("51 34 136") lcolor(black)) bar(2, fcolor("68 170 153") lcolor(black)) bar(3, fcolor("136 34 85") lcolor(black))
	graph export "${saved_graphs}/3_student_status_over_time.png", replace
	frame change default
	frame drop working		
	
	}	
	
	
	* Charts: high school GPA margins
	{
		
	* Main high school GPA margins
	margins pathway, at(hsgpa = (2(0.25)4)) predict(outcome(1)) predict(outcome(2))				
	marginsplot, bydimension(pathway) byopts(title("Adjusted Probability of Completion First or Transfer First" "by High School GPA") graphregion(fcolor(white)) imargin(medium) ///
				 note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall))) ///
				 ytitle("Adjusted Probability") xtitle("High School GPA") ylabel(0(0.2)1) noci legend(order(1 "Completion First" 2 "Transfer First")) plotregion(margin(zero)) yline(0, lcolor(black)) ///
				 plot1opts(mcolor("51 34 136") lcolor("51 34 136"), ) plot2opts(mcolor("68 170 153") lcolor("68 170 153"))
	graph export "${saved_graphs}/4_gpa_1.png", replace
	
	* High school GPA margins by gender
	margins pathway, at(male = (0(1)1) hsgpa = (2(0.25)4)) predict(outcome(1))	
	marginsplot, bydimension(pathway) plotdimension(male) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) ytitle("First Completion") xtitle("") ///
				 ylabel(0(0.2)1) xlabel(2(0.5)4) plotregion(margin(zero)) yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153")) ///
				 name(g4_a, replace)	
	margins pathway, at(male = (0(1)1) hsgpa = (2(0.25)4)) predict(outcome(2))
	marginsplot, bydimension(pathway) plotdimension(male) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) ytitle("First Transfer") xtitle("") ///
				 ylabel(0(0.2)1) xlabel(2(0.5)4) plotregion(margin(zero)) yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153")) ///
				 name(g4_b, replace)	
	grc1leg2 g4_a g4_b, title("Adjusted Probability of First Completion/Transfer" "by Gender and High School GPA") rows(2) graphregion(fcolor(white)) ///
		  b1title("High School GPA") l1title("Adjusted Probability") position(3) lrows(2) symxsize(small) labsize(small) xsize(7) ///
		  note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall))
	graph export "${saved_graphs}/4_gpa_2.png", replace
	
	* High school GPA margins by mother level of education
	margins pathway, at(motheredlevel = (1(1)3) hsgpa = (2(0.25)4)) predict(outcome(1))	
	marginsplot, bydimension(pathway) plotdimension(motheredlevel) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) ///
				 legend(order(1 "Middle Sch" 2 "High Sch" 3 "Any College")) ytitle("First Completion") xtitle("") ///
				 ylabel(0(0.2)1) xlabel(2(0.5)4) plotregion(margin(zero)) yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153")) ///
				 plot3opts(mcolor("136 34 85") lcolor("136 34 85")) name(g4_a, replace)
	margins pathway, at(motheredlevel = (1(1)3) hsgpa = (2(0.25)4)) predict(outcome(2))
	marginsplot, bydimension(pathway) plotdimension(motheredlevel) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) ytitle("First Transfer") xtitle("") ///
				 ylabel(0(0.2)1) xlabel(2(0.5)4) plotregion(margin(zero)) yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153")) ///
				 plot3opts(mcolor("136 34 85") lcolor("136 34 85")) name(g4_b, replace)
	grc1leg2 g4_a g4_b, title("Adjusted Probability of First Completion/Transfer" "by Mother's Education Level and High School GPA") rows(2) graphregion(fcolor(white)) ///
			b1title("High School GPA") l1title("Adjusted Probability") position(3) lrows(3) symxsize(small) labsize(small) xsize(7) ///
			note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall))
	graph export "${saved_graphs}/4_gpa_3.png", replace
	
	* High school GPA margins by race/ethnicity
	margins pathway, at(race = (1(1)5) hsgpa = (2(0.25)4)) predict(outcome(1))
	marginsplot, bydimension(pathway) plotdimension(race) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) ///
				 yline(0, lcolor(black)) ytitle("First Completion") xtitle("") ylabel(0(0.2)1) xlabel(2(0.5)4) plotregion(margin(zero)) ///
				 plot1opts(mcolor("51 34 136") lcolor("51 34 136")) ///
				 plot2opts(mcolor("68 170 153") lcolor("68 170 153")) ///
				 plot3opts(mcolor("136 34 85") lcolor("136 34 85")) ///
				 plot4opts(mcolor("136 204 238") lcolor("136 204 238")) ///
				 plot5opts(mcolor("204 102 119") lcolor("204 102 119")) ///
				 name(g4_a, replace)
	margins pathway, at(race = (1(1)5) hsgpa = (2(0.25)4)) predict(outcome(2))
	marginsplot, bydimension(pathway) plotdimension(race) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) ///
				 yline(0, lcolor(black)) ytitle("First Transfer") xtitle("") ylabel(0(0.2)1) xlabel(2(0.5)4) plotregion(margin(zero)) ///
				 plot1opts(mcolor("51 34 136") lcolor("51 34 136")) ///
				 plot2opts(mcolor("68 170 153") lcolor("68 170 153")) ///
				 plot3opts(mcolor("136 34 85") lcolor("136 34 85")) ///
				 plot4opts(mcolor("136 204 238") lcolor("136 204 238")) ///
				 plot5opts(mcolor("204 102 119") lcolor("204 102 119")) ///
				 name(g4_b, replace)				 
	grc1leg2 g4_a g4_b, title("Adjusted Probability of First Completion/Transfer" "by Race/Ethnicity and High School GPA") rows(2) graphregion(fcolor(white)) ///
			 b1title("High School GPA") l1title("Adjusted Probability") position(3) lrows(5) symxsize(small) labsize(small) xsize(7) ///
			 note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall))
	graph export "${saved_graphs}/4_gpa_4.png", replace
			
	}
	
	
	* Charts: Pell grant margins
	{
	
	* Main Pell grant margins 
	margins pathway, at(pell = (0(1000)6000)) predict(outcome(1)) predict(outcome(2))
	marginsplot, bydimension(pathway) byopts(title("Adjusted Probability of Completion First or Transfer First" "by Pell Grant Dollars") graphregion(fcolor(white)) imargin(medium) ///
				 note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall))) ///
				 ytitle("Adjusted Probability") xtitle("Pell Dollars Awarded in First Year") ylabel(0(0.2)1) xlabel(0(1500)6000) noci legend(order(1 "Completion First" 2 "Transfer First")) plotregion(margin(zero)) ///
				 yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153"))
	graph export "${saved_graphs}/5_pell_1.png", replace
	
	* Pell grant margins by gender
	margins pathway, at(male = (0 1) pell = (0(1000)6000)) predict(outcome(1))
	marginsplot, bydimension(pathway) plotdimension(male) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) ytitle("First Completion") xtitle("") ///
				 ylabel(0(0.2)1) xlabel(0(1500)6000) plotregion(margin(zero)) yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153")) ///
				 name(g5_a, replace)	
	margins pathway, at(male = (0 1) pell = (0(1000)6000)) predict(outcome(2))
	marginsplot, bydimension(pathway) plotdimension(male) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) ytitle("First Transfer") xtitle("") ///
				 ylabel(0(0.2)1) xlabel(0(1500)6000) plotregion(margin(zero)) yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153")) ///
				 name(g5_b, replace)		
	grc1leg2 g5_a g5_b, title("Adjusted Probability of First Completion/Transfer" "by Gender and Pell Grant Dollars") rows(2) graphregion(fcolor(white)) ///
		  b1title("Pell Dollars Awarded in First Year") l1title("Adjusted Probability") position(3) lrows(2) symxsize(small) labsize(small) xsize(7) ///
		  note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall))	
	graph export "${saved_graphs}/5_pell_2.png", replace
		
	* Pell grant margins by mother level of education
	margins pathway, at(motheredlevel = (1(1)3) pell = (0(1000)6000)) predict(outcome(1))
	marginsplot, bydimension(pathway) plotdimension(motheredlevel) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) ///
				 legend(order(1 "Middle Sch" 2 "High Sch" 3 "Any College")) ytitle("First Completion") xtitle("") ///
				 ylabel(0(0.2)1) xlabel(0(1500)6000) plotregion(margin(zero)) yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153")) ///
				 plot3opts(mcolor("136 34 85") lcolor("136 34 85")) name(g5_a, replace)	
	margins pathway, at(motheredlevel = (1(1)3) pell = (0(1000)6000)) predict(outcome(2))
	marginsplot, bydimension(pathway) plotdimension(motheredlevel) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) ytitle("First Transfer") xtitle("") ///
				 ylabel(0(0.2)1) xlabel(0(1500)6000) plotregion(margin(zero)) yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153")) ///
				 plot3opts(mcolor("136 34 85") lcolor("136 34 85")) name(g5_b, replace)	
	grc1leg2 g5_a g5_b, title("Adjusted Probability of First Completion/Transfer" "by Mother's Education Level and Pell Grant Dollars") rows(2) graphregion(fcolor(white)) ///
			b1title("Pell Dollars Awarded in First Year") l1title("Adjusted Probability") position(3) lrows(3) symxsize(small) labsize(small) xsize(7) ///
			note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall))	
	graph export "${saved_graphs}/5_pell_3.png", replace
	
	* Pell grant margins by race/ethnicity
	margins pathway, at(race = (1(1)5) pell = (0(1000)6000)) predict(outcome(1))
	marginsplot, bydimension(pathway) plotdimension(race) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) ///
				 yline(0, lcolor(black)) ytitle("First Completion") xtitle("") ylabel(0(0.2)1) xlabel(0(1500)6000) plotregion(margin(zero)) ///
				 plot1opts(mcolor("51 34 136") lcolor("51 34 136")) ///
				 plot2opts(mcolor("68 170 153") lcolor("68 170 153")) ///
				 plot3opts(mcolor("136 34 85") lcolor("136 34 85")) ///
				 plot4opts(mcolor("136 204 238") lcolor("136 204 238")) ///
				 plot5opts(mcolor("204 102 119") lcolor("204 102 119")) ///
				 name(g5_a, replace)					 
	margins pathway, at(race = (1(1)5) pell = (0(1000)6000)) predict(outcome(2))
	marginsplot, bydimension(pathway) plotdimension(race) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) ///
				 yline(0, lcolor(black)) ytitle("First Transfer") xtitle("") ylabel(0(0.2)1) xlabel(0(1500)6000) plotregion(margin(zero)) ///
				 plot1opts(mcolor("51 34 136") lcolor("51 34 136")) ///
				 plot2opts(mcolor("68 170 153") lcolor("68 170 153")) ///
				 plot3opts(mcolor("136 34 85") lcolor("136 34 85")) ///
				 plot4opts(mcolor("136 204 238") lcolor("136 204 238")) ///
				 plot5opts(mcolor("204 102 119") lcolor("204 102 119")) ///
				 name(g5_b, replace)		 
	grc1leg2 g5_a g5_b, title("Adjusted Probability of First Completion/Transfer" "by Race/Ethnicity and Pell Grant Dollars") rows(2) graphregion(fcolor(white)) ///
			 b1title("Pell Dollars Awarded in First Year") l1title("Adjusted Probability") position(3) lrows(5) symxsize(small) labsize(small) xsize(7) ///
			 note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall))		
	graph export "${saved_graphs}/5_pell_4.png", replace
	
	}	
	
		
	* Charts: age at entry margins
	{
	
	* Main age at entry margins
	margins pathway, at(age = (18(3)36)) predict(outcome(1)) predict(outcome(2))
	marginsplot, bydimension(pathway) byopts(title("Adjusted Probability of Completion First or Transfer First" "by Student Age at Entry") graphregion(fcolor(white)) imargin(medium) ///
				 note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall))) ///
				 ytitle("Adjusted Probability") xtitle("Student Age at Entry") ylabel(0(0.2)1) xlabel(18(3)36) noci legend(order(1 "Completion First" 2 "Transfer First")) plotregion(margin(zero)) yline(0, lcolor(black)) /// 
				 plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153"))
	graph export "${saved_graphs}/6_age_1.png", replace	

	* Age at entry margins by gender
	margins pathway, at(male = (0 1) age = (18(3)36)) predict(outcome(1))
	marginsplot, bydimension(pathway) plotdimension(male) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) ytitle("First Completion") xtitle("") ///
				 ylabel(0(0.2)1) xlabel(18(6)36) plotregion(margin(zero)) yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153")) ///
				 name(g6_a, replace)	
	margins pathway, at(male = (0 1) age = (18(3)36)) predict(outcome(2))
	marginsplot, bydimension(pathway) plotdimension(male) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) ytitle("First Transfer") xtitle("") ///
				 ylabel(0(0.2)1) xlabel(18(6)36) plotregion(margin(zero)) yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153")) ///
				 name(g6_b, replace)		
	grc1leg2 g6_a g6_b, title("Adjusted Probability of First Completion/Transfer" "by Gender and Age at Entry") rows(2) graphregion(fcolor(white)) ///
		  b1title("Age at Entry") l1title("Adjusted Probability") position(3) lrows(2) symxsize(small) labsize(small) xsize(7) ///
		  note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall))	
	graph export "${saved_graphs}/6_age_2.png", replace
	
	* Age at entry margins by mother level of education
	margins pathway, at(motheredlevel = (1(1)3) age = (18(3)36)) predict(outcome(1))
	marginsplot, bydimension(pathway) plotdimension(motheredlevel) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) ///
				 legend(order(1 "Middle Sch" 2 "High Sch" 3 "Any College")) ytitle("First Completion") xtitle("") ///
				 ylabel(0(0.2)1) xlabel(18(6)36) plotregion(margin(zero)) yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153")) ///
				 plot3opts(mcolor("136 34 85") lcolor("136 34 85")) name(g6_a, replace)	
	margins pathway, at(motheredlevel = (1(1)3) age = (18(3)36)) predict(outcome(2))
	marginsplot, bydimension(pathway) plotdimension(motheredlevel) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) ytitle("First Transfer") xtitle("") ///
				 ylabel(0(0.2)1) xlabel(18(6)36) plotregion(margin(zero)) yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153")) ///
				 plot3opts(mcolor("136 34 85") lcolor("136 34 85")) name(g6_b, replace)	
	grc1leg2 g6_a g6_b, title("Adjusted Probability of First Completion/Transfer" "by Mother's Education Level and Age at Entry") rows(2) graphregion(fcolor(white)) ///
			b1title("Age at Entry") l1title("Adjusted Probability") position(3) lrows(3) symxsize(small) labsize(small) xsize(7) ///
			note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall))	
	graph export "${saved_graphs}/6_age_3.png", replace
	
	* Age at entry margins by race/ethnicity
	margins pathway, at(race = (1(1)5) age = (18(3)36)) predict(outcome(1))
	marginsplot, bydimension(pathway) plotdimension(race) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) ///
				 yline(0, lcolor(black)) ytitle("First Completion") xtitle("") ylabel(0(0.2)1) xlabel(18(6)36) plotregion(margin(zero)) ///
				 plot1opts(mcolor("51 34 136") lcolor("51 34 136")) ///
				 plot2opts(mcolor("68 170 153") lcolor("68 170 153")) ///
				 plot3opts(mcolor("136 34 85") lcolor("136 34 85")) ///
				 plot4opts(mcolor("136 204 238") lcolor("136 204 238")) ///
				 plot5opts(mcolor("204 102 119") lcolor("204 102 119")) ///
				 name(g6_a, replace)	
	margins pathway, at(race = (1(1)5) age = (18(3)36)) predict(outcome(2))
	marginsplot, bydimension(pathway) plotdimension(race) noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) ///
				 yline(0, lcolor(black)) ytitle("First Transfer") xtitle("") ylabel(0(0.2)1) xlabel(18(6)36) plotregion(margin(zero)) ///
				 plot1opts(mcolor("51 34 136") lcolor("51 34 136")) ///
				 plot2opts(mcolor("68 170 153") lcolor("68 170 153")) ///
				 plot3opts(mcolor("136 34 85") lcolor("136 34 85")) ///
				 plot4opts(mcolor("136 204 238") lcolor("136 204 238")) ///
				 plot5opts(mcolor("204 102 119") lcolor("204 102 119")) ///
				 name(g6_b, replace)	
	grc1leg2 g6_a g6_b, title("Adjusted Probability of First Completion/Transfer" "by Race/Ethnicity and Age at Entry") rows(2) graphregion(fcolor(white)) ///
			 b1title("Age at Entry") l1title("Adjusted Probability") position(3) lrows(5) symxsize(small) labsize(small) xsize(7) ///
			 note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall))	
	graph export "${saved_graphs}/6_age_4.png", replace
		
	}
	
	
	* Charts: race/ethnicity margins
	{
	
	* Main race/ethnicity margins
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
	label define race_vals 1 "Asian" 2 "Black" 3 "Hispanic" 4 "White" 5 "Other" // unfortunately these value labels must be re-copied from above; value labels created in one frame are not accessible in another
	label values race_level race_vals
	gen pathway_level = ustrregexs(1) if ustrregexm(estimate_name, "_at#([0-9]+)")
	destring pathway_level, replace
	label define pathway_vals 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway" // please modify appropriately; unfortunately, value labels do not copy automatically into new frames	
	label values pathway_level pathway_vals
	drop estimate_name
	order race_level pathway_level outcome_level	
	reshape wide prediction_, i(race_level pathway_level) j(outcome_level)
	graph bar (asis) prediction_1 prediction_2, by(pathway_level, title("Adjusted Probability of First Completion/Transfer" "by Race/Ethnicity") b1title("Race/Ethnicity", size(medium)) imargin(medium) ///
			note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort. Adjusted probabilities" "for each outcome are stacked.", size(vsmall)) ///
			graphregion(fcolor(white)) legend(position(3))) ytitle("Adjusted Probability") over(race_level, label(angle(45))) stack ylabel(0(0.2)1) legend(order(1 "Completion First" 2 "Transfer First") rows(2) symxsize(2) size(small) width(35))  /// 
			bar(1, fcolor("51 34 136") lcolor(black)) bar(2, fcolor("68 170 153") lcolor(black))		
	graph export "${saved_graphs}/7_race_1.png", replace		
	frame change default
	frame drop working
	
	* Race/ethnicity margins by gender	
	margins pathway, at(race = (1(1)5) male = (0 1)) predict(outcome(1))	
	marginsplot, graphdimension(pathway) bydimension(male) xdimension(race) noci byopts(title("") l1title("") b1title("") graphregion(fcolor(white)) imargin(vsmall)) recast(bar) plotopts(ylabel(0(0.2)1) xlabel(,angle(45)) ///
				 plotregion(margin(zero))) plotdimension(race) ///
				 plot1opts(fcolor("51 34 136") lcolor("51 34 136")) ///
				 plot2opts(fcolor("68 170 153") lcolor("68 170 153")) ///
				 plot3opts(fcolor("136 34 85") lcolor("136 34 85")) ///
				 plot4opts(fcolor("136 204 238") lcolor("136 204 238")) ///
				 plot5opts(fcolor("204 102 119") lcolor("204 102 119"))	///			 
				 name(g7_a, replace)
	margins pathway, at(race = (1(1)5) male = (0 1)) predict(outcome(2))
	marginsplot, graphdimension(pathway) bydimension(male) xdimension(race) noci byopts(title("") l1title("") b1title("") graphregion(fcolor(white)) imargin(vsmall)) recast(bar) plotopts(ylabel(0(0.2)1) xlabel(,angle(45)) ///
				 plotregion(margin(zero))) plotdimension(race) ///
				 plot1opts(fcolor("51 34 136") lcolor("51 34 136")) ///
				 plot2opts(fcolor("68 170 153") lcolor("68 170 153")) ///
				 plot3opts(fcolor("136 34 85") lcolor("136 34 85")) ///
				 plot4opts(fcolor("136 204 238") lcolor("136 204 238")) ///
				 plot5opts(fcolor("204 102 119") lcolor("204 102 119"))	///					 
				 name(g7_b, replace)
	levelsof entry_pathway, local(pathways)
	local named_graphs
	forvalues i = 1/`: word count `pathways'' {
		local named_graphs `named_graphs' g7_a`i'
	}
	forvalues i = 1/`: word count `pathways'' {
		local named_graphs `named_graphs' g7_b`i'
	}
	grc1leg2 `named_graphs', title("Adjusted Probability of First Completion/Transfer" "by Gender and Race/Ethnicity") l2title("Adjusted Probability") ///
			 l1title("First Transfer                         First Completion", size(small)) ///   
			 graphregion(fcolor(white)) rows(2) lrows(5) position(3) symxsize(small) labsize(small) xsize(7) /// 
			 note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall)) // the l1title() approach used here is admittedly a little informal, but it is a useful approach given how we needed to set up this graph
	graph export "${saved_graphs}/7_race_2.png", replace
	
	* Race/ethnicity margins by mother level of education
	margins pathway, at(race = (1(1)5) motheredlevel = (1(1)3)) predict(outcome(1))
	marginsplot, graphdimension(pathway) bydimension(motheredlevel) xdimension(race) noci recast(bar) byopts(title("") l1title("") b1title("") rows(1) graphregion(fcolor(white)) imargin(small)) ///
				 plotopts(ylabel(0(0.2)1) xlabel(,angle(45)) plotregion(margin(zero))) plotdimension(race) ///
				 plot1opts(fcolor("51 34 136") lcolor("51 34 136")) ///
				 plot2opts(fcolor("68 170 153") lcolor("68 170 153")) ///
				 plot3opts(fcolor("136 34 85") lcolor("136 34 85")) ///
				 plot4opts(fcolor("136 204 238") lcolor("136 204 238")) ///
				 plot5opts(fcolor("204 102 119") lcolor("204 102 119"))	///					 
				 name(g7_a, replace)
	margins pathway, at(race = (1(1)5) motheredlevel = (1(1)3)) predict(outcome(2))
	marginsplot, graphdimension(pathway) bydimension(motheredlevel) xdimension(race) noci recast(bar) byopts(title("") l1title("") b1title("") rows(1) graphregion(fcolor(white)) imargin(small)) ///
				 plotopts(ylabel(0(0.2)1) xlabel(,angle(45)) plotregion(margin(zero))) plotdimension(race) ///
				 plot1opts(fcolor("51 34 136") lcolor("51 34 136")) ///
				 plot2opts(fcolor("68 170 153") lcolor("68 170 153")) ///
				 plot3opts(fcolor("136 34 85") lcolor("136 34 85")) ///
				 plot4opts(fcolor("136 204 238") lcolor("136 204 238")) ///
				 plot5opts(fcolor("204 102 119") lcolor("204 102 119"))	///					 
				 name(g7_b, replace)
	levelsof entry_pathway, local(pathways)
	local named_graphs
	forvalues i = 1/`: word count `pathways'' {
		local named_graphs `named_graphs' g7_a`i'
	}
	forvalues i = 1/`: word count `pathways'' {
		local named_graphs `named_graphs' g7_b`i'
	}	
	grc1leg2 `named_graphs', title("Adjusted Probability of First Completion/Transfer" "by Mother's Education Level and Race/Ethnicity") l2title("Adjusted Probability") ///
							 l1title("First Transfer                         First Completion", size(small)) ///
							 graphregion(fcolor(white)) rows(2) lrows(5) position(3) symxsize(small) labsize(small) xsize(9) ///
							 note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall)) // the l1title() approach used here is admittedly a little informal, but it is a useful approach given how we needed to set up this graph
	graph export "${saved_graphs}/7_race_3.png", replace
		
	}
	
	
	* Charts: mother's ed.
	{
	
	* Main mother level of education margins
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
	label define edlevel_vals 1 "Middle Sch" 2 "High Sch" 3 "Any College" 4 "NA" // unfortunately these value labels must be re-copied from above; value labels created in one frame are not accessible in another
	label values mothered_level edlevel_vals
	gen pathway_level = ustrregexs(1) if ustrregexm(estimate_name, "_at#([0-9]+)")
	destring pathway_level, replace
	label define pathway_vals 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway" // please modify appropriately; unfortunately, value labels do not copy automatically into new frames	
	label values pathway_level pathway_vals
	drop estimate_name
	order mothered_level pathway_level outcome_level	
	reshape wide prediction_, i(mothered_level pathway_level) j(outcome_level)
	graph bar (asis) prediction_1 prediction_2, by(pathway_level, title("Adjusted Probability of First Completion/Transfer" "by Mother's Education Level") b1title("Mother's Eduation Level") imargin(medium) ///
			note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort. Adjusted probabilities" "for each outcome are stacked.", size(vsmall)) ///
			graphregion(fcolor(white))) ytitle("Adjusted Probability") over(mothered_level, relabel(1 `" "Middle" "Sch" "' 2 `" "High" "Sch" "' 3 `" "Any" "College" "') label(labsize(small))) stack ylabel(0(0.2)1) ///
			legend(order(1 "Completion First" 2 "Transfer First")) bar(1, fcolor("51 34 136") lcolor(black)) bar(2, fcolor("68 170 153") lcolor(black))
	graph export "${saved_graphs}/8_mothered_1.png", replace	
	frame change default
	frame drop working
	
	* Mother level of education margins by gender
	margins pathway, at(male = (0 1) motheredlevel = (1(1)3)) predict(outcome(1))
	marginsplot, graphdimension(pathway) bydimension(male) xdimension(motheredlevel) noci recast(bar) byopts(title("") l1title("") b1title("") graphregion(fcolor(white)) imargin(small)) ///
				 plotopts(ylabel(0(0.2)1) xlabel(,angle(45)) plotregion(margin(zero))) plotdimension(motheredlevel) ///
				 plot1opts(fcolor("51 34 136") lcolor("51 34 136")) ///
				 plot2opts(fcolor("68 170 153") lcolor("68 170 153")) ///
				 plot3opts(fcolor("136 34 85") lcolor("136 34 85")) ///
				 name(g8_a, replace)
	margins pathway, at(male = (0 1) motheredlevel = (1(1)3)) predict(outcome(2))
	marginsplot, graphdimension(pathway) bydimension(male) xdimension(motheredlevel) noci recast(bar) byopts(title("") l1title("") b1title("") graphregion(fcolor(white)) imargin(small)) ///
				 plotopts(ylabel(0(0.2)1) xlabel(,angle(45)) plotregion(margin(zero))) plotdimension(motheredlevel) ///
				 plot1opts(fcolor("51 34 136") lcolor("51 34 136")) ///
				 plot2opts(fcolor("68 170 153") lcolor("68 170 153")) ///
				 plot3opts(fcolor("136 34 85") lcolor("136 34 85")) ///				 
				 name(g8_b, replace)
	levelsof entry_pathway, local(pathways)
	local named_graphs
	forvalues i = 1/`: word count `pathways'' {
		local named_graphs `named_graphs' g8_a`i'
	}
	forvalues i = 1/`: word count `pathways'' {
		local named_graphs `named_graphs' g8_b`i'
	}
	grc1leg2 `named_graphs', title("Adjusted Probability of First Completion/Transfer" "by Gender and Mother's Education Level") l2title("Adjusted Probability") ///
							 l1title("First Transfer                         First Completion", size(small)) ///
							 graphregion(fcolor(white)) rows(2) lrows(3) position(3) symxsize(small) labsize(small) xsize(7) ///
							 note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall)) // the l1title() approach used here is admittedly a little informal, but it is a useful approach given how we needed to set up this graph	
	graph export "${saved_graphs}/8_mothered_2.png", replace
	
	}
	
	
	* Charts: gender margins
	{
	
	* Main gender margins
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
	label define male 1 "Female" 2 "Male" // unfortunately these value labels must be re-copied from above; value labels created in one frame are not accessible in another
	label values male_level male
	gen pathway_level = ustrregexs(1) if ustrregexm(estimate_name, "_at#([0-9]+)")
	destring pathway_level, replace
	label define pathway_vals 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway" // please modify appropriately; unfortunately, value labels do not copy automatically into new frames	
	label values pathway_level pathway_vals
	drop estimate_name
	order male_level pathway_level outcome_level	
	reshape wide prediction_, i(male_level pathway_level) j(outcome_level) 	
	graph bar (asis) prediction_1 prediction_2, by(pathway_level, title("Adjusted Probability of First Completion/Transfer" "by Gender") b1title("Gender") imargin(medium) ///
			note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort. Adjusted probabilities" "for each outcome are stacked.", size(vsmall)) ///
			graphregion(fcolor(white))) ytitle("Adjusted Probability") over(male_level) stack ylabel(0(0.2)1) legend(label(1 "Completion First") label(2 "Transfer First")) xsize(5.5) bar(1, fcolor("51 34 136") lcolor(black)) ///
			bar(2, fcolor("68 170 153") lcolor(black))			
	graph export "${saved_graphs}/9_gender.png", replace
	frame change default
	frame drop working		
	
	}
	
	
	
	
	
	