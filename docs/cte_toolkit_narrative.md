<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="format-detection" content="telephone=no">
<title>docs.md</title>
<link href="https://maxcdn.bootstrapcdn.com/bootswatch/3.3.7/simplex/bootstrap.min.css" rel="stylesheet" integrity="sha384-C0X5qw1DlkeV0RDunhmi4cUBUkPDTvUqzElcNWm1NI2T4k8tKMZ+wRPQOhZfSJ9N" crossorigin="anonymous">
<style>
img { max-width: 100%; height: auto; }
pre { word-break: normal; word-wrap: normal; }
code { color: inherit; background-color: #F5F5F5; }
pre code, pre samp { white-space: pre; }
</style>
<style>
.stcmd .stcmt { font-style: italic; opacity: 0.5; }
.stoom, .stcnp { font-style: italic; }
@media screen { .stcnp { display: none; }}
</style>
</head>
<body>
<style>
.affix {
   position: static;
 }
 @media (min-width: 992px) {
    #toc.affix {
		top: inherit;
		width: inherit;
		position: fixed;
    }
}

a {
  color: #A51C30;
}

a:focus, a:hover {
  color: #6D121F;
}

/* Fix for anchor link scroll location */
h1:before, h2:before, h3:before, h4:before {
  display: block;
  content: " ";
  margin-top: -124px;
  height: 124px;
  visibility: hidden;
}

#logo{
	 background-color: #A51C30;
}
body {
	padding-top: 115px;
	overflow: visible;
}
html {
	overflow: visible;
}
</style>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-129904036-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
 
  gtag('config', 'UA-129904036-1');
</script>
<div class="navbar navbar-default navbar-fixed-top" id="logo">
 <div class="container">
<img src="https://opensdp.github.io/assets/images/OpenSDP-Banner_crimson.jpg" style="display: block; margin: 0 auto; height: 115px;">
</div>
</div>
<div class="container">
<div class="row">
<nav class="col-xs-12 col-sm-12 col-md-3" style = "padding-right:15px;">
<div class="nav nav-stacked affix" id="toc" style = "overflow-wrap:break-word;">
<div class="well" style = "padding-right:10px; overflow-wrap:break-word;">
<ul>
<li><a href="#h-1">Understanding patterns of success among postsecondary CTE students: A diagnostic for institutional and system analysts </a>
<ul>
<li><a href="#h-1-1">Introduction</a>
<ul>
<li><a href="#h-1-1-1">Background and Context</a>
</li>
<li><a href="#h-1-1-2">CTE Diagnostic Overview</a>
</li>
<li><a href="#h-1-1-3">How to use the Diagnostic most effectively</a>
</li>
</ul>
</li>
<li><a href="#h-1-2">Section 0: Getting Started</a>
<ul>
<li><a href="#h-1-2-1">Example Visualization 0.1: What credentials do students intend to earn when entering a given pathway? </a>
</li>
</ul>
</li>
<li><a href="#h-1-3">Section 1: Completion</a>
<ul>
<li><a href="#h-1-3-1">Questions</a>
</li>
<li><a href="#h-1-3-2">Goal/Purpose</a>
</li>
<li><a href="#h-1-3-3">Reading for Context</a>
</li>
<li><a href="#h-1-3-4">Key Terms</a>
</li>
<li><a href="#h-1-3-5">Example Visualization 1.1: What is the likelihood a student in a given pathway will experience a successful outcome? </a>
</li>
<li><a href="#h-1-3-6">Example Visualization 1.2: What is the likelihood a student in a given pathway will experience a successful outcome, after controlling for their background characteristics? </a>
</li>
<li><a href="#h-1-3-7">Example Visualization 1.3: What are students' enrollment decisions and success outcomes over time? </a>
</li>
<li><a href="#h-1-3-8">Example Visualization 1.4: How does the likelihood a student in a given pathway will experience a successful outcome vary across background characteristics? </a>
</li>
<li><a href="#h-1-3-9">Reflections</a>
</li>
</ul>
</li>
<li><a href="#h-1-4">Section 2: Mapping Student Progression</a>
<ul>
<li><a href="#h-1-4-1">Questions</a>
</li>
<li><a href="#h-1-4-2">Goal/Purpose</a>
</li>
<li><a href="#h-1-4-3">Reading for Context</a>
</li>
<li><a href="#h-1-4-4">Key Terms</a>
</li>
<li><a href="#h-1-4-5">Example Visualization 2.1: How do students move between pathways and towards success over time?</a>
</li>
<li><a href="#h-1-4-6">Reflections and Limitations</a>
</li>
</ul>
</li>
<li><a href="#h-1-5">Section 3: Gatekeeper Courses</a>
<ul>
<li><a href="#h-1-5-1">Questions</a>
</li>
<li><a href="#h-1-5-2">Goal/Purpose</a>
</li>
<li><a href="#h-1-5-3">Reading for Context</a>
</li>
<li><a href="#h-1-5-4">Key Terms</a>
</li>
<li><a href="#h-1-5-5">Example Visualization 3.1: Which courses represent the biggest impediments to success? </a>
</li>
<li><a href="#h-1-5-6">Reflections and Limitations</a>
</li>
</ul>
</li>
<li><a href="#h-1-6">Section 4: Credit Accumulation</a>
<ul>
<li><a href="#h-1-6-1">Questions</a>
</li>
<li><a href="#h-1-6-2">Goal/Purpose</a>
</li>
<li><a href="#h-1-6-3">Reading for Context</a>
</li>
<li><a href="#h-1-6-4">Key Terms</a>
</li>
<li><a href="#h-1-6-5">Example Visualization 4.1: On average, are students attempting and earning credits at a pace necessary to complete a credential in a reasonable timeframe?</a>
</li>
<li><a href="#h-1-6-6">Example Visualization 4.2: How do students' trajectories of college-level credit accumulation vary by their initial college-level credit accumulation?</a>
</li>
<li><a href="#h-1-6-7">Example Visualization 4.3: How does students' success in their first semester predict their longer-term success?</a>
</li>
<li><a href="#h-1-6-8">Reflections and Limitations</a>
</li>
</ul>
</li>
<li><a href="#h-1-7">References</a>
</li>
</ul>
</li>
</ul>
</div>
</div>
</div>
<div class="col-xs-12 col-sm-12 col-md-8 offset-md-1 pull-right">

<h1 id="h-1">Understanding patterns of success among postsecondary CTE students: A diagnostic for institutional and system analysts </h1>
#### *Stata Version*

Prepared by: *Chris Avery, Jon Fullerton, Brian Johnson, Adrienne Murphy, Alyssa Reinhart, and Elise Swanson

*Authors listed alphabetically. The authors would also like to thank members of our Advisory Board- Joel McKelvey, Sue Mukherjee, Christopher Leake, and Jessica Cunningham, as well as Miriam Greenberg and the SDP CTE Fellows for their feedback and guidance throughout the development of the diagnostic. 

<h2 id="h-1-1">Introduction</h2>
<h3 id="h-1-1-1">Background and Context</h3>

Institutions are increasingly offering Career and Technical Education (CTE) credentials aimed at helping students succeed in the workforce. The number of sub-baccalaureate degrees awarded increased 70 percent from 2001-02 to 2014-15 and the number is projected to continue to grow over the next 15 years (Husser & Bailey, 2018). Further, 74 percent of students awarded sub-baccalaureate credentials earned them in occupational, rather than academic, programs (Hudson, 2018), underscoring the important role CTE is playing in a changing postsecondary landscape.

CTE programs tend to serve a more diverse population than other programs. Students are older, more female, and more economically disadvantaged than other postsecondary students (NCES, 2018). While the majority of CTE students are White (54 percent), the percentage of Black and Hispanic students is larger in sub-baccalaureate occupational programs than in sub-baccalaureate academic or bachelor's degree programs (NCES, 2018). 

Given that postsecondary CTE programs are increasingly serving students who have not historically been served by higher education, it is especially important to know more about the outcomes of students participating in these programs. Limited research on postsecondary CTE participation shows mixed results (and significant variation by subgroup and study area) in long-term earnings and employment outcomes (Hollenbeck & Huang, 2003; Jenkins, Zeidenberg & Kienzl, 2009; Bahr, 2016; Bettinger & Soliz, 2016; Anderson et al. 2017), as well as degree and credential attainment (Jenkins, Zeidenberg & Kienzl, 2009; Xu & Trimble, 2016; Kurlaender, Stevens & Gross, 2015; Anderson et al. 2017). However, these findings are general and provide little guidance to leaders of CTE institutions about the challenges facing their specific students and possible actions that could improve their students' outcomes. Institutional data and research capacity to answer institution-specific strategic questions about CTE programs is needed.

<h3 id="h-1-1-2">CTE Diagnostic Overview</h3>

This Diagnostic is intended to provide analyses that will help leaders at community and technical colleges develop and pursue strategic inquiries into patterns of student success. This document's primary audience is analysts looking to provide actionable information to institutional leaders. While we offer proposed questions, visualizations, and variable definitions throughout the Diagnostic, it is meant to be a flexible framework that supports a careful examination of factors contributing to students' success outcomes. In other words, you should tailor the analyses, operationalizations, and analyses to fit your needs and context. 

This Diagnostic is structured around four questions that are critical to answer for institutions seeking to improve their students' success.  

- Are students more likely to complete some pathways than others?  Are pathways equitably supporting students with different levels of academic preparation and students of different demographic characteristics to successful outcomes?   
- Are students dropping or transferring out of some pathways more than others?  Where do they go?  
- Are there some required or "gateway" courses that are getting in the way of completion for some pathways?
- What credit accumulation patterns set students up for longer-term success?  How many students are following these patterns?  

We recommend that all analysts engaging with this Diagnostic compile the summary statistics described in Section 0 (Getting Started) and outcomes information described in Section 1 (Completion) to get a sense of basic patterns of access and success at your campus. The remaining three sections each probe a different potential root cause for student success patterns. You may choose to complete all three sections or choose those that seem most relevant for your institution or context. 

For each section, this Diagnostic provides the following:

- A framework for exploration – background and context, including additional research, guiding questions, and information for interpretation and next steps
- Example visualizations – chart mock-ups to show how the results of these analyses could be communicated
- Analysis summaries – details on the steps taken to conduct the analyses. The analysis summaries provide enough detail for analysts to recreate the analyses outlined in this Diagnostic for your institution, regardless of statistical software (additional detail provided in the Technical Companion)
- Data specifications – data sources, elements, and structures needed to complete these analyses (provided in the Technical Companion)
- Code files – Stata .do files for use (available on the OpenSDP Github)

While we do offer some context for the importance of each question and potential implications of results, you will need to understand the results in the context of your own institution to generate action steps from these analyses. We recommend connecting with stakeholders at your institution to decide which pathways to compare and to discuss and interpret results. 

<h3 id="h-1-1-3">How to use the Diagnostic most effectively</h3>

This Diagnostic is designed to be a flexible framework for examining how students are progressing through various pathways and to begin to probe potential root causes of student progress and success rates. The results of these analyses are designed to generate more questions, which will require further inquiry. For example, you may notice that success rates in certain pathways are lower than desired and that there are gatekeeper courses that appear to impede students' progress. You can then work with institutional leaders and faculty to brainstorm potential actions to get more students through these courses, such as hiring more tutors or offering support courses. These interventions can then be evaluated for their effectiveness when implemented on your campus. Approaching this Diagnostic as a resource to spark conversations and questioning around student success outcomes will allow you to focus on the issues most relevant to your context and to determine next steps to support student success. To reinforce this structure, we have labeled each of the analyses with the specific question they help answer. By working through these questions, you can determine what challenges your institution faces, and potential root causes you could address.

<h2 id="h-1-2">Section 0: Getting Started</h2>

As this Diagnostic is designed to explore patterns of student success and their possible determinants, an important first step is to either review or pull together some foundational analyses that examine the characteristics of students enrolled in different pathways. Before engaging with the analyses, you should first decide how to define key variables so that the analyses are most useful for your local context. The first definition you need to determine is that of "pathway". We use the term "pathway" flexibly throughout this document to refer broadly to a student's course of study, but this could be operationalized as a certificate program, major, meta-major, CIP code, or any other grouping of interest. 
Specifically, we recommend pulling the following information for each pathway of interest:
- Average high school GPA of students
- Share of male and female students (or a full breakdown by gender if you can disaggregate beyond traditional binary values)
- Share of students in each racial/ethnic group recorded in your administrative data
- Share of students by parent or guardians' highest level of education (e.g.,  less than a high school diploma or GED, a high school diploma or GED, completed any college, BA or higher)
- Share of students eligible for a Pell grant
- Share of students in a given pathway pursuing each of the credential levels offered by that pathway (for example, associate degree, diploma, and certificate)

Compiling these descriptive statistics allows you to see which students are enrolling in different pathways. These descriptive statistics may be presented in a single table, as a series of charts, or some combination of charts and tables. These data points are helpful to contextualize differences in completion rates or other outcomes across pathways and may help your institution develop interventions and supports that are responsive to students' identities and needs. We also recommend comparing the characteristics of students enrolled full and part time within pathways to better understand which students are choosing which enrollment option. As we recommend conducting the analyses outlined in this Diagnostic separately for full and part time students, these descriptive statistics also provide context for understanding which students' experiences and outcomes are being portrayed by each set of analyses.

Figure 1.0 offers an example of how to present students' credential intentions across pathways, a key consideration when deciding which pathways to compare in your analyses. 

<h3 id="h-1-2-1">Example Visualization 0.1: What credentials do students intend to earn when entering a given pathway? </h3>

<div class="navbar navbar-default navbar-fixed-top" id="logo">
 <div class="container">
<img src="https://github.com/rachworsham/open_sdp_cte_toolkit/blob/806f53825f42a6c63e181a1e7e9f0c455a9ddb88/docs/narrative_img/narrative.0.1.png">
</div>
</div>

#### Understanding the Chart

This chart shows the share of students in each pathway pursuing different credential types. This varies across program. For example, half of all students entering the Health pathway intend to earn an associate degree, while the most comm degree intention among students in Engineering Technology is a diploma. Understanding what credentials student intend to earn helps us anticipate how long it will likely take students to complete and highlights which pathways may be best positioned to share lessons/best practices to support students with each other. 

In this chart, and the charts that follow, the outcome is often a probability or a proportion. Because these values are always a fraction, they naturally exist on a scale of 0-1. These values can also be understood as percentage points if they are multiplied by 100. 

<h2 id="h-1-3">Section 1: Completion</h2>
<h3 id="h-1-3-1">Questions</h3>

Do different pathways have different completion rates? Are there differences in completion rates across pathways for students who enter with similar background characteristics? 

<h3 id="h-1-3-2">Goal/Purpose</h3>

In this section, you will compare student outcomes across pathways. We focus on student transfer to another institution or completion of a credential, but your definition of "successful outcomes" might differ depending on your institution's context and questions. Looking at student outcomes allows you to engage with the broader question of whether the pathways at your institution are accomplishing their goals. In other words, are students being adequately supported to succeed in their chosen pathway? 

