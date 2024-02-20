# ******************************************************************************
#   Section 1 Code
# ******************************************************************************
  
# ******************************************************************************
#   Comments about this code
# ******************************************************************************

# The code in this section was converted from Stata to R and closely matches 
# the Stata version.

# See the first section of code for required libraries and packages. This code
# tested in R version 4.3.1 / RStudio version 2023.09.0+463 
# (Latest available in October 2023)

# Data for this analysis code should be set up according to the accompanying data 
# specification guide.
 
 	
# ******************************************************************************
# 	 Set up 
# ******************************************************************************
	
# Clear environment
rm(list=ls())

# In the directory where you have the R Project file, ensure there is a folder 
# called "data" and a folder called "graphs" or change the names for these
# folders below
data_path <- file.path("data", "cte_sample_data.csv") # set path to your saved .csv data file matching spec document
saved_graphs <-	"graphs" # set path (folder) for where you'd like graphs saved on your computer

# Load required packages
packages<-c("tidyverse", "ggplot2", "nnet", "marginaleffects", "ggh4x")
# If required packages are not yet installed, uncomment the line below to install them
#lapply(packages, install.packages, character.only = TRUE)
lapply(packages, require, character.only = TRUE)

# ******************************************************************************
#   Load data set up according to spec
# ******************************************************************************
   
#   import delimited "${path_to_data}"
cte_data <- read.csv(data_path)

# ******************************************************************************
#   Label variables as relevant to institution
# ******************************************************************************

#  Male
cte_data$male <- factor(cte_data$male, levels=c(0,1),
               labels=c("Female", "Male"))
table(cte_data$male)

# Race/ethnicity
cte_data$race <- factor(cte_data$race, levels=c(1,2,3,4,5),
                        labels=c("Asian", "Black", "Hispanic", "White","Other"))
table(cte_data$race)

# Mother's Education level
cte_data$motheredlevel <- factor(cte_data$motheredlevel, levels=c(1,2,3,4),
                        labels=c("Middle Sch", "High Sch", "Any College", "NA"))
table(cte_data$motheredlevel)


# ******************************************************************************
#   Generate additional variables
# ******************************************************************************

# Determine number of terms included in data for each student
max_term <- max(cte_data$cohorttermindex)		

# Outcome variable at the student level, across terms
# Note: After a numeric variable is converted to a factor, you must refer
# to the label for the code not the code itself (e.g. "Completed" rather than "100")
cte_data <- cte_data %>%
  mutate(outcome = 0) %>%
  mutate(outcome = ifelse(pathway == 100, 1, outcome)) %>%
  mutate(outcome = ifelse(pathway == 101, 2, outcome)) %>%
  group_by(studentid) %>%
  mutate(outcome = max(outcome)) %>%
  ungroup() 

# Label the outcome variable
cte_data$outcome <- factor(cte_data$outcome, levels=c(0,1,2),
                           labels=c("None", "Completion", "Transfer"))
table(cte_data$pathway, cte_data$outcome)

# Code in an indicator for a terminating event (first completion or first transfer)
cte_data <- cte_data %>%
  mutate(terminating = ifelse(pathway == 100 | pathway == 101, 1, 0))
 
# Generate an indicator for non-enrollment
cte_data <- cte_data %>%
  mutate(nonenrolled = ifelse(pathway == 99, 1, 0))

# Generate an entry pathway code for each student
cte_data <- cte_data %>%
  mutate(entry_pathway = ifelse(cohorttermindex==1, pathway, 0)) %>%
  group_by(studentid) %>%
  mutate(entry_pathway = max(entry_pathway)) %>%
  ungroup()
 
# Label entry pathways
cte_data$entry_pathway <- factor(cte_data$entry_pathway, levels=c(1,2,3,4),
                           labels=c("Engineer Tech", "Health", "IT Tech", "Mech Repair"))
table(cte_data$entry_pathway)

# Create a student-level dataset using the first entry for each student
cte_data_stu <- cte_data %>%
  filter(cohorttermindex==1)
table(cte_data_stu$pathway, cte_data_stu$outcome)

# Label the original pathway variable
# Note: When R turns numeric variables into factors, it converts the underlying 
# numbers to integers starting with 1. It does not retain the original numeric values.
# For this reason, we wait until the end of the cleaning code to label the pathway 
# variable so that we can refer to the numeric values during cleaning rather
# than the labels (e.g We can use "100," not "Completed")
cte_data$pathway <- factor(cte_data$pathway, levels=c(1,2,3,4,99,100,101),
                           labels=c("Engineer Tech", "Health", "IT Tech", "Mech Repair", "Not enrolled", "Completed", "Transferred"))
