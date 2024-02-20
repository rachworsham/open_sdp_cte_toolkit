# ******************************************************************************
# 	Section 3 Code
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
data_path <- file.path("data", "cte_sample_it_courses.csv") # set path to your saved .csv data file matching spec document
saved_graphs <-	"graphs" # set path (folder) for where you'd like graphs saved on your computer

# Load required packages
packages<-c("tidyverse", "plotly")
# If required packages are not yet installed, uncomment the line below to install them
#lapply(packages, install.packages, character.only = TRUE)
lapply(packages, require, character.only = TRUE)

# ***************************************
#   Load data set up according to spec
# ***************************************

cte_course_data <- read.csv(data_path)

# *************************************
#  Plotly Scatterplot with tooltip hover
# *************************************

# Add column to be passed to color argument
cte_course_data <- cte_course_data %>% 
  mutate(color_val = "constant")

# Note: In the general technical guide, the Stata example shows how to create
# multiple charts at the same time, one for each pathway. The example data used
# here does not contain multple pathways (IT only), so only the IT pathway courses
# are shown.

# Round proportion_failing, prob_completer_pass, prob_completer_fail, prob_completer_diff 
# for better display
cte_course_data <- cte_course_data %>% 
  mutate(proportion_failing = round(proportion_failing, 2),
         prob_completer_pass = round(prob_completer_pass, 2),
         prob_completer_fail = round(prob_completer_fail, 2),
         prob_completer_diff = round(prob_completer_diff, 2))


# Create scatterplot using plotly
fig <- plot_ly(cte_course_data, 
               x = ~proportion_failing,
               y = ~prob_completer_diff,
               size = ~total_attempters,
               type = "scatter",
               mode = "markers",
               marker = list(color = "constant", colors = c(rgb(51, 34, 136, maxColorValue = 255))),
               text = ~paste("Course Name: ", course_label,
                             "<br>Total Attempters: ", total_attempters,
                             "<br>Pass Probability: ", prob_completer_pass,
                             "<br>Fail Probability: ", prob_completer_fail),
               hoverinfo = "text"
)

fig <- fig %>% layout(
  margin=list(t=50),
  title = paste("Difference in the Probability of First Completion for Those Who Pass, Fail Course on First Attempt: IT Tech Pathway"),
  xaxis = list(
    title = "Proportion Students Who Failed Course During First Attempt",
    range = c(0, 0.8),
    showline = TRUE,
    linewidth = 2,
    linecolor = 'gray',
    showgrid = TRUE,
    gridwidth = 1,
    gridcolor = rgb(192,192,192, maxColorValue = 255)
  ),
  yaxis = list(
    title = "Difference in Predicted Probability of First Completion",
    range = c(0, 0.9),
    showline = TRUE,
    linewidth = 2,
    linecolor = 'gray',
    showgrid = TRUE,
    gridwidth = 1,
    gridcolor = rgb(192,192,192, maxColorValue = 255)
  ),
  showlegend = FALSE,
  font = list(size = 15),
  plot_bgcolor = 'white'
)

fig

# Note: The simplest method to export a static image of this plot is to use
# the Export button within R studio on the Viewer pane. Otherwise, 
# you may use the orca package.