By comparing outcomes across pathways, you can also see whether there are pathways that are further along in meeting their student success goals than others and conduct follow-up studies to understand what practices those pathways are leveraging to support students. When looking at differences in outcomes across pathways, keep in mind the differences in student characteristics across pathways before making judgments about pathway success. Each program is enrolling a unique population of students, and, therefore, one might expect different outcomes. However, by examining patterns across pathways, you can have better-informed and deeper conversations with programs about what might be working and what could be strengthened. 

The analyses presented in this section illustrate the extent to which students are progressing through a given pathway. These analyses allow one to compare student outcomes across pathways, but we leave it to your judgment to determine which pathways are relevant to compare. For example, you may not want to directly compare programs that typically lead to an associate degree with programs that typically lead to a certificate or diploma. 

The results of these analyses can inform further discussions at your institution or system about which programs are seeing their students succeed and what practices or structures they may be leveraging that could support students in other pathways. 

<h3 id="h-1-3-3">Reading for Context</h3>

- Completing College Nation and State Reports https://nscresearchcenter.org/completing-college/
- Bailey, T. R., Jaggars, S. S., & Jenkins, D. (2015). Redesigning America's community colleges: A clearer path to student success. Harvard University Press. https://www.hup.harvard.edu/catalog.php?isbn=9780674368286
- Jacob (2018): Building Knowledge to Improve Degree Completion in Community Colleges. https://www.brookings.edu/research/building-knowledge-to-improve-degree-completion-in-community-colleges/

<h3 id="h-1-3-4">Key Terms</h3>

- Credential – Associate degree, certificate, diploma, or other qualification that signifies culmination of a program of study
- Completion – Attainment of a credential of any form
- Pathway – classification of area of study most relevant to the institution, such as Classification of Instructional Programs (CIP) code or meta-major

<h3 id="h-1-3-5">Example Visualization 1.1: What is the likelihood a student in a given pathway will experience a successful outcome? </h3>

Our first analysis shows whether students' likelihood of completion or transfer varies depending on what pathway they pursue. We focus on the first outcome that students achieve to avoid double-counting students who attain more than one milestone (e.g., transfer and subsequent completion). Critically, this is a descriptive analysis that does not account for student background characteristics, program context, or other factors that influence student outcomes. Because these results take no account of which students enroll in which program, they should not be interpreted to mean that one program is outperforming another, but rather should encourage deeper questioning and discussion across pathways. 

<div class="navbar navbar-default navbar-fixed-top" id="logo">
 <div class="container">
<img src="https://github.com/rachworsham/open_sdp_cte_toolkit/blob/806f53825f42a6c63e181a1e7e9f0c455a9ddb88/docs/narrative_img/narrative.1.1..png">
</div>
</div>
<pre id="stlog-1" class="stcmd"><code>
<span class="stcmt">/*****************************************</span>
<span class="stcmt"> Comments about this code</span>
<span class="stcmt">*****************************************</span>
<span class="stcmt"></span>
<span class="stcmt">// Data for this analysis code should be set up according to the </span>
<span class="stcmt">   accompanying data specification guide.</span>
<span class="stcmt"></span>
<span class="stcmt">// Code below for this analyis should be modified according to your needs. </span>
<span class="stcmt">   In some places, comments explicitly prompt you to appropriately modify a </span>
<span class="stcmt">   minimum number of commands for your institution's data, or else the </span>
<span class="stcmt">   output may not be correct or useful. And of course feel free to</span>
<span class="stcmt">   modify any other commands, too.</span>
<span class="stcmt"></span>
<span class="stcmt">// Stata version 16 or higher is required to run the code below, </span>
<span class="stcmt">   especially the frames-related commands. Earlier versions of </span>
<span class="stcmt">   Stata can be used if these commands are removed and replaced with </span>
<span class="stcmt">   similar functionality like tempfiles.</span>
<span class="stcmt"></span>
<span class="stcmt">// The code below varies considerably in complexity depending on which </span>
<span class="stcmt">   graph is being created. Stata's marginsplot command does</span>
<span class="stcmt">   not make it easy to create stacked bar graphs, which require </span>
<span class="stcmt">   more explicit, longer commands.</span>
<span class="stcmt"></span>
<span class="stcmt">// If you do not already have the user-written Stata command svmat2 </span>
<span class="stcmt">   installed, please see Stata's website for more guidance on </span>
<span class="stcmt">   how to install this. The appropriate installation approach might</span>
<span class="stcmt">   depend on the environment in which you are using Stata.</span>
<span class="stcmt"></span>
<span class="stcmt">// If you do not alraedy have the user-written Stata command grc1leg2 </span>
<span class="stcmt">   installed, please type "search grc1leg2" in the Stata  console for more </span>
<span class="stcmt">   installation information.</span>
<span class="stcmt"></span>
<span class="stcmt">// Note that this code does not create margins plots for all pairwise </span>
<span class="stcmt">   combinations of covariates in the model. Specifically, no </span>
<span class="stcmt">   plots are created for combinations of two continuous variables. Nor </span>
<span class="stcmt">   are redundant combinations included (e.g. a margins plot </span>
<span class="stcmt">   for race/ethnicity and gender is included once in the race/ethnicity </span>
<span class="stcmt">   graphing section, which appears before the gender graphing section).</span>
<span class="stcmt">	</span>
<span class="stcmt"></span>
<span class="stcmt"></span>
<span class="stcmt">***************************************</span>
<span class="stcmt"> Set up and setting filepaths</span>
<span class="stcmt">***************************************/</span>

version 16.1
clear all
macro drop all		

<span class="stcmt">// set path to your saved .csv data file matching spec document</span>
global path_to_data	<span class="stcmt">///</span>
"some_directory/perhaps_another_directory/maybe_even_one_more_directory/your_data.csv" 

<span class="stcmt">// set path for where you'd like graphs saved on your computer</span>
global saved_graphs <span class="stcmt">///</span>
"some_directory/perhaps_another_directory/finally_the_directory_where_you_would_like_your_graphs_saved" 



<span class="stcmt">/***************************************</span>
<span class="stcmt"> Load data set up according to spec</span>
<span class="stcmt">***************************************/</span>

import delimited "${path_to_data}"


<span class="stcmt">/********************************************</span>
<span class="stcmt"> Label variables as relevant to institution</span>
<span class="stcmt">********************************************/</span>

<span class="stcmt">// set these value labels according to your preferred conventions</span>
<span class="stcmt">* male</span>
label define male_vals 0 "Female" 1 "Male" 
label values male male_vals

<span class="stcmt">* race</span>
label define race_vals 1 "Asian" 2 "Black" 3 "Hispanic" 4 "White" 5 "Other"	
label values race race_vals

<span class="stcmt">* motheredlevel</span>
label define edlevel_vals 1 "Middle Sch" 2 "High Sch" 3 "Any College" 4 "NA"	
label values motheredlevel edlevel_vals

<span class="stcmt">* pathway</span>
label define pathway_entry_vals 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway" 
label values pathway pathway_entry_vals
<span class="stcmt">/*this is just a placeholder example; please modify with the full names </span>
<span class="stcmt">associated with each entry pathway code at your institution */</span>

<span class="stcmt">/******************************************</span>
<span class="stcmt"> Generate additional variables</span>
<span class="stcmt">******************************************/</span>

<span class="stcmt">* Determine number of terms included in data for each student</span>
sum cohorttermindex
global max_term = r(max)		

<span class="stcmt">* Outcome variable at the student level, across terms</span>
gen outcome = 0
replace outcome = 1 if pathway == 100 &amp; cohorttermindex == $max_term
replace outcome = 2 if pathway == 101 &amp; cohorttermindex == $max_term
bys studentid (cohorttermindex): replace outcome = outcome[$max_term]

<span class="stcmt">* Label outcome</span>
label define outcome_vals 0 "None" 1 "Completion" 2 "Transfer"
label values outcome outcome_vals
label var outcome "student outcome after ${max_term} terms"

<span class="stcmt">* Code in an indicator for a terminating event (first completion or first transfer)</span>
gen terminating = inlist(pathway, 100, 101)	
label var terminating "indicator for a terminating event: first completion or transfer"

<span class="stcmt">* Generate an indicator for non-enrollment</span>
gen nonenrolled = pathway == 99
label var nonenrolled "indicator for non-enrollment in a term"	

<span class="stcmt">* Generate an entry pathway code for each student</span>
bys studentid (cohorttermindex): gen entry_pathway = pathway[1]
label var entry_pathway "pathway code associated with a student at entry"	

<span class="stcmt">* Label entry pathways</span>
label values entry_pathway pathway_entry_vals



<span class="stcmt">/**********************************</span>
<span class="stcmt"> Run regressions and plot margins</span>
<span class="stcmt">**********************************/</span>		

<span class="stcmt">* Model: outcomes conditional only on initial pathway choice</span>
mlogit outcome i.pathway if cohorttermindex == 1, robust 
<span class="stcmt">/* note that because each student will have multiple rows in the data </span>
<span class="stcmt">but with covariate values fixed at values observed at entry,</span>
<span class="stcmt">   we only need to run the regression with the first entry for each student*/</span>
	
<span class="stcmt">* Chart: pathway unadjusted margins</span>
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
<span class="stcmt">// please modify appropriately; unfortunately, value labels do not copy automatically into new frames</span>
label define pathway_vals 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway" 
label values pathway_level pathway_vals
graph bar (asis) prediction_1 prediction_2, <span class="stcmt">///</span>
title("Probability of Completion First or Transferring First" "by Pathway") <span class="stcmt">///</span>
ytitle("Probability") b1("Pathway") over(pathway_level) <span class="stcmt">///</span>
stack ylabel(0(0.2)1) graphregion(fcolor(white)) <span class="stcmt">///</span>
legend(label(1 "Completion First") label(2 "Transfer First")) <span class="stcmt">///</span>
xsize(5.5) note("Note: Probabilities for each outcome are stacked.", <span class="stcmt">///</span>
size(vsmall)) bar(1, fcolor("51 34 136") <span class="stcmt">///</span>
lcolor(black)) bar(2, fcolor("68 170 153") lcolor(black)) 
<span class="stcmt">// colors chosen for colorblindness accessibility</span>
graph export "${saved_graphs}/1_main.png", replace
frame change default
frame drop working		
}

</code></pre>

#### Understanding the Chart

This chart shows the probability that a student will have a successful outcome, conditional on their pathway of entry. We see differences across pathway. For example, among students entering the Health pathway, the probability that a student will earn a credential or transfer to another institution is around 50 percent. In contrast, the probability that a student entering Mechanical Repair will complete or transfer is only slightly above 20 percent. 

<h3 id="h-1-3-6">Example Visualization 1.2: What is the likelihood a student in a given pathway will experience a successful outcome, after controlling for their background characteristics? </h3>

The next piece of this analysis looks at differences in the probability that a student will transfer or complete a credential across pathways while accounting for students' background characteristics. This allows us to compare outcomes of students who are observationally the same on a set of variables but who enrolled in different pathways. We include as controls students' gender (measured as a binary male/female), age at enrollment, race/ethnicity (disaggregated to Asian, Black, Latina/o/x, White, and other/unknown), Pell dollars awarded in the first year, high school GPA, and mother's education level (less than high school, high school, college or more). You may want to adjust these covariates depending on what is relevant to your context and available in your data. 

<div class="navbar navbar-default navbar-fixed-top" id="logo">
 <div class="container">
<img src="https://github.com/rachworsham/open_sdp_cte_toolkit/blob/806f53825f42a6c63e181a1e7e9f0c455a9ddb88/docs/narrative_img/narrative.1.2.png">
</div>
</div>
<pre id="stlog-2" class="stcmd"><code>
<span class="stcmt">* Model: outcomes conditional on baseline student traits</span>
# delimit ; 
<span class="stcmt">/*note mi_motheredlevel omitted because missingness is already encoded as </span>
<span class="stcmt">level 4 of motheredlevel so it's excluded from the full model*/</span>
mlogit outcome c.age c.age#i.pathway c.hsgpa i.mi_hsgpa c.hsgpa#i.pathway i.male i.male#i.pathway 
c.pell i.mi_pell c.pell#i.pathway i.motheredlevel i.motheredlevel#i.pathway i.race 
i.race#i.pathway i.pathway i.institutionid i.cohortyear if cohorttermindex == 1, robust;
# delimit cr
<span class="stcmt">/* note that because each student will have multiple rows in the data </span>
<span class="stcmt">but with covariate values fixed at values observed at entry,</span>
<span class="stcmt">   we only need to run the regression with the first entry for each student*/</span>


<span class="stcmt">* Chart: pathway adjusted margins</span>
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
label define pathway_vals 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway" 
<span class="stcmt">// please modify appropriately; unfortunately, value labels do not copy automatically into new frames</span>
label values pathway_level pathway_vals
drop estimate_name
order outcome_level pathway_level	
reshape wide prediction_, i(pathway_level) j(outcome_level) 	
graph bar (asis) prediction_1 prediction_2, <span class="stcmt">///</span>
title("Adjusted Probability of Completion First" "or Transferring First by Pathway") <span class="stcmt">///</span>
ytitle(.  "Adjusted Probability") b1("Pathway") <span class="stcmt">///</span>
over(pathway_level) stack ylabel(0(0.2)1) <span class="stcmt">///</span>
   graphregion(fcolor(white)) legend(label(1 "Completion First") <span class="stcmt">///</span>
label(2 "Transfer First")) xsize(5.5) note <span class="stcmt">///</span>
("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort. Adjusted" "probabilities for each outcome are stacked.", size(vsmall)) <span class="stcmt">///</span>
bar(1, fcolor("51 34 136") lcolor(black)) <span class="stcmt">///</span>
bar(2, fcolor("68 170 153") lcolor(black)) 
graph export "${saved_graphs}/2_main_adjusted.png", replace
frame change default
frame drop working	
}

</code></pre>

#### Understanding the Chart

This chart shows how two students, who are the same on all observed characteristics, have differing probabilities of success based on which CTE pathway they choose to enroll in. Similar to the prior chart, the probability of success for students in the Health pathway is about 50 percent. However, we see changes in the probability of success between the unadjusted and adjusted graphs for other programs, like Engineering Technology and Mech Repair. These results suggest that students in Mech Repair do better than we would expect given their observed characteristics, while those in Engineering Tech have a lower probability of success than we would expect just based on background characteristics. 

<h3 id="h-1-3-7">Example Visualization 1.3: What are students' enrollment decisions and success outcomes over time? </h3>

To go deeper into the question of the extent to which programs are supporting student success, we look at student outcomes over time. We look over term-by-term for students' first three years to see what share of students are still enrolled in college, what share have completed a credential or transferred, and the share of students who are no longer enrolled. This analysis can help your institution identify key moments in students' experience when they may need additional support to stay on track to a successful outcome. 

<div class="navbar navbar-default navbar-fixed-top" id="logo">
 <div class="container">