table(cte_data$pathway)

# And now we label the pathway variable in the student-level dataset
# This is done separately because there cannot be empty factor levels for 
# a variable.
cte_data_stu$pathway <- factor(cte_data_stu$pathway, levels=c(1,2,3,4),
                           labels=c("Engineer Tech", "Health", "IT Tech", "Mech Repair"))
table(cte_data_stu$pathway)
 
# Here is an example student to look at in the data
# Student ID = 3
# He graduated after three terms.
cte_data_example <- cte_data %>%
  select(studentid, cohorttermindex, entry_pathway, pathway, outcome, male) %>%
  filter(studentid==3)
View(cte_data_example)
# Example: Individual level data
cte_data_example_stu <- cte_data_example %>%
  filter(cohorttermindex==1)
View(cte_data_example_stu)

# /**********************************
#   Run regressions and plot margins
# **********************************/		

# Model: outcomes conditional only on initial pathway choice
# We only need to run the regression with the first entry for each student
model_pathway <- multinom(outcome ~ pathway, data = cte_data_stu, Hess = TRUE)
model_pathway_margins <- predictions(model_pathway, by="pathway")
model_pathway_margins <- model_pathway_margins %>%
  filter(group != "None") %>%
  mutate(outcome = ifelse(group=="Completion", 1, 2))
model_pathway_margins$outcome <- factor(model_pathway_margins$outcome, levels=c(1,2),
                                      labels=c("Completion First", "Transfer First")) 

# Chart 1a: Probability of Completion First or Transferring First by Pathway
ggplot(model_pathway_margins, aes(fill = forcats::fct_rev(outcome), y=estimate, x=pathway)) +
  geom_bar(position="stack", stat="identity", width = 0.8) +
  scale_fill_manual("", 
                    breaks = c("Completion First", "Transfer First"),
                    values = c(rgb(51, 34, 136, maxColorValue = 255), 
                               rgb(68, 170, 153, maxColorValue = 255))) +
  scale_y_continuous(name="Probability", limits=c(0,1), breaks = seq(0, 1, by = 0.2)) +
  labs(
    title = "Probability of Completion First or Transferring First \n by Pathway",
    y = "Probability"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.title = element_blank(),
    legend.position="bottom",
    axis.title.x = element_blank(),
    axis.text.x=element_text(size=10),
    legend.text = element_text(size = 10),
    panel.grid.major.x = element_blank()
  ) 
dev.copy(png,filename=file.path(saved_graphs, "visualization_1a.png"));
dev.off ();

# Chart 2: Adjusted Probability of Completion First or Tranferring First by Pathway
model_full <- multinom(outcome ~ hsgpa + mi_hsgpa + hsgpa*pathway + 
                     male + male*pathway + motheredlevel + motheredlevel*pathway +
                     pell + mi_pell + pell*pathway +
                     race + race*pathway + pathway, 
                   data = cte_data_stu, Hess = TRUE)
model_full_pathway_margins <- predictions(model_full, by="pathway")
model_full_pathway_margins <- model_full_pathway_margins %>%
  filter(group != "None") %>%
  mutate(outcome = ifelse(group=="Completion", 1, 2))
model_full_pathway_margins$outcome <- factor(model_full_pathway_margins$outcome, levels=c(1,2),
                                        labels=c("Completion First", "Transfer First")) 

ggplot(model_full_pathway_margins, aes(fill = forcats::fct_rev(outcome), y=estimate, x=pathway)) +
  geom_bar(position="stack", stat="identity", width = 0.8) +
  scale_fill_manual("", 
                    breaks = c("Completion First", "Transfer First"),
                    values = c(rgb(51, 34, 136, maxColorValue = 255), 
                               rgb(68, 170, 153, maxColorValue = 255))) +
  scale_y_continuous(name="Probability", limits=c(0,1), breaks = seq(0, 1, by = 0.2)) +
  labs(
    title = "Adjusted Probability of Completion First or Transferring First \n by Pathway",
    y = "Probability"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.title = element_blank(),
    legend.position="bottom",
    axis.title.x = element_blank(),
    axis.text.x=element_text(size=10),
    legend.text = element_text(size = 10),
    panel.grid.major.x = element_blank()
  ) 
