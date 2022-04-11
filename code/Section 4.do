/*******************************************************************************
	Section 4 Code
*******************************************************************************/

	/*****************************************
	 Comments about this code
	*****************************************/
	
	// Data for this analysis code should be set up according to the accompanying data specification guide.

	// Code below for this analyis should be modified according to your needs. In some places, comments explicitly prompt
	// you to appropriately modify a minimum number of commands for your institution's data, or else the output may not be
	// correct or useful. And of course feel free to modify any other commands, too.	
	
	// Stata version 16 or higher is required to run the code below because of the frames commands. Earliear versions of
	// Stata do not allow for different frames. If you do not have access to version 16, you can modify the appropriate 
	// commands to use tempfiles instead and achieve a similar result.				
		
		
	/***************************************
	 Set up and setting filepaths
	***************************************/
	
	version 16.1
	clear all
	macro drop all		
	
	global path_to_data					"some_directory/perhaps_another_directory/maybe_even_one_more_directory/your_data.csv" // set path to your saved .csv data file matching spec document
	global saved_graphs					"some_directory/perhaps_another_directory/finally_the_directory_where_you_would_like_your_graphs_saved" // set path for where you'd like graphs saved on your computer			
		
		
	/***************************************
	 Load data set up according to spec
	***************************************/

	import delimited "${path_to_data}", clear		
		
		
	/********************************************
	 Generate and label an entry pathway
	********************************************/	
	
	* Generate an entry pathway code for each student
	bys studentid (cohorttermindex): gen entry_pathway = pathway[1]
	label var entry_pathway "pathway code associated with a student at entry"	
	
	* Label pathway
	label define pathway_entry_vals 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway" // this is just a placeholder example; please modify with the full names associated with each entry pathway code at your institution
	label values pathway pathway_entry_vals		
	
		
	/***************************************************************
	 A few additional calculations to complement initial data file
	***************************************************************/	
		
	* Generate cumulative college-level credits earned by term
	bys studentid (cohorttermindex): gen cumcollegecreditsearned = sum(collegecreditsearned)
	label var cumcollegecreditsearned "cumulative college-level credits earned by a student term to term"

	* Generate cumulative credits earned by term
	bys studentid (cohorttermindex): gen cumcreditsearned = sum(creditsearned)
	label var cumcreditsearned "cumulative credits earned by a student term to term, whether college-level or developmental credits"
	
	* Generate cumulative college-level credits attempted by term
	bys studentid (cohorttermindex): gen cumcollegecreditsattempted = sum(collegecreditsattempted)
	label var cumcollegecreditsattempted "cumulative college-level credits attempted by a student term to term"
	
	* Determine number of terms included in data for each student
	sum cohorttermindex
	global max_term = r(max)	
	
	* Generate ideal credits earned and cumulative credits earned amounts
	gen idealcreditsearned = 0
	label var idealcreditsearned "ideal number of credits a student would earn each term"
	replace idealcreditsearned = 15 if inrange(cohorttermindex, 1, 4)
	bys studentid (cohorttermindex): gen cumidealcreditsearned = sum(idealcreditsearned)
	label var cumidealcreditsearned "cumulative ideal number of credits a student would have earned each term"
	
	* Code in an indicator for a terminating event (first completion or first transfer)
	gen terminating = inlist(pathway, 100, 101)	
	label var terminating "indicator for a terminating event: first completion or transfer"
	

	
	
	/*******************************************
	 Create cumulative credit charts
	*******************************************/

	* Avg. college-level cumulative credits attempted vs. earned
	preserve
	
	collapse (mean) cumcollegecreditsearned cumcollegecreditsattempted cumidealcreditsearned, by(entry_pathway cohorttermindex)
	
	twoway (line cumcollegecreditsearned cohorttermindex, lcolor("51 34 136")) /// // colors specifically chosen to be colorblind accessible
		   (line cumcollegecreditsattempted cohorttermindex, lcolor("68 170 153") lpattern(dash)) ///
		   (line cumidealcreditsearned cohorttermindex, lcolor("136 34 85")), ///
		   by(entry_pathway, graphregion(fcolor(white)) imargin(medium) title("Average Cumulative College-Level Credits" "Attempted vs. Earned") note("Note: College-level credit counts exclude developmental coursework.", size(vsmall))) ///
		   legend(label(1 "Earned") label(2 "Attempted") label(3 "On-Track")) yline(0, lcolor(black)) plotregion(margin(zero)) ytitle("Avg. Cumulative College-Level Credits") ///
		   xtitle("Cohort Term") ylabel(0(15)60) xlabel(1(1)${max_term})
	
	graph export "${saved_graphs}/1_avg_cum_college-level_credits_attempted_vs_earned.png", replace
	
	restore	
	
	
	* Avg. college-level cumulative credits earned by early momentum
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
	
	twoway (line cumcollegecreditsearned cohorttermindex if bin == 1, lcolor("51 34 136")) ///
	       (line cumcollegecreditsearned cohorttermindex if bin == 2, lcolor("68 170 153")) ///
		   (line cumcollegecreditsearned cohorttermindex if bin == 3, lcolor("136 34 85")), ///
		   by(entry_pathway, title("Average College-Level Credit Accummulation" "by Entry Term College-Level Credits Earned") graphregion(fcolor(white)) note("Note: College-level credit counts exclude developmental coursework.", size(vsmall)) ///
		   imargin(medium)) xtitle("Cohort Term") ytitle("Avg. College-Level Credit Accumulation") ///
		   legend(title("Entry Term College-Level Credits Earned Percentile", size(small)) label(1 "< 25th") label(2 "25th - 75th") label(3 "> 75th")) ///
		   xlabel(1(1)${max_term}) yline(0, lcolor(black)) plotregion(margin(zero))
		   
	graph export "${saved_graphs}/2_avg_cum_college-level_credits_by_early_momentum.png", replace
	
	restore
	
	
	/******************************************************
	 Create completer/transfer rate charts
	******************************************************/		
	
	* Data set up for completion/transfer rates by college-level credits earned
	cap frame drop complete_trans_entry_college_credits
	frame copy default complete_trans_college_credits
	frame change complete_trans_college_credits
	drop if cumcollegecreditsearned > 21 & cohorttermindex == 1 // exclude students who earned more than 21 college credits in their first term as outliers; though this threshold is somewhat arbitrary
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
	
	* Data set up for completion/transfer rates by credits earned in first term, whether credits were college-level or not
	cap frame drop complete_trans_credits
	frame copy default complete_trans_credits
	frame change complete_trans_credits
	drop if cumcreditsearned > 21 & cohorttermindex == 1 // exclude students who earned more than 21 college credits in their first term as outliers; though this threshold is somewhat arbitrary
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

	* Combine data sets for completion/transfer rates by both credit types in first term: any credit and college-level credit
	append using `college_credits'
	
	* Completion/transfer rates by pathway and first-term credit-type bins
	twoway (line any_terminating credit_bin_in_first_term if credit_type == "any", lcolor("51 34 136")) ///
		   (line any_terminating credit_bin_in_first_term if credit_type == "college-level", lcolor("68 170 153")), ///
		   by(entry_pathway, graphregion(fcolor(white)) title("First Completion/Transfer Rates by Pathway" "and Entry Term Credits Earned") imargin(medium) ///
		   note("Note: Credits earned in the first term are grouped into three-credit intervals, labeled by the maximum of the interval. Developmental" "credits are included in the Any Credits sum, but not the College-Level sum.", size(vsmall))) ///
		   xtitle("Credits Earned in First Term") ytitle("3 Yr. First Completion/Transfer Rate") ylabel(0(0.2)1.05) xlabel(3(3)21) plotregion(margin(zero)) yline(0, lcolor(black)) ///
		   legend(label(1 "Any Credits") label(2 "College-Level Credits"))
		   
	graph export "${saved_graphs}/3_student_status_at_6_terms_by_entry_term_credits_earned.png", replace
	