<img src="https://github.com/rachworsham/open_sdp_cte_toolkit/blob/806f53825f42a6c63e181a1e7e9f0c455a9ddb88/docs/narrative_img/narrative.1.3.png">
</div>
</div>
<pre id="stlog-3" class="stcmd"><code>
<span class="stcmt">* Chart: waterfall view of completion/transfer, unenrollment, and continued enrollment over time</span>
{
cap frame drop working
frame create working double(pathway term denominator terminated nonenrolled stillenrolled)
foreach p in $pathways {
    di _newline(2)
	distinct studentid if entry_pathway == `p'
	local denominator = r(ndistinct)
	forvalues i = 1/$max_term {
		preserve
			keep if entry_pathway == `p' &amp; cohorttermindex &lt;= `i'
			bys studentid: egen any_terminating = max(terminating)
			keep studentid entry_pathway pathway any_terminating cohorttermindex
			keep if cohorttermindex == `i'
			isid studentid
			count if any_terminating == 1
			local terminated = r(N)
			count if pathway == 99
			local nonenrolled = r(N)
			count if pathway != 99 &amp; any_terminating == 0
			local stillenrolled = r(N)
		restore 
		frame post working (`p') (`i') (`denominator') (`terminated') (`nonenrolled') (`stillenrolled')
	}	
}
frame change working
foreach s in terminated nonenrolled stillenrolled {
	gen pct_`s' = `s'/denominator
}	
label define pathway_vals 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway" 
<span class="stcmt">// please modify appropriately; unfortunately, value labels do not copy automatically into new frames</span>
label values pathway pathway_vals		
gen pct_nonenrolled_neg = -1*pct_nonenrolled <span class="stcmt">// useful for getting this portion of cohort to hang below the x axis</span>
graph bar (asis) pct_stillenrolled pct_terminated pct_nonenrolled_neg, <span class="stcmt">///</span>
over(term) yline(0, lcolor(gray)) <span class="stcmt">///</span>
		   bar(1, fcolor(navy)) bar(2, fcolor(green)) bar(3, <span class="stcmt">///</span>
		   fcolor(cranberry)) stack <span class="stcmt">///</span>
		   by(pathway, title("First Completion/Transfer Rates by Pathway") <span class="stcmt">///</span>
		   b1title("Cohort Term") graphregion(fcolor(white)) legend(position(3)) <span class="stcmt">///</span>
		   note("Note: Each stacked bar represents an entire cohort each term.", <span class="stcmt">///</span>
		   size(vsmall))) legend(cols(1) label(1 "Still Enrolled") <span class="stcmt">///</span>
		   label(2 "Completer/" "Transfer") label(3 "No Longer" "Enrolled") <span class="stcmt">///</span>
		   size(small) symxsize(small) textwidth(18)) ytitle("Proportion of Cohort") <span class="stcmt">///</span>
		   ylabel(-0.5 "0.5" 0 "0" 0.5 "0.5" 1 "1") <span class="stcmt">///</span>
		   bar(1, fcolor("51 34 136") lcolor(black)) <span class="stcmt">///</span>
		   bar(2, fcolor("68 170 153") lcolor(black)) <span class="stcmt">///</span>
		   bar(3, fcolor("136 34 85") lcolor(black))
graph export "${saved_graphs}/3_student_status_over_time.png", replace
frame change default
frame drop working		

}	

</code></pre>

#### Understanding the Chart

In this chart, we see the share of students in a particular pathway who are still enrolled in that pathway, who have completed a credential or transferred, and who are no longer enrolled in higher education in that term. For example, in Health we see that in the sixth term, just under half of all students have completed or transferred and just over half are no longer enrolled. In contrast, in IT Tech we see that in the sixth semester about half of all students are no longer enrolled, a little over a quarter have completed or transferred, and just under a quarter are still enrolled. 

<h3 id="h-1-3-8">Example Visualization 1.4: How does the likelihood a student in a given pathway will experience a successful outcome vary across background characteristics? </h3>

In the fourth analysis of this section, we look at how the probability of success varies across pathways and student background characteristics. Specifically, we look at the adjusted probabilities of transfer and completion for each pathway by gender, mother's educational attainment, and race/ethnicity, across different values of high school GPA, Pell award amounts, and age at entry.

It's important to think carefully about the implications and interpretation of these probabilities, particularly when looking at those for demographic characteristics. These are not causal estimates- if there are differences by gender in students' likelihood of completing, this does not mean that students of one gender are better or more capable students. Instead, you should take this as an opportunity to reflect on the support you offer students and how that support may need to be tailored to different groups so that all students have equitable opportunities to succeed. In what ways is your institution recognizing and leveraging the strengths that each student brings to promote equitable success? For which students does your institution need to continue to improve?

<div class="navbar navbar-default navbar-fixed-top" id="logo">
 <div class="container">
<img src="https://github.com/rachworsham/open_sdp_cte_toolkit/blob/806f53825f42a6c63e181a1e7e9f0c455a9ddb88/docs/narrative_img/narrative.1.4.png">
</div>
</div>
<pre id="stlog-4" class="stcmd"><code>
<span class="stcmt">* Charts: high school GPA margins</span>
{
	
<span class="stcmt">* Main high school GPA margins</span>
margins pathway, at(hsgpa = (2(0.25)4)) predict(outcome(1)) predict(outcome(2))				
marginsplot, bydimension(pathway) <span class="stcmt">///</span>
	byopts(title("Adjusted Probability of Completion First or Transfer First" "by High School GPA") <span class="stcmt">///</span>
	graphregion(fcolor(white)) imargin(medium) <span class="stcmt">///</span>
	note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", <span class="stcmt">///</span>
	size(vsmall))) ytitle("Adjusted Probability") xtitle("High School GPA") <span class="stcmt">///</span>
	ylabel(0(0.2)1) noci legend(order(1 "Completion First" 2 "Transfer First")) <span class="stcmt">///</span>
	plotregion(margin(zero)) yline(0, lcolor(black)) <span class="stcmt">///</span>
	plot1opts(mcolor("51 34 136") lcolor("51 34 136"), ) <span class="stcmt">///</span>
	plot2opts(mcolor("68 170 153") lcolor("68 170 153"))
graph export "${saved_graphs}/4_gpa_1.png", replace

<span class="stcmt">* High school GPA margins by gender</span>
margins pathway, at(male = (0(1)1) hsgpa = (2(0.25)4)) predict(outcome(1))	
marginsplot, bydimension(pathway) plotdimension(male) noci <span class="stcmt">///</span>
	byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) <span class="stcmt">///</span>
	ytitle("First Completion") xtitle("") <span class="stcmt">///</span>
	ylabel(0(0.2)1) xlabel(2(0.5)4) plotregion(margin(zero)) yline(0, lcolor(black)) <span class="stcmt">///</span>
	plot1opts(mcolor("51 34 136") lcolor("51 34 136")) <span class="stcmt">///</span>
	plot2opts(mcolor("68 170 153") lcolor("68 170 153")) <span class="stcmt">///</span>
	name(g4_a, replace)	

margins pathway, at(male = (0(1)1) hsgpa = (2(0.25)4)) predict(outcome(2))
marginsplot, bydimension(pathway) plotdimension(male) <span class="stcmt">///</span>
	noci byopts(graphregion(fcolor(white)) <span class="stcmt">///</span>
	rows(1) imargin(medium) title("")) ytitle("First Transfer") xtitle("") <span class="stcmt">///</span>
	ylabel(0(0.2)1) xlabel(2(0.5)4) plotregion(margin(zero)) yline(0, <span class="stcmt">///</span>
	lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) <span class="stcmt">///</span>
	plot2opts(mcolor("68 170 153") lcolor("68 170 153")) <span class="stcmt">///</span>
	name(g4_b, replace)	
	
	grc1leg2 g4_a g4_b, <span class="stcmt">///</span>
	title("Adjusted Probability of First Completion/Transfer" "by Gender and High School GPA") <span class="stcmt">///</span>
	rows(2) graphregion(fcolor(white)) <span class="stcmt">///</span>
	b1title("High School GPA") l1title("Adjusted Probability") position(3) <span class="stcmt">///</span>
	lrows(2) symxsize(small) labsize(small) xsize(7) <span class="stcmt">///</span>
	note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", <span class="stcmt">///</span>
	size(vsmall))
graph export "${saved_graphs}/4_gpa_2.png", replace

<span class="stcmt">* High school GPA margins by mother level of education</span>
margins pathway, at(motheredlevel = (1(1)3) hsgpa = (2(0.25)4)) predict(outcome(1))	
marginsplot, bydimension(pathway) plotdimension(motheredlevel) <span class="stcmt">///</span>
	noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) <span class="stcmt">///</span>
	legend(order(1 "Middle Sch" 2 "High Sch" 3 "Any College")) <span class="stcmt">///</span>
	ytitle("First Completion") xtitle("") ylabel(0(0.2)1) xlabel(2(0.5)4) <span class="stcmt">///</span>
	plotregion(margin(zero)) yline(0, lcolor(black)) <span class="stcmt">///</span>
	plot1opts(mcolor("51 34 136") lcolor("51 34 136")) <span class="stcmt">///</span>
	plot2opts(mcolor("68 170 153") lcolor("68 170 153")) <span class="stcmt">///</span>
	plot3opts(mcolor("136 34 85") lcolor("136 34 85")) name(g4_a, replace)

margins pathway, at(motheredlevel = (1(1)3) hsgpa = (2(0.25)4)) predict(outcome(2))
marginsplot, bydimension(pathway) plotdimension(motheredlevel) <span class="stcmt">///</span>
	noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) <span class="stcmt">///</span>
	title("")) ytitle("First Transfer") xtitle("") <span class="stcmt">///</span>
	ylabel(0(0.2)1) xlabel(2(0.5)4) plotregion(margin(zero)) yline(0, <span class="stcmt">///</span>
	lcolor(black)) plot1opts(mcolor("51 34 136") lcolor("51 34 136")) <span class="stcmt">///</span>
	plot2opts(mcolor("68 170 153") lcolor("68 170 153")) <span class="stcmt">///</span>
	plot3opts(mcolor("136 34 85") lcolor("136 34 85")) name(g4_b, replace)
	
	grc1leg2 g4_a g4_b, <span class="stcmt">///</span>
	title("Adjusted Probability of First Completion/Transfer" "by Mother's Education Level and High School GPA") <span class="stcmt">///</span>
	rows(2) graphregion(fcolor(white)) <span class="stcmt">///</span>
	b1title("High School GPA") l1title("Adjusted Probability") position(3) <span class="stcmt">///</span>
	lrows(3) symxsize(small) labsize(small) xsize(7) <span class="stcmt">///</span>
	note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", <span class="stcmt">///</span>
	size(vsmall))
graph export "${saved_graphs}/4_gpa_3.png", replace

<span class="stcmt">* High school GPA margins by race/ethnicity</span>
margins pathway, at(race = (1(1)5) hsgpa = (2(0.25)4)) predict(outcome(1))
marginsplot, bydimension(pathway) plotdimension(race) <span class="stcmt">///</span>
	noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) <span class="stcmt">///</span>
	yline(0, lcolor(black)) ytitle("First Completion") <span class="stcmt">///</span>
	xtitle("") ylabel(0(0.2)1) xlabel(2(0.5)4) plotregion(margin(zero)) <span class="stcmt">///</span>
	plot1opts(mcolor("51 34 136") lcolor("51 34 136")) <span class="stcmt">///</span>
	plot2opts(mcolor("68 170 153") lcolor("68 170 153")) <span class="stcmt">///</span>
    plot3opts(mcolor("136 34 85") lcolor("136 34 85")) <span class="stcmt">///</span>
    plot4opts(mcolor("136 204 238") lcolor("136 204 238")) <span class="stcmt">///</span>
    plot5opts(mcolor("204 102 119") lcolor("204 102 119")) <span class="stcmt">///</span>
	name(g4_a, replace)
margins pathway, at(race = (1(1)5) hsgpa = (2(0.25)4)) predict(outcome(2))
marginsplot, bydimension(pathway) plotdimension(race) <span class="stcmt">///</span>
	noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) <span class="stcmt">///</span>
	yline(0, lcolor(black)) ytitle("First Transfer") xtitle("") ylabel(0(0.2)1) xlabel(2(0.5)4) plotregion(margin(zero)) <span class="stcmt">///</span>
    plot1opts(mcolor("51 34 136") lcolor("51 34 136")) <span class="stcmt">///</span>
	plot2opts(mcolor("68 170 153") lcolor("68 170 153")) <span class="stcmt">///</span>
	plot3opts(mcolor("136 34 85") lcolor("136 34 85")) <span class="stcmt">///</span>
	plot4opts(mcolor("136 204 238") lcolor("136 204 238")) <span class="stcmt">///</span>
	plot5opts(mcolor("204 102 119") lcolor("204 102 119")) <span class="stcmt">///</span>
	name(g4_b, replace)	
	
    grc1leg2 g4_a g4_b, title("Adjusted Probability of First Completion/Transfer" "by Race/Ethnicity and High School GPA") <span class="stcmt">///</span>
	rows(2) graphregion(fcolor(white)) <span class="stcmt">///</span>
    b1title("High School GPA") l1title("Adjusted Probability") position(3) lrows(5) symxsize(small) labsize(small) xsize(7) <span class="stcmt">///</span>
    note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", <span class="stcmt">///</span>
	size(vsmall))
graph export "${saved_graphs}/4_gpa_4.png", replace
		
}


<span class="stcmt">* Charts: Pell grant margins</span>
{

<span class="stcmt">* Main Pell grant margins </span>
margins pathway, at(pell = (0(1000)6000)) predict(outcome(1)) predict(outcome(2))
marginsplot, bydimension(pathway) <span class="stcmt">///</span>
	byopts(title("Adjusted Probability of Completion First or Transfer First" "by Pell Grant Dollars") <span class="stcmt">///</span>
	graphregion(fcolor(white)) imargin(medium) <span class="stcmt">///</span>
	note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", <span class="stcmt">///</span>
	size(vsmall))) <span class="stcmt">///</span>
	ytitle("Adjusted Probability") xtitle("Pell Dollars Awarded in First Year") <span class="stcmt">///</span>
	ylabel(0(0.2)1) xlabel(0(1500)6000) <span class="stcmt">///</span>
	noci legend(order(1 "Completion First" 2 "Transfer First")) plotregion(margin(zero)) <span class="stcmt">///</span>
	yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") <span class="stcmt">///</span>
	lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153"))
graph export "${saved_graphs}/5_pell_1.png", replace

<span class="stcmt">* Pell grant margins by gender</span>
margins pathway, at(male = (0 1) pell = (0(1000)6000)) predict(outcome(1))
marginsplot, bydimension(pathway) plotdimension(male) <span class="stcmt">///</span>
	noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) <span class="stcmt">///</span>
	title("")) ytitle("First Completion") xtitle("") <span class="stcmt">///</span>
	ylabel(0(0.2)1) xlabel(0(1500)6000) plotregion(margin(zero)) <span class="stcmt">///</span>
	yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") <span class="stcmt">///</span>
	lcolor("51 34 136")) plot2opts(mcolor("68 170 153") <span class="stcmt">///</span>
	lcolor("68 170 153")) name(g5_a, replace)	
	
