# ******************************************************************************
#  Section 2 Code
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


# ***************************************
# 	 Set up 
# ***************************************

# Clear environment
rm(list=ls())

# In the directory where you have the R Project file, ensure there is a folder 
# called "data" and a folder called "graphs" or change the names for these
# folders below
data_path <- file.path("data", "cte_sample_data.csv") # set path to your saved .csv data file matching spec document
saved_graphs <-	"graphs" # set path (folder) for where you'd like graphs saved on your computer

# Load required packages
packages<-c("tidyverse", "plotly")
# If required packages are not yet installed, uncomment the line below to install them
#lapply(packages, install.packages, character.only = TRUE)
lapply(packages, require, character.only = TRUE)

# ***************************************
#   Load data set up according to spec
# ***************************************

#   import delimited "${path_to_data}"
cte_data <- read.csv(data_path)

# /******************************************
#   Generate additional variables
# ******************************************/
#   
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

# Label outcome
cte_data$outcome <- factor(cte_data$outcome, levels=c(0,1,2),
                           labels=c("None", "Completion", "Transfer"))
table(cte_data$outcome)

# Code in an indicator for a terminating event (first completion or first transfer)
cte_data <- cte_data %>%
  mutate(terminating = ifelse(pathway == 100 | pathway == 101, 1, 0))

# Generate an indicator for non-enrollment
cte_data <- cte_data %>%
  mutate(nonenrolled = ifelse(pathway == 99, 1, 0))

# Generate an entry pathway code for each student
cte_data <- cte_data %>%
  mutate(entry_pathway = ifelse(cohorttermindex==1,pathway,0)) %>%
  group_by(studentid) %>%
  mutate(entry_pathway = max(entry_pathway)) %>%
  ungroup()

# Label entry pathways
cte_data$entry_pathway <- factor(cte_data$entry_pathway, levels=c(1,2,3,4),
                                 labels=c("Engineer Tech", "Health", "IT Tech", "Mech Repair"))
table(cte_data$entry_pathway)

# For the Sankey chart, we will limit our data to the IT Tech pathway
cte_data <- cte_data %>% filter(entry_pathway == "IT Tech") %>%
  arrange(studentid, cohorttermindex)
count(cte_data)

# For each student, get their pathway in the next term. 
cte_data <- cte_data %>%
  mutate(pathway_target = ifelse(studentid==lead(studentid), lead(pathway), NA))

# Get counts of each term and the pathway the following term
sankey_data <- cte_data %>%
  group_by(cohorttermindex, pathway, pathway_target) %>%
  summarise(num_students = n()) %>%
  filter(cohorttermindex < 6) %>%
  select(cohorttermindex, pathway_origin=pathway, pathway_target, num_students)

# These are our data flows
sankey_data <- sankey_data %>% rename(semestertransition=cohorttermindex)

# Set up for Sankey

# Create a label for each node = to the end point 
# For simplicity, we create the labels in a dataframe and join them to the 
# sankey data. However, you could also create them using "mutate."
node_labels <- data.frame(pathway=c(1,2,3,4,99,100,101),
                        labels=c("Engineer Tech", "Health", "IT Tech", "Mech Repair", "Not enrolled", "Completed", "Transferred"))
sankey_data <- left_join(
  sankey_data,
  node_labels,
  join_by(pathway_origin==pathway),
  multiple = "all",
  unmatched = "drop"
  )  %>%
  rename(pathway_origin_label=labels)
sankey_data <- left_join(
  sankey_data,
  node_labels,
  join_by(pathway_target==pathway),
  multiple = "all",
  unmatched = "drop"
)  %>%
  rename(pathway_target_label=labels)

# Label each source and target
# Each point in the flow is a combination of the semester transition and the node name
sankey_data <- sankey_data %>%
  mutate(pathway_origin = (semestertransition*1000) + pathway_origin,
         pathway_target = ((semestertransition+1)*1000) + pathway_target)

# From these flows we need to create a node data frame: it lists every entities involved in the flow
nodes <- data.frame(
  name = c(sankey_data$pathway_origin, 
         sankey_data$pathway_target),
  label = paste(sankey_data$pathway_origin_label, 
            sankey_data$pathway_target_label, sep = " to ")) %>% 
  unique()

# Create Sankey diagram using plotly
fig <- plot_ly(
  type = "sankey",
  orientation = "h",
  arrangement="snap",
  node = list(
    label = nodes$label,
    pad = 15,
    thickness = 20,
    line = list(
      color = 'black',
      width = 0.5
    ),
    color = rgb(51,34,136,maxColorValue = 255),
    hovertemplate = nodes$label
  ),
  link = list(
    source = sankey_data$pathway_origin,
    target = sankey_data$pathway_target,
    value =  sankey_data$num_students
  )
)

fig <- fig %>% layout(
  title = "Semester by Semester Movement Across Pathways for Students <br> Who Entered IT Tech Pathway in First Term",
  font = list(
    size = 10
  )
)

fig

# Note: The simplest method to export a static image of this plot is to use
# the Export button within R studio on the Viewer pane. Otherwise, 
# you may use the orca package.

  