dev.copy(png,filename=file.path(saved_graphs, "visualization_1b.png"));
dev.off ();

# Visualization 1c: High school GPA + Race + Pathway margins
model_full_hsgpa_margins <- predictions(
  model_full,
  newdata = datagrid(pathway = unique, race = unique, hsgpa = seq(2, 4, 0.25)))

model_full_hsgpa_margins <- model_full_hsgpa_margins %>%
  filter(group != "None") %>%
  mutate(outcome = ifelse(group=="Completion", 1, 2))
model_full_hsgpa_margins$outcome <- factor(model_full_hsgpa_margins$outcome, levels=c(1,2),
                                             labels=c("Completion First", "Transfer First")) 

group.colors <- c(rgb(51, 34, 136, maxColorValue = 255), 
                  rgb(136, 34, 85, maxColorValue = 255), 
                  rgb(68, 170, 153, maxColorValue = 255), 
                  rgb(136, 204, 238, maxColorValue = 255), 
                  rgb(204, 102, 119, maxColorValue = 255))

ggplot(model_full_hsgpa_margins, aes(hsgpa, estimate, group=race, color=race)) +
  geom_smooth(method = "lm", formula = y ~ poly(x, 2), se = FALSE) + 
  scale_color_manual(values=group.colors) +
  facet_grid2(vars(outcome), vars(pathway), axes = "all", remove_labels = "y") + 
  labs(
    title = "Adjusted Probability of Completion First or Transfer First \n by High School GPA and Race",
    x = "High School GPA",
    y = "Probability",
    fill = "Race"
  ) +
  theme_minimal() +
  theme(
    legend.position = "right",
    legend.title = element_blank(),
    legend.text = element_text(size = 10),
    legend.box.background = element_rect(color = "white"),
    strip.text = element_text(size=8),
    strip.placement = "outside",
    panel.grid.major = element_blank(),
    axis.text.x=element_text(size=6)
  )
dev.copy(png,filename=file.path(saved_graphs, "visualization_1c.png"));
dev.off ();

## Visualization 1d: waterfall view of completion/transfer, unenrollment, and continued enrollment over time
# Chart: waterfall view of completion/transfer, unenrollment, and continued enrollment over time
waterfall <- cte_data %>%
  mutate(stillenrolled = ifelse(pathway!="Not enrolled" & pathway!="Completed" & pathway!="Transferred", 1, 0)) %>%
  group_by(entry_pathway) %>%
  mutate(denominator = n_distinct(studentid)) %>%
  ungroup() %>%
  group_by(entry_pathway,cohorttermindex) %>%
  summarise(completed = sum(terminating), 
            stillenrolled = sum(stillenrolled),
            denominator = max(denominator)) %>%
  mutate(pct_completed = completed/denominator,
         pct_stillenrolled = stillenrolled/denominator,
         pct_nonenrolled = ((denominator - (stillenrolled + completed))/denominator)*-1)

waterfall_long <- waterfall %>% 
  select(entry_pathway, cohorttermindex, pct_completed, pct_stillenrolled, pct_nonenrolled) %>%
  pivot_longer(
    cols = pct_completed:pct_nonenrolled, 
    names_to = "status",
    values_to = "value"
  ) %>%
  mutate(status = ifelse(status=="pct_stillenrolled","Still Enrolled",ifelse(status=="pct_nonenrolled", "No Longer Enrolled","Completer/Transfer")))

ggplot(waterfall_long, aes(x = cohorttermindex, y = value, fill = forcats::fct_rev(status))) +
  geom_bar(stat = "identity", position = "stack") +
  facet_wrap(~ entry_pathway, ncol=2) +
  geom_hline(yintercept = 0, linetype = "solid", color = "gray") +
  scale_fill_manual(values = c(rgb(51, 34, 136, maxColorValue = 255),
                               rgb(136, 34, 85, maxColorValue = 255),
                               rgb(68, 170, 153, maxColorValue = 255))) +
  labs(
    title = "First Completion/Transfer Rates by Pathway",
    x = "Cohort Term",
    y = "Proportion of Cohort",
    fill = "Pathway"
  ) +
  theme_minimal() +
  theme(
    legend.position = "right",
    legend.title = element_blank(),
    legend.text = element_text(size = 10),
    legend.box.background = element_rect(color = "white"),
    panel.grid.minor = element_blank()
  )
dev.copy(png,filename=file.path(saved_graphs, "visualization_1d.png"));
dev.off ();