margins pathway, at(male = (0 1) pell = (0(1000)6000)) predict(outcome(2))
marginsplot, bydimension(pathway) plotdimension(male) <span class="stcmt">///</span>
	noci byopts(graphregion(fcolor(white)) rows(1) <span class="stcmt">///</span>
	imargin(medium) title("")) ytitle("First Transfer") xtitle("") <span class="stcmt">///</span>
	ylabel(0(0.2)1) xlabel(0(1500)6000) plotregion(margin(zero)) <span class="stcmt">///</span>
	yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") <span class="stcmt">///</span>
	lcolor("51 34 136")) plot2opts(mcolor("68 170 153") <span class="stcmt">///</span>
	lcolor("68 170 153")) name(g5_b, replace) 
	
	grc1leg2 g5_a g5_b, <span class="stcmt">///</span>
	title("Adjusted Probability of First Completion/Transfer" "by Gender and Pell Grant Dollars") <span class="stcmt">///</span>
	rows(2) graphregion(fcolor(white)) <span class="stcmt">///</span>
	b1title("Pell Dollars Awarded in First Year") l1title("Adjusted Probability") <span class="stcmt">///</span>
    position(3) lrows(2) symxsize(small) labsize(small) xsize(7) <span class="stcmt">///</span>
	note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", <span class="stcmt">///</span>
	size(vsmall))	
graph export "${saved_graphs}/5_pell_2.png", replace
	
<span class="stcmt">* Pell grant margins by mother level of education</span>
margins pathway, at(motheredlevel = (1(1)3) pell = (0(1000)6000)) predict(outcome(1))
marginsplot, bydimension(pathway) plotdimension(motheredlevel) <span class="stcmt">///</span>
	noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) <span class="stcmt">///</span>
	title("")) legend(order(1 "Middle Sch" 2 "High Sch" 3 "Any College")) <span class="stcmt">///</span>
	ytitle("First Completion") xtitle("") <span class="stcmt">///</span>
	ylabel(0(0.2)1) xlabel(0(1500)6000) plotregion(margin(zero)) <span class="stcmt">///</span>
	yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") <span class="stcmt">///</span>
	lcolor("51 34 136")) plot2opts(mcolor("68 170 153") <span class="stcmt">///</span>
	lcolor("68 170 153")) plot3opts(mcolor("136 34 85") <span class="stcmt">///</span>
	lcolor("136 34 85")) name(g5_a, replace)	
	
margins pathway, at(motheredlevel = (1(1)3) pell = (0(1000)6000)) predict(outcome(2))
marginsplot, bydimension(pathway) plotdimension(motheredlevel) <span class="stcmt">///</span>
	noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) <span class="stcmt">///</span>
	title("")) ytitle("First Transfer") xtitle("") <span class="stcmt">///</span>
	ylabel(0(0.2)1) xlabel(0(1500)6000) plotregion(margin(zero)) <span class="stcmt">///</span>
	yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") <span class="stcmt">///</span>
	lcolor("51 34 136")) plot2opts(mcolor("68 170 153") <span class="stcmt">///</span>
	lcolor("68 170 153")) plot3opts(mcolor("136 34 85") <span class="stcmt">///</span>
	lcolor("136 34 85")) name(g5_b, replace)
	
	grc1leg2 g5_a g5_b, <span class="stcmt">///</span>
	title("Adjusted Probability of First Completion/Transfer" "by Mother's Education Level and Pell Grant Dollars") <span class="stcmt">///</span>
	rows(2) graphregion(fcolor(white)) <span class="stcmt">///</span>
	b1title("Pell Dollars Awarded in First Year") <span class="stcmt">///</span>
	l1title("Adjusted Probability") position(3) lrows(3) <span class="stcmt">///</span>
	symxsize(small) labsize(small) xsize(7) <span class="stcmt">///</span>
	note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", <span class="stcmt">///</span>
	size(vsmall))	
graph export "${saved_graphs}/5_pell_3.png", replace

<span class="stcmt">* Pell grant margins by race/ethnicity</span>
margins pathway, at(race = (1(1)5) pell = (0(1000)6000)) predict(outcome(1))
marginsplot, bydimension(pathway) plotdimension(race) <span class="stcmt">///</span>
	noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) <span class="stcmt">///</span>
	yline(0, lcolor(black)) ytitle("First Completion") xtitle("") ylabel(0(0.2)1) xlabel(0(1500)6000) plotregion(margin(zero)) <span class="stcmt">///</span>
	plot1opts(mcolor("51 34 136") lcolor("51 34 136")) <span class="stcmt">///</span>
	plot2opts(mcolor("68 170 153") lcolor("68 170 153")) <span class="stcmt">///</span>
	plot3opts(mcolor("136 34 85") lcolor("136 34 85")) <span class="stcmt">///</span>
	plot4opts(mcolor("136 204 238") lcolor("136 204 238")) <span class="stcmt">///</span>
	plot5opts(mcolor("204 102 119") lcolor("204 102 119")) <span class="stcmt">///</span>
	name(g5_a, replace)		
	
margins pathway, at(race = (1(1)5) pell = (0(1000)6000)) predict(outcome(2))
marginsplot, bydimension(pathway) plotdimension(race) <span class="stcmt">///</span>
	noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) <span class="stcmt">///</span>
	yline(0, lcolor(black)) ytitle("First Transfer") xtitle("") ylabel(0(0.2)1) xlabel(0(1500)6000) plotregion(margin(zero)) <span class="stcmt">///</span>
	plot1opts(mcolor("51 34 136") lcolor("51 34 136")) <span class="stcmt">///</span>
	plot2opts(mcolor("68 170 153") lcolor("68 170 153")) <span class="stcmt">///</span>
	plot3opts(mcolor("136 34 85") lcolor("136 34 85")) <span class="stcmt">///</span>
	plot4opts(mcolor("136 204 238") lcolor("136 204 238")) <span class="stcmt">///</span>
	plot5opts(mcolor("204 102 119") lcolor("204 102 119")) <span class="stcmt">///</span>
	name(g5_b, replace)
	
	grc1leg2 g5_a g5_b, title("Adjusted Probability of First Completion/Transfer" "by Race/Ethnicity and Pell Grant Dollars") <span class="stcmt">///</span>
	rows(2) graphregion(fcolor(white)) <span class="stcmt">///</span>
	b1title("Pell Dollars Awarded in First Year") <span class="stcmt">///</span>
	l1title("Adjusted Probability") position(3) lrows(5) <span class="stcmt">///</span>
	symxsize(small) labsize(small) xsize(7) <span class="stcmt">///</span>
	note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", <span class="stcmt">///</span>
	size(vsmall))		
graph export "${saved_graphs}/5_pell_4.png", replace

}	

	
<span class="stcmt">* Charts: age at entry margins</span>
{

<span class="stcmt">* Main age at entry margins</span>
margins pathway, at(age = (18(3)36)) predict(outcome(1)) predict(outcome(2))
marginsplot, bydimension(pathway) <span class="stcmt">///</span>
	byopts(title("Adjusted Probability of Completion First or Transfer First" "by Student Age at Entry") <span class="stcmt">///</span>
	graphregion(fcolor(white)) imargin(medium) <span class="stcmt">///</span>
	note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", <span class="stcmt">///</span>
	size(vsmall))) ytitle("Adjusted Probability") <span class="stcmt">///</span>
	xtitle("Student Age at Entry") ylabel(0(0.2)1) xlabel(18(3)36) <span class="stcmt">///</span>
	noci legend(order(1 "Completion First" 2 "Transfer First")) <span class="stcmt">///</span>
	plotregion(margin(zero)) yline(0, lcolor(black)) <span class="stcmt">/// </span>
	plot1opts(mcolor("51 34 136") lcolor("51 34 136")) <span class="stcmt">///</span>
	plot2opts(mcolor("68 170 153") lcolor("68 170 153"))
graph export "${saved_graphs}/6_age_1.png", replace	

<span class="stcmt">* Age at entry margins by gender</span>
margins pathway, at(male = (0 1) age = (18(3)36)) predict(outcome(1))
marginsplot, bydimension(pathway) plotdimension(male) <span class="stcmt">///</span>
	noci byopts(graphregion(fcolor(white)) rows(1) <span class="stcmt">///</span>
	imargin(medium) title("")) ytitle("First Completion") xtitle("") <span class="stcmt">///</span>
	ylabel(0(0.2)1) xlabel(18(6)36) plotregion(margin(zero)) <span class="stcmt">///</span>
	yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") <span class="stcmt">///</span>
	lcolor("51 34 136")) plot2opts(mcolor("68 170 153") <span class="stcmt">///</span>
	lcolor("68 170 153")) name(g6_a, replace)	
	
margins pathway, at(male = (0 1) age = (18(3)36)) predict(outcome(2))
marginsplot, bydimension(pathway) plotdimension(male) <span class="stcmt">///</span>
	noci byopts(graphregion(fcolor(white)) rows(1) <span class="stcmt">///</span>
	imargin(medium) title("")) ytitle("First Transfer") xtitle("") <span class="stcmt">///</span>
	ylabel(0(0.2)1) xlabel(18(6)36) plotregion(margin(zero)) <span class="stcmt">///</span>
	yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") <span class="stcmt">///</span>
	lcolor("51 34 136")) plot2opts(mcolor("68 170 153") <span class="stcmt">///</span>
	lcolor("68 170 153")) name(g6_b, replace) 
	
	grc1leg2 g6_a g6_b, title("Adjusted Probability of First Completion/Transfer" "by Gender and Age at Entry") <span class="stcmt">///</span>
	rows(2) graphregion(fcolor(white)) <span class="stcmt">///</span>
	b1title("Age at Entry") l1title("Adjusted Probability") <span class="stcmt">///</span>
	position(3) lrows(2) symxsize(small) labsize(small) xsize(7) <span class="stcmt">///</span>
	note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", <span class="stcmt">///</span>
	size(vsmall))	
graph export "${saved_graphs}/6_age_2.png", replace

<span class="stcmt">* Age at entry margins by mother level of education</span>
margins pathway, at(motheredlevel = (1(1)3) age = (18(3)36)) predict(outcome(1))
marginsplot, bydimension(pathway) plotdimension(motheredlevel) <span class="stcmt">///</span>
	noci byopts(graphregion(fcolor(white)) <span class="stcmt">///</span>
	rows(1) imargin(medium) title("")) <span class="stcmt">///</span>
	legend(order(1 "Middle Sch" 2 "High Sch" 3 "Any College")) <span class="stcmt">///</span>
	ytitle("First Completion") xtitle("") <span class="stcmt">///</span>
	ylabel(0(0.2)1) xlabel(18(6)36) plotregion(margin(zero)) <span class="stcmt">///</span>
	yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") <span class="stcmt">///</span>
	lcolor("51 34 136")) plot2opts(mcolor("68 170 153") <span class="stcmt">///</span>
	lcolor("68 170 153")) plot3opts(mcolor("136 34 85") lcolor("136 34 85")) <span class="stcmt">///</span>
	name(g6_a, replace)	
	
margins pathway, at(motheredlevel = (1(1)3) age = (18(3)36)) predict(outcome(2))
marginsplot, bydimension(pathway) plotdimension(motheredlevel) <span class="stcmt">///</span>
	noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) <span class="stcmt">///</span>
	title("")) ytitle("First Transfer") xtitle("") <span class="stcmt">///</span>
	ylabel(0(0.2)1) xlabel(18(6)36) plotregion(margin(zero)) <span class="stcmt">///</span>
	yline(0, lcolor(black)) plot1opts(mcolor("51 34 136") <span class="stcmt">///</span>
	lcolor("51 34 136")) plot2opts(mcolor("68 170 153") lcolor("68 170 153")) <span class="stcmt">///</span>
	plot3opts(mcolor("136 34 85") lcolor("136 34 85")) name(g6_b, replace) 
	
    grc1leg2 g6_a g6_b, title("Adjusted Probability of First Completion/Transfer" "by Mother's Education Level and Age at Entry") <span class="stcmt">///</span>
	rows(2) graphregion(fcolor(white)) <span class="stcmt">///</span>
	b1title("Age at Entry") l1title("Adjusted Probability") position(3) <span class="stcmt">///</span>
	lrows(3) symxsize(small) labsize(small) xsize(7) <span class="stcmt">///</span>
	note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", <span class="stcmt">///</span>
	size(vsmall))	
graph export "${saved_graphs}/6_age_3.png", replace

<span class="stcmt">* Age at entry margins by race/ethnicity</span>
margins pathway, at(race = (1(1)5) age = (18(3)36)) predict(outcome(1))
marginsplot, bydimension(pathway) plotdimension(race) <span class="stcmt">///</span>
	noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) <span class="stcmt">///</span>
	yline(0, lcolor(black)) ytitle("First Completion") xtitle("") <span class="stcmt">///</span>
	ylabel(0(0.2)1) xlabel(18(6)36) plotregion(margin(zero)) <span class="stcmt">///</span>
	plot1opts(mcolor("51 34 136") lcolor("51 34 136")) <span class="stcmt">///</span>
	plot2opts(mcolor("68 170 153") lcolor("68 170 153")) <span class="stcmt">///</span>
    plot3opts(mcolor("136 34 85") lcolor("136 34 85")) <span class="stcmt">///</span>
	plot4opts(mcolor("136 204 238") lcolor("136 204 238")) <span class="stcmt">///</span>
	plot5opts(mcolor("204 102 119") lcolor("204 102 119")) <span class="stcmt">///</span>
	name(g6_a, replace)	
	
margins pathway, at(race = (1(1)5) age = (18(3)36)) predict(outcome(2))
marginsplot, bydimension(pathway) plotdimension(race) <span class="stcmt">///</span>
	noci byopts(graphregion(fcolor(white)) rows(1) imargin(medium) title("")) <span class="stcmt">///</span>
	yline(0, lcolor(black)) ytitle("First Transfer") xtitle("") <span class="stcmt">///</span>
	ylabel(0(0.2)1) xlabel(18(6)36) plotregion(margin(zero)) <span class="stcmt">///</span>
	plot1opts(mcolor("51 34 136") lcolor("51 34 136")) <span class="stcmt">///</span>
	plot2opts(mcolor("68 170 153") lcolor("68 170 153")) <span class="stcmt">///</span>
    plot3opts(mcolor("136 34 85") lcolor("136 34 85")) <span class="stcmt">///</span>
	plot4opts(mcolor("136 204 238") lcolor("136 204 238")) <span class="stcmt">///</span>
	plot5opts(mcolor("204 102 119") lcolor("204 102 119")) <span class="stcmt">///</span>
	name(g6_b, replace)	
	
	grc1leg2 g6_a g6_b, title("Adjusted Probability of First Completion/Transfer" "by Race/Ethnicity and Age at Entry") <span class="stcmt">///</span>
	rows(2) graphregion(fcolor(white)) <span class="stcmt">///</span>
	b1title("Age at Entry") l1title("Adjusted Probability") position(3) lrows(5) symxsize(small) labsize(small) xsize(7) <span class="stcmt">///</span>
	note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", <span class="stcmt">///</span>
	size(vsmall))	
graph export "${saved_graphs}/6_age_4.png", replace
	
}


