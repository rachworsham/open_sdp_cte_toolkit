# ******************************************************************************
# 	Section 4 Code
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
data_path <- file.path("data", "cte_sample_credits.csv") # set path to your saved .csv data file matching spec document
saved_graphs <-	"graphs" # set path (folder) for where you'd like graphs saved on your computer

# Load required packages
packages<-c("tidyverse", "ggplot2")
# If required packages are not yet installed, uncomment the line below to install them
#lapply(packages, install.packages, character.only = TRUE)
lapply(packages, require, character.only = TRUE)

# ***************************************
#   Load data set up according to spec
# ***************************************

cte_credit_data <- read.csv(data_path)	

# 	********************************************
# 	 Generate and label an entry pathway
# 	********************************************

# Generate an entry pathway code for each student
cte_credit_data <- cte_credit_data %>%
  mutate(entry_pathway = ifelse(cohorttermindex==1, pathway, 0)) %>%
  group_by(studentid) %>%
  mutate(entry_pathway = max(entry_pathway)) %>%
  ungroup()

# Label entry pathways
cte_credit_data$entry_pathway <- factor(cte_credit_data$entry_pathway, levels=c(1,2,3,4),
                                 labels=c("Engineer Tech", "Health", "IT Tech", "Mech Repair"))
table(cte_credit_data$entry_pathway)

# ***************************************************************
# 	A few additional calculations to complement initial data file
# ***************************************************************

# Generate cumulative college-level credits earned by term
cte_credit_data <- cte_credit_data %>% 
  group_by(studentid) %>% 
  mutate(cumcollegecreditsearned = ifelse(!is.na(collegecreditsearned), cumsum(collegecreditsearned),NA)) 

# Generate cumulative credits earned by term
cte_credit_data <- cte_credit_data %>% 
  group_by(studentid) %>% 
  mutate(cumcreditsearned = ifelse(!is.na(creditsearned), cumsum(creditsearned),NA)) 

# Generate cumulative college-level credits attempted by term
cte_credit_data <- cte_credit_data %>% 
  group_by(studentid) %>% 
  mutate(cumcollegecreditsattempted = ifelse(!is.na(collegecreditsattempted), cumsum(collegecreditsattempted),NA)) 

# 	Determine number of terms included in data for each student
max_term <- max(cte_credit_data$cohorttermindex)		

# Generate ideal credits earned and cumulative credits earned amounts
cte_credit_data <- cte_credit_data %>% 
  mutate(idealcreditsearned = 15) %>%
  mutate(cumidealcreditsearned = ifelse(!is.na(idealcreditsearned), cumsum(idealcreditsearned),NA)) 

  # Code in an indicator for a terminating event (first completion or first transfer)
cte_data <- cte_credit_data %>%
  mutate(terminating = ifelse(pathway == 100 | pathway == 101, 1, 0))

# 	*******************************************
# 	 Create cumulative credit charts
# 	*******************************************

# 	Avg. college-level cumulative credits attempted vs. earned
avg_cum_attempt_earn <- cte_credit_data %>%
  group_by(entry_pathway, cohorttermindex) %>%
  summarise(cumcollegecreditsearned = mean(cumcollegecreditsearned, na.rm=TRUE),
            cumcollegecreditsattempted = mean(cumcollegecreditsattempted, na.rm=TRUE),
            cumidealcreditsearned = mean(cumidealcreditsearned, na.rm=TRUE),
            .groups = 'drop')

colors <- c("#332288", "#44AA99", "#882285")
	
# Plot using ggplot2
ggplot(avg_cum_attempt_earn, aes(x = cohorttermindex)) +
  geom_line(aes(y = cumcollegecreditsearned), color = colors[1]) +
  geom_line(aes(y = cumcollegecreditsattempted), color = colors[2], linetype = "dashed") +
  geom_line(aes(y = cumidealcreditsearned), color = colors[3]) +
  facet_wrap(~ entry_pathway, scales = "free_y") +
  theme_minimal() +
  theme(panel.grid = element_blank(), legend.position = "bottom", plot.title = element_text(size=12)) +
  labs(title = "Average Cumulative College-Level Credits Attempted vs. Earned",
       y = "Avg. Cumulative College-Level Credits",
       x = "Cohort Term") +
  scale_y_continuous(limits = c(0, 60), breaks = seq(0, 60, 15)) +
  scale_x_continuous(limits = c(1, 6), breaks = seq(1, 6, 1)) 
dev.copy(png,filename=file.path(saved_graphs, "visualization_4a.png"));
dev.off ();


# Avg. college-level cumulative credits earned by early momentum

# For each student, calculate their percentile of credits earned in the first 
# term
first_term_cred <- cte_credit_data %>%
  filter(cohorttermindex == 1) %>%
  select(studentid, cumcollegecreditsearned)
first_term_cred$bin <- ntile(first_term_cred$cumcollegecreditsearned,4)
first_term_cred <- first_term_cred %>% select(studentid, bin) %>%
  mutate(bin = ifelse(bin==2 | bin==3, 2,bin),
         bin = ifelse(bin==4, 3, bin))

cte_credit_data <- left_join(
  cte_credit_data,
  first_term_cred,
  join_by(studentid),
  multiple = "all",
  unmatched = "drop"
) 

avg_credit_bin <- cte_credit_data %>%
  group_by(entry_pathway, cohorttermindex, bin) %>%
  summarise(cumcollegecreditsearned = mean(cumcollegecreditsearned, na.rm=TRUE),
            .groups = 'drop')


# Define color palette for lines
colors <- c("#332288", "#44AA99", "#882285")

# Plot using ggplot2
ggplot(avg_credit_bin, aes(x = cohorttermindex, y = cumcollegecreditsearned, color = factor(bin))) +
  geom_line() +
  facet_wrap(~ entry_pathway, scales = "free_y") +
  theme_minimal() +
  theme(panel.grid = element_blank(), legend.position = "bottom") +
  labs(title = "Average College-Level Credit Accumulation by Entry Term College-Level Credits Earned",
       x = "Cohort Term",
       y = "Avg. College-Level Credit Accumulation",
       color = "Entry Term College-Level Credits Earned Percentile") +
  scale_x_continuous(limits = c(1, 6), breaks = seq(1, 6, 1))  +
  scale_color_manual(name = "Entry Term College-Level Credits Earned Percentile",
                     values = colors,
                     labels = c("< 25th", "25th - 75th", "> 75th")) +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  theme(legend.title = element_blank(),  plot.title = element_text(size=11))
dev.copy(png,filename=file.path(saved_graphs, "visualization_4b.png"));
dev.off ();