<span class="stcmt">* Charts: race/ethnicity margins</span>
{

<span class="stcmt">* Main race/ethnicity margins</span>
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
label define race_vals 1 "Asian" 2 "Black" 3 "Hispanic" 4 "White" 5 "Other" 
<span class="stcmt">// unfortunately these value labels must be re-copied from above; value labels created in one frame are not accessible in another</span>
label values race_level race_vals
gen pathway_level = ustrregexs(1) if ustrregexm(estimate_name, "_at#([0-9]+)")
destring pathway_level, replace
label define pathway_vals 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway" 
<span class="stcmt">// please modify appropriately; unfortunately, value labels do not copy automatically into new frames	</span>
label values pathway_level pathway_vals
drop estimate_name
order race_level pathway_level outcome_level	
reshape wide prediction_, i(race_level pathway_level) j(outcome_level)

graph bar (asis) prediction_1 prediction_2, by(pathway_level, <span class="stcmt">///</span>
	title("Adjusted Probability of First Completion/Transfer" "by Race/Ethnicity") <span class="stcmt">///</span>
	b1title("Race/Ethnicity", size(medium)) imargin(medium) <span class="stcmt">///</span>
	note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort. Adjusted probabilities" "for each outcome are stacked.", size(vsmall)) <span class="stcmt">///</span>
	graphregion(fcolor(white)) legend(position(3))) <span class="stcmt">///</span>
	ytitle("Adjusted Probability") over(race_level, label(angle(45))) <span class="stcmt">///</span>
	stack ylabel(0(0.2)1) legend(order(1 "Completion First" 2 "Transfer First") <span class="stcmt">///</span>
	rows(2) symxsize(2) size(small) width(35))  <span class="stcmt">/// </span>
	bar(1, fcolor("51 34 136") lcolor(black)) bar(2, fcolor("68 170 153") lcolor(black))		
graph export "${saved_graphs}/7_race_1.png", replace		

frame change default
frame drop working

<span class="stcmt">* Race/ethnicity margins by gender	</span>
margins pathway, at(race = (1(1)5) male = (0 1)) predict(outcome(1))	
marginsplot, graphdimension(pathway) bydimension(male) xdimension(race) <span class="stcmt">///</span>
	noci byopts(title("") l1title("") b1title("") graphregion(fcolor(white)) <span class="stcmt">///</span>
	imargin(vsmall)) recast(bar) plotopts(ylabel(0(0.2)1) xlabel(,angle(45)) <span class="stcmt">///</span>
	plotregion(margin(zero))) plotdimension(race) <span class="stcmt">///</span>
	plot1opts(fcolor("51 34 136") lcolor("51 34 136")) <span class="stcmt">///</span>
	plot2opts(fcolor("68 170 153") lcolor("68 170 153")) <span class="stcmt">///</span>
	plot3opts(fcolor("136 34 85") lcolor("136 34 85")) <span class="stcmt">///</span>
    plot4opts(fcolor("136 204 238") lcolor("136 204 238")) <span class="stcmt">///</span>
	plot5opts(fcolor("204 102 119") lcolor("204 102 119"))	<span class="stcmt">///			 </span>
	name(g7_a, replace)
	
margins pathway, at(race = (1(1)5) male = (0 1)) predict(outcome(2))
marginsplot, graphdimension(pathway) bydimension(male) <span class="stcmt">///</span>
	xdimension(race) noci byopts(title("") l1title("") b1title("") <span class="stcmt">///</span>
	graphregion(fcolor(white)) imargin(vsmall)) recast(bar) <span class="stcmt">///</span>
	plotopts(ylabel(0(0.2)1) xlabel(,angle(45)) <span class="stcmt">///</span>
	plotregion(margin(zero))) plotdimension(race) <span class="stcmt">///</span>
	plot1opts(fcolor("51 34 136") lcolor("51 34 136")) <span class="stcmt">///</span>
	plot2opts(fcolor("68 170 153") lcolor("68 170 153")) <span class="stcmt">///</span>
	plot3opts(fcolor("136 34 85") lcolor("136 34 85")) <span class="stcmt">///</span>
	plot4opts(fcolor("136 204 238") lcolor("136 204 238")) <span class="stcmt">///</span>
	plot5opts(fcolor("204 102 119") lcolor("204 102 119"))	<span class="stcmt">///					 </span>
	name(g7_b, replace)
	
levelsof entry_pathway, local(pathways)
local named_graphs
forvalues i = 1/`: word count `pathways'' {
	local named_graphs `named_graphs' g7_a`i'
}
forvalues i = 1/`: word count `pathways'' {
	local named_graphs `named_graphs' g7_b`i'
}
grc1leg2 `named_graphs', title("Adjusted Probability of First Completion/Transfer" "by Gender and Race/Ethnicity") <span class="stcmt">///</span>
l2title("Adjusted Probability") <span class="stcmt">///</span>
		 l1title("First Transfer                         First Completion", size(small)) <span class="stcmt">///   </span>
		 graphregion(fcolor(white)) rows(2) lrows(5) position(3) symxsize(small) labsize(small) xsize(7) <span class="stcmt">/// </span>
		 note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall)) <span class="stcmt">// the l1title() approach used here is admittedly a little informal, but it is a useful approach given how we needed to set up this graph</span>
graph export "${saved_graphs}/7_race_2.png", replace

<span class="stcmt">* Race/ethnicity margins by mother level of education</span>
margins pathway, at(race = (1(1)5) motheredlevel = (1(1)3)) predict(outcome(1))
marginsplot, graphdimension(pathway) bydimension(motheredlevel) xdimension(race) noci recast(bar) byopts(title("") l1title("") b1title("") rows(1) graphregion(fcolor(white)) imargin(small)) <span class="stcmt">///</span>
			 plotopts(ylabel(0(0.2)1) xlabel(,angle(45)) plotregion(margin(zero))) plotdimension(race) <span class="stcmt">///</span>
			 plot1opts(fcolor("51 34 136") lcolor("51 34 136")) <span class="stcmt">///</span>
			 plot2opts(fcolor("68 170 153") lcolor("68 170 153")) <span class="stcmt">///</span>
			 plot3opts(fcolor("136 34 85") lcolor("136 34 85")) <span class="stcmt">///</span>
			 plot4opts(fcolor("136 204 238") lcolor("136 204 238")) <span class="stcmt">///</span>
			 plot5opts(fcolor("204 102 119") lcolor("204 102 119"))	<span class="stcmt">///					 </span>
			 name(g7_a, replace)
margins pathway, at(race = (1(1)5) motheredlevel = (1(1)3)) predict(outcome(2))
marginsplot, graphdimension(pathway) bydimension(motheredlevel) xdimension(race) noci recast(bar) byopts(title("") l1title("") b1title("") rows(1) graphregion(fcolor(white)) imargin(small)) <span class="stcmt">///</span>
			 plotopts(ylabel(0(0.2)1) xlabel(,angle(45)) plotregion(margin(zero))) plotdimension(race) <span class="stcmt">///</span>
			 plot1opts(fcolor("51 34 136") lcolor("51 34 136")) <span class="stcmt">///</span>
			 plot2opts(fcolor("68 170 153") lcolor("68 170 153")) <span class="stcmt">///</span>
			 plot3opts(fcolor("136 34 85") lcolor("136 34 85")) <span class="stcmt">///</span>
			 plot4opts(fcolor("136 204 238") lcolor("136 204 238")) <span class="stcmt">///</span>
			 plot5opts(fcolor("204 102 119") lcolor("204 102 119"))	<span class="stcmt">///					 </span>
			 name(g7_b, replace)
levelsof entry_pathway, local(pathways)
local named_graphs
forvalues i = 1/`: word count `pathways'' {
	local named_graphs `named_graphs' g7_a`i'
}
forvalues i = 1/`: word count `pathways'' {
	local named_graphs `named_graphs' g7_b`i'
}	
grc1leg2 `named_graphs', title("Adjusted Probability of First Completion/Transfer" "by Mother's Education Level and Race/Ethnicity") l2title("Adjusted Probability") <span class="stcmt">///</span>
						 l1title("First Transfer                         First Completion", size(small)) <span class="stcmt">///</span>
						 graphregion(fcolor(white)) rows(2) lrows(5) position(3) symxsize(small) labsize(small) xsize(9) <span class="stcmt">///</span>
						 note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", size(vsmall)) <span class="stcmt">// the l1title() approach used here is admittedly a little informal, but it is a useful approach given how we needed to set up this graph</span>
graph export "${saved_graphs}/7_race_3.png", replace
	
}


<span class="stcmt">* Charts: mother's ed.</span>
{

<span class="stcmt">* Main mother level of education margins</span>
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
label define edlevel_vals 1 "Middle Sch" 2 "High Sch" 3 "Any College" 4 "NA" <span class="stcmt">// unfortunately these value labels must be re-copied from above; value labels created in one frame are not accessible in another</span>
label values mothered_level edlevel_vals
gen pathway_level = ustrregexs(1) if ustrregexm(estimate_name, "_at#([0-9]+)")
destring pathway_level, replace
label define pathway_vals 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway" <span class="stcmt">// please modify appropriately; unfortunately, value labels do not copy automatically into new frames	</span>
label values pathway_level pathway_vals
drop estimate_name
order mothered_level pathway_level outcome_level	
reshape wide prediction_, i(mothered_level pathway_level) j(outcome_level)
graph bar (asis) prediction_1 prediction_2, by(pathway_level, title("Adjusted Probability of First Completion/Transfer" "by Mother's Education Level") b1title("Mother's Eduation Level") imargin(medium) <span class="stcmt">///</span>
		note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort. Adjusted probabilities" "for each outcome are stacked.", size(vsmall)) <span class="stcmt">///</span>
		graphregion(fcolor(white))) ytitle("Adjusted Probability") over(mothered_level, relabel(1 `" "Middle" "Sch" "' 2 `" "High" "Sch" "' 3 `" "Any" "College" "') label(labsize(small))) stack ylabel(0(0.2)1) <span class="stcmt">///</span>
		legend(order(1 "Completion First" 2 "Transfer First")) bar(1, fcolor("51 34 136") lcolor(black)) bar(2, fcolor("68 170 153") lcolor(black))
graph export "${saved_graphs}/8_mothered_1.png", replace	
frame change default
frame drop working

<span class="stcmt">* Mother level of education margins by gender</span>
margins pathway, at(male = (0 1) motheredlevel = (1(1)3)) predict(outcome(1))
marginsplot, graphdimension(pathway) bydimension(male) xdimension(motheredlevel) noci recast(bar) byopts(title("") l1title("") b1title("") graphregion(fcolor(white)) imargin(small)) <span class="stcmt">///</span>
			 plotopts(ylabel(0(0.2)1) xlabel(,angle(45)) plotregion(margin(zero))) plotdimension(motheredlevel) <span class="stcmt">///</span>
			 plot1opts(fcolor("51 34 136") lcolor("51 34 136")) <span class="stcmt">///</span>
			 plot2opts(fcolor("68 170 153") lcolor("68 170 153")) <span class="stcmt">///</span>
			 plot3opts(fcolor("136 34 85") lcolor("136 34 85")) <span class="stcmt">///</span>
			 name(g8_a, replace)
margins pathway, at(male = (0 1) motheredlevel = (1(1)3)) predict(outcome(2))
marginsplot, graphdimension(pathway) bydimension(male) xdimension(motheredlevel) noci recast(bar) byopts(title("") l1title("") b1title("") graphregion(fcolor(white)) imargin(small)) <span class="stcmt">///</span>
			 plotopts(ylabel(0(0.2)1) xlabel(,angle(45)) plotregion(margin(zero))) plotdimension(motheredlevel) <span class="stcmt">///</span>
			 plot1opts(fcolor("51 34 136") lcolor("51 34 136")) <span class="stcmt">///</span>
			 plot2opts(fcolor("68 170 153") lcolor("68 170 153")) <span class="stcmt">///</span>
			 plot3opts(fcolor("136 34 85") lcolor("136 34 85")) <span class="stcmt">///				 </span>
			 name(g8_b, replace)
levelsof entry_pathway, local(pathways)
local named_graphs
forvalues i = 1/`: word count `pathways'' {
	local named_graphs `named_graphs' g8_a`i'
}
forvalues i = 1/`: word count `pathways'' {
	local named_graphs `named_graphs' g8_b`i'
}
grc1leg2 `named_graphs', <span class="stcmt">///</span>
	title("Adjusted Probability of First Completion/Transfer" "by Gender and Mother's Education Level") <span class="stcmt">///</span>
	l2title("Adjusted Probability") <span class="stcmt">///</span>
    l1title("First Transfer First Completion", size(small)) <span class="stcmt">///</span>
	graphregion(fcolor(white)) rows(2) lrows(3) position(3) <span class="stcmt">///</span>
	symxsize(small) labsize(small) xsize(7) <span class="stcmt">///</span>
	note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort.", <span class="stcmt">///</span>
	size(vsmall)) 
	<span class="stcmt">/*the l1title() approach used here is admittedly a little informal, </span>
<span class="stcmt">	but it is a useful approach given how we needed to set up this graph*/</span>
	
graph export "${saved_graphs}/8_mothered_2.png", replace

}


<span class="stcmt">* Charts: gender margins</span>
{

<span class="stcmt">* Main gender margins</span>
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
label define male 1 "Female" 2 "Male" 
<span class="stcmt">// unfortunately these value labels must be re-copied from above; value labels created in one frame are not accessible in another</span>
label values male_level male
gen pathway_level = ustrregexs(1) if ustrregexm(estimate_name, "_at#([0-9]+)")
destring pathway_level, replace
label define pathway_vals 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway" 
<span class="stcmt">// please modify appropriately; unfortunately, value labels do not copy automatically into new frames	</span>
label values pathway_level pathway_vals
drop estimate_name
order male_level pathway_level outcome_level	
reshape wide prediction_, i(male_level pathway_level) j(outcome_level) 	

graph bar (asis) prediction_1 prediction_2, <span class="stcmt">///</span>
	by(pathway_level, title("Adjusted Probability of First Completion/Transfer" "by Gender") <span class="stcmt">///</span>
	b1title("Gender") imargin(medium) <span class="stcmt">///</span>
	note("Note: A regression model adjusts probabilities to account for student demographic traits, institution, and cohort. Adjusted probabilities" "for each outcome are stacked.", <span class="stcmt">///</span>
	size(vsmall)) <span class="stcmt">///</span>
	graphregion(fcolor(white))) ytitle("Adjusted Probability") <span class="stcmt">///</span>
	over(male_level) stack ylabel(0(0.2)1) legend(label(1 "Completion First") <span class="stcmt">///</span>
	label(2 "Transfer First")) xsize(5.5) bar(1, fcolor("51 34 136") lcolor(black)) <span class="stcmt">///</span>
	bar(2, fcolor("68 170 153") lcolor(black))			
graph export "${saved_graphs}/9_gender.png", replace
frame change default
frame drop working		

}

</code></pre>

#### Understanding the Chart

This chart shows how students' probability of success changes at different levels of high school GPA, disaggregated by students' race/ethnicity. Looking at the first row, we see positive associations between GPA and likelihood of completion for students in all pathways and from all racial/ethnic groups. However, there are differences across groups that highlight areas where additional scrutiny and work may be needed to offer equitable opportunities for success. For example, in IT Tech (the third graph), we see that at all points of the GPA range, White students have a higher probability of completing a credential than students of any other race/ethnicity. In Mech Repair, the slope of the line relating GPA and likelihood of completion is much steeper for White students than Black or Latina/o/x students, so while students with lower GPAs have similar probabilities of success, when we look at students with higher GPAs White students have much higher completion rates than students from any other group. This suggests institutions may not be meeting students' non-academic needs or may not be fully leveraging the academic ability of all of their students. 

<h3 id="h-1-3-9">Reflections</h3>

Importantly, while we are controlling for some student characteristics, these analyses do not control for all background characteristics (such as motivation) or structural conditions (such as systemic oppression) and thus cannot allow us to determine for certain whether differences in success outcomes are due to the programs or the students. However, these analyses should spur additional reflection and thinking around whether these results are unexpected or aligned with program goals, and discussions of whether any changes should be implemented and evaluated moving forward. For example, you may notice that differences in completion rates between pathways remain similar after controlling for student characteristics. If this is the case, it suggests that differences between students choosing those pathways are less likely to be driving differences in outcomes across pathways. This in turn means that there are likely programmatic changes or policies your institution can implement to improve student outcomes.

Discussion questions for institutional teams: 

- What are students' probabilities of success in various pathways at your institution? What surprised you about the patterns of success across pathways? 
- Does students' probability of success change when you control for background characteristics? If not, what sort of supports does your institution currently offer students to promote success? 
- What hypotheses do you have about what might be the root causes of the patterns of success you see? 

<h2 id="h-1-4">Section 2: Mapping Student Progression</h2>
<h3 id="h-1-4-1">Questions</h3>

What decisions do students make in their first three years? Are students transferring between pathways in ways that may slow their progress? 

<h3 id="h-1-4-2">Goal/Purpose</h3>

The second section of this Diagnostic pushes you to dig deeper into explanations or questions that may arise from the set of analyses in Section 1. For example, you may wonder why certain pathways have low completion rates. One possible reason could be that completion rates are related to patterns of student churn within the institution. If students are switching pathways multiple times, completion may be delayed, especially if there is little overlap in the requirements across the pathways. As the prior analyses only revealed the relationship between starting in a particular pathway and experiencing any sort of success outcome (transfer or completion of any credential), you may also be curious to know whether students in a given pathway earn a credential in that pathway or another area. This section helps you explore these questions. Specifically, at the end of the analysis described in this section, you will have a chart that illustrates students' progression in the pathway over time, from their first term of enrollment to a later term by which your institution would expect the student to achieve a successful outcome (for example, at the end of three years if studying programs that typically offer associate degrees). The number of terms or time periods included in the analysis should be tailored to your institution's context, expected duration of a program, and data availability. 

<h3 id="h-1-4-3">Reading for Context</h3>

- Bailey, T. R., Jaggars, S. S., & Jenkins, D. (2015). Redesigning America's community colleges: A clearer path to student success. Harvard University Press.
- Scott-Clayton, J. (2011). The shapeless river: Does a lack of structure inhibit students' progress at community colleges? (CCRC Working Paper No. 25, Assessment of Evidence Series). New York, NY: Columbia University, Teachers College, Community College Research Center. 
- Holzer, Harry J. and Sandy Baum. Making College Work: Pathways to Success for Disadvantaged Students. Washington, D.C.: Brookings Institution Press, 2017.

<h3 id="h-1-4-4">Key Terms</h3>

- Credential – Associate degree, certificate, or other qualification that signifies culmination of a program of study
- Completion – Attainment of a credential of any form
- Pathway – classification of area of study most relevant to the institution, such as Classification of Instructional Programs (CIP) code or meta-major

<h3 id="h-1-4-5">Example Visualization 2.1: How do students move between pathways and towards success over time?</h3>

Our analysis shows whether students remain enrolled in their original pathway, switched to a different pathway, transferred to a four-year institution, completed any credential, or were not enrolled at the end of the examined time period. To illustrate the students' journey, we use an interactive diagram to graphically show the size of the flow of students through the six semesters and the potential outcomes observed in each semester. When you produce this chart in Python (example code will be shared separately), users can hover over any particular flow in the chart to see the exact number of students making that transition.

<div class="navbar navbar-default navbar-fixed-top" id="logo">
 <div class="container">
<img src="https://github.com/rachworsham/open_sdp_cte_toolkit/blob/806f53825f42a6c63e181a1e7e9f0c455a9ddb88/docs/narrative_img/narrative.2.1.png">
</div>
</div>
<pre id="stlog-5" class="stcmd"><code>

	<span class="stcmt">/*****************************************</span>
<span class="stcmt">	 Comments about this code</span>
<span class="stcmt">	*****************************************/</span>
	
	<span class="stcmt">// Data for this analysis code should be set up according to the accompanying data specification guide.</span>
	
	<span class="stcmt">// Code below for this analyis should be modified according to your needs. In some places, comments explicitly prompt</span>
	<span class="stcmt">// you to appropriately modify a minimum number of commands for your institution's data, or else the output may not be</span>
	<span class="stcmt">// correct or useful. And of course feel free to modify any other commands, too.	</span>
	
	<span class="stcmt">// Stata version 16 or higher is required to run the code below because of the python components. Earliear versions of</span>
	<span class="stcmt">// Stata cannot interact with python. If you do not have access to version 16, you can copy the python code to a separate </span>
	<span class="stcmt">// python script to run.</span>
	

	<span class="stcmt">/***************************************</span>
<span class="stcmt">	 Set up and setting filepaths</span>
<span class="stcmt">	***************************************/</span>
	
	version 16.1
	clear all
	macro drop all
	
	<span class="stcmt">// set path to your saved .csv data file matching spec document	</span>
	global path_to_data <span class="stcmt">///</span>
	"some_directory/perhaps_another_directory/maybe_even_one_more_directory/your_data.csv" 

	<span class="stcmt">// set path for where to save a collapsd data set that will actually be used for graphing</span>
	global path_to_save_collapsed_data <span class="stcmt">///</span>
	"some_directory/perhaps_another_directory/maybe_even_one_more_directory/collapsed_data.dta" 

		
	<span class="stcmt">/***************************************</span>
<span class="stcmt">	 Load data set up according to spec</span>
<span class="stcmt">	***************************************/</span>

	import delimited "${path_to_data}", clear
	
	
	<span class="stcmt">/***************************************</span>
<span class="stcmt">	 Create label for entry pathway codes</span>
<span class="stcmt">	***************************************</span>
<span class="stcmt">	</span>
<span class="stcmt">	//label define entry_pathway_vals 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway"</span>
<span class="stcmt">	</span>
<span class="stcmt">	//optional, leave commented out if you prefer numeric pathway </span>
<span class="stcmt">	codes be used in chart titles; otherwise, uncomment and fill out appropriately*/</span>
	
	label dir
	<span class="stcmt">// this code (regexm) will not run when the code defining entry_pathway_vals remains commented out</span>
	if regexm("`r(names)'", "entry_pathway_vals") { 
		ssc install labutil2 <span class="stcmt">// this quickly installs additional Stata commands used just below</span>
		labellist entry_pathway_vals
		local entry_pathway_vals_labels `r(entry_pathway_vals_labels)'
		local entry_pathway_vals_values `r(entry_pathway_vals_values)'
	}
	
	
	<span class="stcmt">/********************************************</span>
<span class="stcmt">	 Collapse data in prep for graphing</span>
<span class="stcmt">	********************************************</span>
<span class="stcmt">	</span>
<span class="stcmt">	// Identify the number of terms included for students in each </span>
<span class="stcmt">	initial pathway; should be equal for all students entering that pathway, </span>
<span class="stcmt">	even if multiple entering cohorts are included, </span>
<span class="stcmt">	though it can differ across initial pathways*/</span>
	
	local initial_pathways_num_terms
	levelsof pathway if cohorttermindex == 1, local(initial_pathways)
	foreach p in `initial_pathways' {
		preserve
			bys studentid (cohorttermindex): gen initial_pathway = pathway[1]
			keep if initial_pathway == `p'
			bys studentid: gen record_count = _N
			distinct record_count
			assert r(ndistinct) == 1 <span class="stcmt">// making sure that indeed each student for a specific initial pathway has same number of terms included</span>
			levelsof record_count, local(rec_count)
			drop initial_pathway record_count
		restore
		local initial_pathways_num_terms `initial_pathways_num_terms' `rec_count'
	}
	di "`initial_pathways_num_terms'"
	
	<span class="stcmt">/*Collapsing will include, within each value of initial pathway,</span>
<span class="stcmt">	a separate collapse for each semester-to-semester transition*/</span>
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
				else if `overall_counter' &gt; 1 {
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
	
	<span class="stcmt">* Label variables</span>
	label var entry_pathway <span class="stcmt">///</span>
	"pathway code associated with a student at entry"
	
	label var semester_transition <span class="stcmt">///</span>
	"the semester-to-semester transition index (max will be one less than number of semesters included for that initial pathway)"
	
	label var pathway_origin <span class="stcmt">///</span>
	"pathway code associated with a student for the origin term of a transition"
	
	label var pathway_target <span class="stcmt">///</span>
	"pathway code associated with a student for the next term of a transition"
	
	label var num_students <span class="stcmt">///</span>
	"number of students described"
	
	<span class="stcmt">* Generate a variable called entry_pathway_label, if entry_pathway_vals was set above as a label</span>
	if !missing(`"`entry_pathway_vals_values'"') &amp; !missing(`"`entry_pathway_vals_labels'"') {
	 if `: word count `entry_pathway_vals_values'' == `: word count `entry_pathway_vals_labels'' {
	   gen entry_pathway_label = ""
	   label var entry_pathway_label "pathway code label associated with a student at entry"
	   order entry_pathway_label, after(entry_pathway)
	   forvalues i = 1/`: word count `entry_pathway_vals_values'' {
	   replace entry_pathway_label = `"`: word `i' of `entry_pathway_vals_labels''"' <span class="stcmt">///</span>
	   if entry_pathway == `: word `i' of `entry_pathway_vals_values''
			}
		replace entry_pathway_label = subinstr(entry_pathway_label, `"""', "", .)
		assert !missing(entry_pathway_label)
		} 
		else {
		    di in red <span class="stcmt">///</span>
			"The number of entry pathway code values and entry pathway label values does not match."
			exit
		}
	}
	
	<span class="stcmt">* Save out collapsed data</span>
	save "${path_to_save_collapsed_data}", replace 
	
	
<span class="stcmt">/**************************************************</span>
<span class="stcmt"> Run Sankey diagrams</span>
<span class="stcmt">**************************************************/</span>

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
		if s &lt; last_trans:
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
		elif k &gt; 2:
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
		if s &lt; last_trans:
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
	if len(pathway_label_titles) &gt; 0:
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

</code></pre>

#### Understanding the Chart

This chart shows how students transition between pathways over time. Each of the blue vertical lines represents a transition point- from their initial enrollment to the end of their sixth term. The example chart focuses on students who begin enrolled in IT Tech. Most students remain enrolled in this pathway and have completed by the end of their sixth semester, although a sizeable share exits after the second and third semesters. We also see a share of students switching to other pathways, primarily Electrical Tech and Business. These students are still enrolled after six terms but have not completed a credential or transferred. 

<h3 id="h-1-4-6">Reflections and Limitations</h3>

This analysis documents students' choices regarding their enrollment over time. It does not show why students make decisions to switch pathways. In other words, we do not know whether students switching pathways have discovered they are not interested in the career the pathway leads to or whether students feel unprepared for that pathway or whether there is something in the program offerings of that pathway that make the student feel unwelcome. 
  
In addition, this analysis does not show stacking of credentials or churn between institutions. Once a student has transferred or completed a credential, that classification is carried forward for the remaining semesters of the analysis – even if the student earns additional credentials or transfers again. 

Discussion questions for institutional teams:

- What share of students are completing a credential in their original pathway? 
- When students switch pathways, are they typically switching once or moving multiple times? How closely related are the pathways students are moving between? 
- How long does it take students who do not switch between pathways reach a successful outcome? How long does it take those that do switch?
- Why do you think students might switch between pathways? When could this be beneficial and when might it be harmful? 
- What support or guidance does your institution offer students for deciding whether to switch pathways and, if students are switching, which pathway might be a good fit and how long they should expect to complete a credential in the new pathway? 
- What hypotheses do you have about what your institution could do to limit student churn between pathways?  

<h2 id="h-1-5">Section 3: Gatekeeper Courses</h2>

<h3 id="h-1-5-1">Questions</h3>

Do certain pathway classes impede students' progress towards a successful outcome? 

<h3 id="h-1-5-2">Goal/Purpose</h3>

The third section of this Diagnostic helps institutions explore another potential root cause of low student success rates by focusing on identifying challenging and consequential courses, which we refer to as gatekeeper courses. This section focuses on students' experiences in core content courses and relates those experiences to eventual outcomes. You may have noticed in the first section of the Diagnostic that completion rates are lower than desired and wonder whether students get pushed off track in their general education courses, pathway-specific content courses, or in other areas. Your institution may wonder whether introductory math courses, for example, present a roadblock to students in a nursing program. This section presents analyses that will help you illustrate these trends. By examining these trends and understanding where course failure strongly predicts a reduced likelihood of completion and which courses are failed by large groups of students, institutions and programs can be strategic in thinking through what courses may need to offer students additional academic support or test new instructional methods to help students succeed. As descriptive analyses, results from this section will not show whether certain instructors are more effective than others, or whether failing certain classes cause students to exit without earning a credential or are simply a sign of trouble elsewhere. Instead, they highlight courses that are stumbling blocks for students, which can then inform further inquiry into what practices or supports could help students succeed.

<h3 id="h-1-5-3">Reading for Context</h3>

- Bahr (2011). Deconstructing Remediation in Community Colleges: Exploring Associations Between Course-Taking Patterns, Course Outcomes, and Attrition from the Remedial Math and Remedial Writing Sequences. Research in Higher Education, 53, 661-693. https://doi.org/10.1007/s11162-011-9243-2 

<h3 id="h-1-5-4">Key Terms</h3>

- Credential – Associate degree, certificate, or other qualification that signifies culmination of a program of study
- Completion – Attainment of a credential of any form
- Pathway – classification of area of study most relevant to the institution, such as Classification of Instructional Programs (CIP) code or meta-major 

<h3 id="h-1-5-5">Example Visualization 3.1: Which courses represent the biggest impediments to success? </h3>

This analysis identifies courses that are important for students to complete a pathway. For our analysis, we focused on core content classes in the student's pathway as well as general education classes. You could define the set of potential gatekeeper courses differently; for example, looking specifically at courses required for a credential in a particular pathway. We create an interactive scatterplot that plots the share of students failing a course against the change in probability of completing a credential if the course is failed compared to passed. The size of each point reflects the number of students attempting the course. When interpreting this chart, we can think of large points with a high failure rate and a large associated decrease in probability of completion (e.g., a large point in the top right of the graph) as the most concerning from a student success perspective. When you create this in Python (sample code included separately), you'll have an interactive chart that allows you to scroll over an individual point and see the course title, number of attempters, and the probabilities of completion conditional on passing or failing. Example Visualization 3.1 provides a still image of the interactive chart.

<div class="navbar navbar-default navbar-fixed-top" id="logo">
 <div class="container">
<img src="https://github.com/rachworsham/open_sdp_cte_toolkit/blob/806f53825f42a6c63e181a1e7e9f0c455a9ddb88/docs/narrative_img/narrative.3.1.png">
</div>
</div>
<pre id="stlog-6" class="stcmd"><code>

	<span class="stcmt">/*****************************************</span>
<span class="stcmt">	 Comments about this code</span>
<span class="stcmt">	*****************************************/</span>
	
	<span class="stcmt">// Data for this analysis code should be set up according to the accompanying data specification guide.</span>

	<span class="stcmt">// Code below for this analyis should be modified according to your needs. In some places, comments explicitly prompt</span>
	<span class="stcmt">// you to appropriately modify a minimum number of commands for your institution's data, or else the output may not be</span>
	<span class="stcmt">// correct or useful. And of course feel free to modify any other commands, too.	</span>
	
	<span class="stcmt">// Stata version 16 or higher is required to run the code below because of the python components. Earliear versions of</span>
	<span class="stcmt">// Stata cannot interact with python. If you do not have access to version 16, you can copy the python code to a separate </span>
	<span class="stcmt">// python script to run.	</span>
	
	
	<span class="stcmt">/***************************************</span>
<span class="stcmt">	 Set up and setting filepaths</span>
<span class="stcmt">	***************************************/</span>
	
	version 16.1
	clear all
	macro drop all		
	
	<span class="stcmt">// set path to your saved .csv data file matching spec document</span>
	global path_to_data <span class="stcmt">///</span>
	"some_directory/perhaps_another_directory/maybe_even_one_more_directory/your_data.csv" 
	
	<span class="stcmt">// set path to where you'd like to save an intermediate .dta data file before final analysis</span>
	global graph_ready <span class="stcmt">///</span>
	"some_directory/perhaps_another_directory/maybe_even_one_more_directory/graph_ready.dta" 
	
	
	<span class="stcmt">/***************************************</span>
<span class="stcmt">	 Load data set up according to spec</span>
<span class="stcmt">	***************************************/</span>

	import delimited "${path_to_data}", clear
	
	
	<span class="stcmt">/***************************************</span>
<span class="stcmt">	 Create label for entry pathway codes</span>
<span class="stcmt">	***************************************	</span>
<span class="stcmt">	</span>
<span class="stcmt">	//label define entry_pathway_vals </span>
<span class="stcmt">	0 "General" 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway" </span>
<span class="stcmt">	</span>
<span class="stcmt">	//optional, leave commented out if you prefer numeric pathway codes </span>
<span class="stcmt">	be used in chart titles; otherwise, uncomment and fill out appropriately*/</span>
	
	label dir
	<span class="stcmt">// this code will not run when the code defining entry_pathway_vals remains commented out</span>
	if regexm("`r(names)'", "entry_pathway_vals") { 
		ssc install labutil2 <span class="stcmt">// this quickly installs additional Stata commands used just below</span>
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
		    di in red <span class="stcmt">///</span>
			"The number of entry pathway code values and entry pathway label values does not match."
			exit
		}		
	}
	save "${graph_ready}", replace <span class="stcmt">// if entry_pathway_vals is not uncommented and set above, then this save command just re-saves the intial data, unmodified, as a .dta file</span>
	
	
	<span class="stcmt">/*************************************</span>
<span class="stcmt">	 Chart set up</span>
<span class="stcmt">	*************************************/</span>
	
<span class="stcmt">* Plotly Scatterplot with tooltip hover</span>
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
	if np.amin(df_display['prob_completer_diff']) &lt; 0:
		y_min = np.amin(df_display['prob_completer_diff']) - 0.02
	else:
		y_min = 0
	if np.amax(df_display['prob_completer_diff']) &lt; 0.5:
		y_max = 0.5
	else:
		y_max = np.amax(df_display['prob_completer_diff']) + 0.02
	x_min = 0 # cannot have less than 0% of students fail a course
	if np.amax(df_display['proportion_failing']) &lt; 0.6:
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
	if len(pathway_label_titles) &gt; 0:
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
	if y_min &lt; 0:
		fig.add_hline(y=0, line_color="black", opacity = 1)

	# Append chart to list
	charts.append(fig)
	
# Render all the charts
for g in charts:
	g.show()
						   
end
	
</code></pre>

#### Understanding the Chart

This chart shows the extent to which students in the IT Tech pathway may be impeded by gatekeeper courses. In the scatterplot, we see that a number of courses associates with IT Tech (for example, courses in the IT department) have failure rates above 40% and that in most cases course failure is related to a change in likelihood of completion of 20 percentage points or more. These size of the points indicate that many students in the pathway are attempting these courses, so large groups of students may be derailed by these courses. 

<h3 id="h-1-5-6">Reflections and Limitations</h3>

Note that this analysis includes both developmental and transfer-level courses. By examining which courses have high rates of failure and  association with a large decrease in the probability of completion given failure, your institution or system will be able to identify trends in the types of courses that appear act as barriers to student success. While this analysis cannot tell us for certain whether the course itself is challenge, it can help your institution or system develop further lines of inquiry into where students are struggling and how instructional practices, student services, or other structures could be leveraged to best support student success.  

Discussion questions for institutional teams: 

- Which courses at your institution have high failure rates? In which classes is failure most consequential for student success? Which courses have both high failure rates and large associations with negative outcomes? 
- What is the format of these gatekeeper courses (lectures, labs, etc.)? What supports do students have access to when enrolled in these courses? 
- Do students make use of on-campus academic support services like tutoring? If not, what might be some barriers preventing students from utilizing these resources? 
- What are the characteristics of students enrolling in these gatekeeper courses? Are there differences in failure rates across student subgroups? 
- What hypotheses do you have about how to improve course success rates? To make any given course less consequential for students' overall success? To make patterns of course success rates equitable?

<h2 id="h-1-6">Section 4: Credit Accumulation</h2>

<h3 id="h-1-6-1">Questions</h3>

How do students accumulate credits in their pathway over time? How do students' early experiences of attempting and earning credits relate to their longer-term success?

<h3 id="h-1-6-2">Goal/Purpose</h3>

In the final section this Diagnostic, we dive into analyses that will help your institution better understand students' momentum in their chosen pathway over time. For example, if your institution notices that completion rates are lower than desired, you may wonder whether the problem is that students are exiting the program completely or that students are accumulating credits slowly and are not able to fulfill credential requirements in a timely manner. This section prompts you to create three visualizations related to credit accumulation and early momentum. The first visualization shows average college-level credits attempted and accumulated in each term across pathways to highlight whether students are attempting and accumulating credits at a pace that will allow them to complete a credential within a desired timeframe. By juxtaposing credits attempted and earned, this analysis will also help you identify whether the challenge seems to be one of encouraging students to enroll in more courses or helping students to succeed in those classes. The second visualization shows how students' trajectories vary by students' momentum in their first term. This shows the potential importance of students' success early in their academic career for their continued progress. Finally, the third visualization shows the relationship between the number of credits earned in students' first semester and success outcomes after six terms. This analysis serves to further illustrate the importance of early momentum and can help you identify terms when it is critical to provide students with additional academic support to maintain their progress. As with all the analyses in this Diagnostic, you may want adapt the timeframes and success outcomes examined in this section to make them relevant to your context.

<h3 id="h-1-6-3">Reading for Context</h3>

- Belfield, Jenkins, & Fink (2019). Early momentum metrics: Leading indicators for community college improvement. https://ccrc.tc.columbia.edu/media/k2/attachments/early-momentum-metrics-leading-indicators.pdf 

<h3 id="h-1-6-4">Key Terms</h3>

- Credential – Associate degree, certificate, or other qualification that signifies culmination of a program of study
- Completion – Attainment of a credential of any form
- Pathway – Classification of area of study most relevant to the institution, such as Classification of Instructional Programs (CIP) code or meta-major
- Credit accumulation – Credit hours earned
- Credential threshold – Accumulation of credits based on timely progression towards completion (for example, 60 credits for an associate degree in 2 years)

<h3 id="h-1-6-5">Example Visualization 4.1: On average, are students attempting and earning credits at a pace necessary to complete a credential in a reasonable timeframe?</h3>

In the first visualization of this section, we show the average number of credits attempted and earned by students in a given pathway. This analysis is helpful if you notice that your institution has low success rates but are not sure whether the barrier to success is students not enrolling in enough courses or students not passing their courses and accumulating credits. You can see from these line graphs if the slope of the `credits attempted' line is steep enough to allow students to earn a credential within a given timeframe (for example, whether students are on pace to attempt 60 credits by the end of their sixth term) as well as to see the difference between the number of college-level credits students are attempting and the number of college-level credits students are earning. As the gap between the two lines grows, the more you may think that the challenge for your institution is providing adequate academic support so that students can pass their courses. If the `credits attempted' line is flat or not steep enough to reach a given threshold for a credential, your institution may want to examine what information and guidance students are receiving about graduation requirements and recommended credit loads per term. 

<div class="navbar navbar-default navbar-fixed-top" id="logo">
 <div class="container">
<img src="https://github.com/rachworsham/open_sdp_cte_toolkit/blob/806f53825f42a6c63e181a1e7e9f0c455a9ddb88/docs/narrative_img/narrative.4.1.png">
</div>
</div>
<pre id="stlog-7" class="stcmd"><code>
<span class="stcmt">/*****************************************</span>
<span class="stcmt"> Comments about this code</span>
<span class="stcmt">*****************************************/</span>

<span class="stcmt">// Data for this analysis code should be set up according to the accompanying data specification guide.</span>

<span class="stcmt">// Code below for this analyis should be modified according to your needs. In some places, comments explicitly prompt</span>
<span class="stcmt">// you to appropriately modify a minimum number of commands for your institution's data, or else the output may not be</span>
<span class="stcmt">// correct or useful. And of course feel free to modify any other commands, too.	</span>

<span class="stcmt">// Stata version 16 or higher is required to run the code below because of the frames commands. Earliear versions of</span>
<span class="stcmt">// Stata do not allow for different frames. If you do not have access to version 16, you can modify the appropriate </span>
<span class="stcmt">// commands to use tempfiles instead and achieve a similar result.				</span>
	
	
<span class="stcmt">/***************************************</span>
<span class="stcmt"> Set up and setting filepaths</span>
<span class="stcmt">***************************************/</span>

version 16.1
clear all
macro drop all		

<span class="stcmt">// set path to your saved .csv data file matching spec document</span>
global path_to_data <span class="stcmt">///</span>
"some_directory/perhaps_another_directory/maybe_even_one_more_directory/your_data.csv" 

<span class="stcmt">// set path for where you'd like graphs saved on your computer		</span>
global saved_graphs <span class="stcmt">///</span>
"some_directory/perhaps_another_directory/finally_the_directory_where_you_would_like_your_graphs_saved"
	
	
<span class="stcmt">/***************************************</span>
<span class="stcmt"> Load data set up according to spec</span>
<span class="stcmt">***************************************/</span>

import delimited "${path_to_data}", clear		
	
	
<span class="stcmt">/********************************************</span>
<span class="stcmt"> Generate and label an entry pathway</span>
<span class="stcmt">********************************************/</span>	

<span class="stcmt">* Generate an entry pathway code for each student</span>
bys studentid (cohorttermindex): gen entry_pathway = pathway[1]
label var entry_pathway "pathway code associated with a student at entry"	

<span class="stcmt">* Label pathway</span>
<span class="stcmt">// this is just a placeholder example; please modify with the full names associated with each entry pathway code at your institution</span>
label define pathway_entry_vals 1 "Some Pathway" 2 "Another Pathway" 3 "One More Pathway" 
label values pathway pathway_entry_vals		

	
<span class="stcmt">/***************************************************************</span>
<span class="stcmt"> A few additional calculations to complement initial data file</span>
<span class="stcmt">***************************************************************/</span>	
	
<span class="stcmt">* Generate cumulative college-level credits earned by term</span>
bys studentid (cohorttermindex): gen cumcollegecreditsearned = sum(collegecreditsearned)
label var cumcollegecreditsearned "cumulative college-level credits earned by a student term to term"

<span class="stcmt">* Generate cumulative credits earned by term</span>
bys studentid (cohorttermindex): gen cumcreditsearned = sum(creditsearned)
label var cumcreditsearned "cumulative credits earned by a student term to term, whether college-level or developmental credits"

<span class="stcmt">* Generate cumulative college-level credits attempted by term</span>
bys studentid (cohorttermindex): gen cumcollegecreditsattempted = sum(collegecreditsattempted)
label var cumcollegecreditsattempted "cumulative college-level credits attempted by a student term to term"

<span class="stcmt">* Determine number of terms included in data for each student</span>
sum cohorttermindex
global max_term = r(max)	

<span class="stcmt">* Generate ideal credits earned and cumulative credits earned amounts</span>
gen idealcreditsearned = 0
label var idealcreditsearned "ideal number of credits a student would earn each term"
replace idealcreditsearned = 15 if inrange(cohorttermindex, 1, 4)
bys studentid (cohorttermindex): gen cumidealcreditsearned = sum(idealcreditsearned)
label var cumidealcreditsearned "cumulative ideal number of credits a student would have earned each term"

<span class="stcmt">* Code in an indicator for a terminating event (first completion or first transfer)</span>
gen terminating = inlist(pathway, 100, 101)	
label var terminating "indicator for a terminating event: first completion or transfer"




<span class="stcmt">/*******************************************</span>
<span class="stcmt"> Create cumulative credit charts</span>
<span class="stcmt">*******************************************/</span>

<span class="stcmt">* Avg. college-level cumulative credits attempted vs. earned</span>
preserve

collapse (mean) cumcollegecreditsearned cumcollegecreditsattempted cumidealcreditsearned, by(entry_pathway cohorttermindex)

twoway (line cumcollegecreditsearned cohorttermindex, lcolor("51 34 136")) <span class="stcmt">/// // colors specifically chosen to be colorblind accessible</span>
	   (line cumcollegecreditsattempted cohorttermindex, lcolor("68 170 153") lpattern(dash)) <span class="stcmt">///</span>
	   (line cumidealcreditsearned cohorttermindex, lcolor("136 34 85")), <span class="stcmt">///</span>
	   by(entry_pathway, graphregion(fcolor(white)) imargin(medium) <span class="stcmt">///</span>
	   title("Average Cumulative College-Level Credits" "Attempted vs. Earned") <span class="stcmt">///</span>
	   note("Note: College-level credit counts exclude developmental coursework.", size(vsmall))) <span class="stcmt">///</span>
	   legend(label(1 "Earned") label(2 "Attempted") label(3 "On-Track")) <span class="stcmt">///</span>
	   yline(0, lcolor(black)) plotregion(margin(zero)) <span class="stcmt">///</span>
	   ytitle("Avg. Cumulative College-Level Credits") <span class="stcmt">///</span>
	   xtitle("Cohort Term") ylabel(0(15)60) xlabel(1(1)${max_term})

graph export "${saved_graphs}/1_avg_cum_college-level_credits_attempted_vs_earned.png", replace

restore	

</code></pre>

#### Understanding the Chart

This chart shows that, across pathways, students are not attempting or accumulating credits at a pace that would allow them to complete an associate degree within two years, even though we saw in Section 1 that most students are pursuing an associate degree. The top line in each of the plots shows the pace at which students need to accumulate credits in order to complete an associate degree in two years; the dotted line shows how many credits student are attempting, on average, and the bottom line shows average credit accumulation. Looking at Health, for example, we see that students are attempting enough credits to be able to earn an associate degree in three years, but that credit accumulation is much slower. This suggests that the pathway may want to consider offering additional academic support to help students earn credits in the courses they attempt. 

<h3 id="h-1-6-6">Example Visualization 4.2: How do students' trajectories of college-level credit accumulation vary by their initial college-level credit accumulation?</h3>

In the second visualization, we examine the importance of early momentum for longer-term credit accumulation. This visualization shows differences in the pace of college-level credit accumulation across students based on how many college-level credits they earned in their first term. The closer the lines are to each other, the less consequential early credit accumulation would seem to be. This type of analysis can help highlight whether students who accumulate few college-level credits in their first term may need additional support to reach a successful outcome. 

<div class="navbar navbar-default navbar-fixed-top" id="logo">
 <div class="container">
<img src="https://github.com/rachworsham/open_sdp_cte_toolkit/blob/806f53825f42a6c63e181a1e7e9f0c455a9ddb88/docs/narrative_img/narrative.4.2.png">
</div>
</div>
<pre id="stlog-8" class="stcmd"><code>

<span class="stcmt">* Avg. college-level cumulative credits earned by early momentum</span>
preserve

sum cumcollegecreditsearned if cohorttermindex == 1, detail
scalar p25 = r(p25)
scalar p75 = r(p75)

gen bin = 0
replace bin = 1 if cohorttermindex == 1 &amp; cumcollegecreditsearned &lt;= p25
replace bin = 2 if cohorttermindex == 1 &amp; (cumcollegecreditsearned &gt; p25 &amp; cumcollegecreditsearned &lt;= p75)
replace bin = 3 if cohorttermindex == 1 &amp; cumcollegecreditsearned &gt; p75
bys studentid (cohorttermindex): replace bin = bin[1]
assert !missing(bin)
label define early_credits_bin 1 "&lt; 25th Percentile" 2 "25th - 75th Percentile" 3 "&gt; 75th Percentile"
label values bin early_credits_bin

collapse (mean) cumcollegecreditsearned, by(entry_pathway cohorttermindex bin)

twoway (line cumcollegecreditsearned cohorttermindex if bin == 1, lcolor("51 34 136")) <span class="stcmt">///</span>
       (line cumcollegecreditsearned cohorttermindex if bin == 2, lcolor("68 170 153")) <span class="stcmt">///</span>
	   (line cumcollegecreditsearned cohorttermindex if bin == 3, lcolor("136 34 85")), <span class="stcmt">///</span>
	   by(entry_pathway, title("Average College-Level Credit Accummulation" "by Entry Term College-Level Credits Earned") <span class="stcmt">///</span>
	   graphregion(fcolor(white)) note("Note: College-level credit counts exclude developmental coursework.", size(vsmall)) <span class="stcmt">///</span>
	   imargin(medium)) xtitle("Cohort Term") ytitle("Avg. College-Level Credit Accumulation") <span class="stcmt">///</span>
	   legend(title("Entry Term College-Level Credits Earned Percentile", <span class="stcmt">///</span>
	   size(small)) label(1 "&lt; 25th") label(2 "25th - 75th") label(3 "&gt; 75th")) <span class="stcmt">///</span>
	   xlabel(1(1)${max_term}) yline(0, lcolor(black)) plotregion(margin(zero))
	   
graph export "${saved_graphs}/2_avg_cum_college-level_credits_by_early_momentum.png", replace

restore

</code></pre>

#### Understanding the Chart

This chart demonstrates the importance of early credit accumulation for students' trajectories over their first six terms. For all pathways examined, we see that students who earned the most credits in their first semester have much steeper rates of credit accumulation throughout their first three years than students who earned fewer credits in their first term. We see only small differences between students in above the 75th percentile of credit accumulation and students between the 25th and 75th percentiles, indicating that students do not necessarily need to earn as many credits as possible in their first term, but should experience some early success in their courses. 

<h3 id="h-1-6-7">Example Visualization 4.3: How does students' success in their first semester predict their longer-term success?</h3>

In the third and final visualization of this section, we plot the share of students who experience a successful outcome within six terms of entering a pathway against the number of credits they earned in their first term. This analysis can highlight the importance of early momentum in predicting longer-term success and help institutions identify whether they might want to provide additional support to students who earn a limited number of credits in their first term.

<div class="navbar navbar-default navbar-fixed-top" id="logo">
 <div class="container">
<img src="https://github.com/rachworsham/open_sdp_cte_toolkit/blob/806f53825f42a6c63e181a1e7e9f0c455a9ddb88/docs/narrative_img/narrative.4.3.png">
</div>
</div>
<pre id="stlog-9" class="stcmd"><code>

<span class="stcmt">/******************************************************</span>
<span class="stcmt"> Create completer/transfer rate charts</span>
<span class="stcmt">******************************************************/</span>		

<span class="stcmt">* Data set up for completion/transfer rates by college-level credits earned</span>
cap frame drop complete_trans_entry_college_credits
frame copy default complete_trans_college_credits
frame change complete_trans_college_credits
drop if cumcollegecreditsearned &gt; 21 &amp; cohorttermindex == 1 <span class="stcmt">// exclude students who earned more than 21 college credits in their first term as outliers; though this threshold is somewhat arbitrary</span>
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
		replace credit_bin_in_first_term = `c' if cohorttermindex == 1 &amp; (cumcollegecreditsearned &lt;= `c')
	} 
	else {
		replace credit_bin_in_first_term = `c' if cohorttermindex == 1 &amp; (cumcollegecreditsearned &gt; `lower_bound' &amp; cumcollegecreditsearned &lt;=`c')
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

<span class="stcmt">* Data set up for completion/transfer rates by credits earned in first term, whether credits were college-level or not</span>
cap frame drop complete_trans_credits
frame copy default complete_trans_credits
frame change complete_trans_credits
drop if cumcreditsearned &gt; 21 &amp; cohorttermindex == 1 <span class="stcmt">// exclude students who earned more than 21 college credits in their first term as outliers; though this threshold is somewhat arbitrary</span>
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
		replace credit_bin_in_first_term = `c' if cohorttermindex == 1 &amp; (cumcreditsearned &lt;= `c')
	} 
	else {
		replace credit_bin_in_first_term = `c' if cohorttermindex == 1 &amp; (cumcreditsearned &gt; `lower_bound' &amp; cumcreditsearned &lt;=`c')
	}
	local lower_bound = `c'
}
table credit_bin_in_first_term if cohorttermindex == 1, c(min cumcreditsearned max cumcreditsearned)
bys studentid: egen any_terminating = max(terminating)
bys studentid (cohorttermindex): replace credit_bin_in_first_term = credit_bin_in_first_term[1]
collapse (mean) any_terminating, by(entry_pathway credit_bin_in_first_term)
gen credit_type = "any"

<span class="stcmt">* Combine data sets for completion/transfer rates by both credit types in first term: any credit and college-level credit</span>
append using `college_credits'

<span class="stcmt">* Completion/transfer rates by pathway and first-term credit-type bins</span>
twoway (line any_terminating credit_bin_in_first_term <span class="stcmt">///</span>
	if credit_type == "any", lcolor("51 34 136")) <span class="stcmt">///</span>
	   (line any_terminating credit_bin_in_first_term <span class="stcmt">///</span>
	   if credit_type == "college-level", lcolor("68 170 153")), <span class="stcmt">///</span>
	   by(entry_pathway, graphregion(fcolor(white)) <span class="stcmt">///</span>
	   title("First Completion/Transfer Rates by Pathway" "and Entry Term Credits Earned") <span class="stcmt">///</span>
	   imargin(medium) <span class="stcmt">///</span>
	   note("Note: Credits earned in the first term are grouped into three-credit intervals, labeled by the maximum of the interval. Developmental" "credits are included in the Any Credits sum, but not the College-Level sum.", <span class="stcmt">///</span>
	   size(vsmall))) xtitle("Credits Earned in First Term") <span class="stcmt">///</span>
	   ytitle("3 Yr. First Completion/Transfer Rate") ylabel(0(0.2)1.05) <span class="stcmt">///</span>
	   xlabel(3(3)21) plotregion(margin(zero)) yline(0, lcolor(black)) <span class="stcmt">///</span>
	   legend(label(1 "Any Credits") label(2 "College-Level Credits"))
	   
graph export "${saved_graphs}/3_student_status_at_6_terms_by_entry_term_credits_earned.png", replace


</code></pre>

#### Understanding the Chart

This chart highlights the importance of early credit accumulation in predicting longer-term credential completion. Across all pathways, we see that students who earn more credits in their first term are more likely to complete within six terms than students who earn fewer credits. For example, in the Mech Repair program shown in the bottom right panel, almost 60% of students who earn 12 college-level credits in their first semester complete a credential within six terms, compared to roughly 15% of students who earned 3 credits in their first term. While earning college-level credits is most strongly related to credential completion, earning any credits (including developmental) is positively correlated with three-year completion rates in all pathways. 

<h3 id="h-1-6-8">Reflections and Limitations</h3>

As with all the analyses in this Diagnostic, these analyses are descriptive, not causal. They should not be interpreted simply to mean that, for example, instruction is better in one pathway than another, allowing students in that pathway to accumulate credits at a faster rate. More specifically, you may notice that there are large gaps between average number of credits attempted and earned by students in a particular pathway, as shown in Chart 4.2. These patterns do not necessarily mean that Mech Repair instruction is better than Health instruction. Instead, they should be used to help guide discussions and further inquiry at your institution or system to understand what is leading to course failure and what curricular or co-curricular supports may be effective at supporting students in that pathway. 
Discussion questions for institutional teams: 

- Are students accumulating credits at the rate your institution would like? If not, is the gap related to attempting credits or earning credits attempted? 
- What sort of advising do students receive around how many credits to take per term? 
- What academic supports are offered on campus? How many students utilize these resources? 
- What relationship do you see between credit accumulation in students' first term and their longer-term success? Is this relationship stronger or weaker than you would have predicted? 
- Are additional academic support services offered to students when they first enroll? What kinds of support? 
- What hypotheses do you have about how your institution could help students accumulate credits at the rate necessary to complete a credential within the timeframe you would hope them to? 

<h2 id="h-1-7">References</h2>

Anderson, T., Kuehn, D., Eyster, L., Barnow, B., & Lerman, R. I. (2017). New evidence on integrated career pathways. Washington, DC: Urban Institute. Retrieved from: https://www.urban.org/research/publication/new-evidence-integrated-careerpathways 

Bahr (2011). Deconstructing Remediation in Community Colleges: Exploring Associations Between Course-Taking Patterns, Course Outcomes, and Attrition from the Remedial Math and Remedial Writing Sequences. Research in Higher Education, 53, 661-693. https://doi.org/10.1007/s11162-011-9243-2 

Bahr, P. R. (2016). The earnings of community college graduates in California (CAPSEE Working Paper). New York, NY: Center for Analysis of Postsecondary Education and Employment, Teachers College, Columbia University. Retrieved from: https://capseecenter.org/wpcontent/uploads/2016/12/the-earnings-of-community-collegegraduates-incalifornia.pdf. 

Bailey, T. R., Jaggars, S. S., & Jenkins, D. (2015). Redesigning America's community colleges: A clearer path to student success. Harvard University Press.

Belfield, Jenkins, & Fink (2019). Early momentum metrics: Leading indicators for community college improvement. https://ccrc.tc.columbia.edu/media/k2/attachments/early-momentum-metrics-leading-indicators.pdf

Bettinger, E., & Soliz, A. (2016). Returns to vocational credentials: Evidence from Ohio's community and technical colleges (CAPSEE Working paper). New York, NY: Center for Analysis of Postsecondary Education and Employment, Teachers College, Columbia University. Retrieved from: https://capseecenter.org/wpcontent/uploads/2016/10/returns-to-vocational-credentials.pdf. 

Hudson, L. (2018). Trends in Subbaccalaureate Occupational Awards: 2003 to 2015 (NCES 2018- 010). U.S. Department of Education. Washington, DC: National Center for Education Statistics, Institute of Education Sciences.   

Hollenbeck, K.M., & Huang, W-J. (2003). Net impact and benefit-cost estimates of the workforce development system in Washington state (Technical Report No. TR03-018). Kalamazoo, MI: W.E.

Holzer, Harry J. and Sandy Baum. Making College Work: Pathways to Success for Disadvantaged Students. Washington, D.C.: Brookings Institution Press, 2017.

Hussar, W.J., and Bailey, T.M. (2018). Projections of Education Statistics to 2026 (NCES 2018-019). U.S. Department of Education, National Center for Education Statistics, Institute of Education Sciences. Washington, DC: U.S. Government Printing Office. 

Jacob, Brian A. "Building Knowledge to Improve Degree Completion in Community Colleges." Washington, D.C.: Brookings Institution, 2018.

Jenkins, D., Zeidenberg, M., & Kienzl, G. (2009). Educational Outcomes of I-BEST, Washington State Community and Technical College System's Integrated Basic Education and Skills Training Program: Findings from a Multivariate Analysis (CCRC Working Paper 16). New York, NY: Community College Research Center, Teachers College, Columbia University. Retrieved from: https://ccrc.tc.columbia.edu/media/k2/attachments/educationaloutcomes-of-i-best.pdf. 

Kurlaender, M., Huff-Stevens, A., & Gros, M. (2015, April). Career technical education and labor market outcomes: Evidence from California community colleges (Working Paper 21137). Cambridge, MA: National Bureau of Economic Research. 

McMurtrie, B. (2018) "Georgia State U. Made Its Graduation Rate Jump. How?" Chronicle of Higher Education, May 25. Retrieved from https://www.chronicle.com/article/Georgia-State-U-MadeIts/243514 National Center for Education Statistics, 

U.S. Department of Education. (2018). Participants in Subbaccalaureate Occupational Education: 2012. Stats in Brief. June 2018 Retrieved from the National Center for Education Statistics Website: https://nces.ed.gov/pubs2018/2018149.pdf 

National Center for Education Statistics, U.S. Department of Education. (2018). Participants in Subbaccalaureate Occupational Education: 2012. Stats in Brief. June 2018 Retrieved from the National Center for Education Statistics Website: https://nces.ed.gov/pubs2018/2018149.pdf

Parnell, A., Jones, D., Wesaw, A., & Brooks, D.C. (2018). Institutions' Use of Data Analytics for Student Success: Results from a National Landscape Analysis. NASPA–Student Affairs Administrators in Higher Education, the Association for Institutional Research, and EDUCAUSE. Retrieved from https://library.educause.edu/~/media/files/library/2018/4/useofdata2018report.pdf 

Scott-Clayton, J. (2011). The shapeless river: Does a lack of structure inhibit students' progress at community colleges? (CCRC Working Paper No. 25, Assessment of Evidence Series). New York, NY: Columbia University, Teachers College, Community College Research Center. 

Xu, D., & Trimble, M. (2016). What about certificates? Evidence on the labor market returns to nondegree community college awards in two states. Educational Evaluation and Policy Analysis 38(2): 272-292.

#### *This guide was originally created by the Strategic Data Project.*

</div>
</div>
</div>
<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</body>
</html>
