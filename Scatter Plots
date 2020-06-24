The examples use more code than necessary so that I know exactly what modifies what. 
You don't need to include every line when making your graphs. These templates should
be used as a starting point where you can modify and reduce as needed. 

Some examples I learned in Base R, and I converted them to ggplot2, which I prefer. 
I organize each plot example like so: Base R>ggplot2 annotated>not annotated.

# Load Necessary Packages/Files ------------------------------------------------

# Load datasets
?datasets # "?" before any code for its description
library(help = "datasets") # Brings up documentation into editor window
library(datasets)  # Load package (it's actually already loaded)
# Dataset for scatterplot/college example
college <- read.csv('http://672258.youcanlearnit.net/college.csv', header = TRUE)

# Load packages
# Loads ggplot and all other essential packages
if (!require("tidyverse")) {
  install.packages("tidyverse", dependencies = TRUE)
  library(tidyverse)
}
# Package specific for scatterplot/iris example
if (!require("directlabels")) {
  install.packages("directlabels", dependencies = TRUE)
  library(directlabels)
}

# Scatterplots -----------------------------------------------------------------

#### Iris Example ####

data("iris")
iris[1:5,] # Another way to do head(iris)

# To identify where your limits should be, calculate the min and max of each variable
mm <- cbind( # Column bind
  aggregate( # Apply a single function to multiple variables
    cbind(iris$Sepal.Width, iris$Sepal.Length) # Apply function to these variables
    ~ iris$Species, # Categorize output by another variable
    FUN = "min"), # Minimum function
  aggregate(cbind(iris$Sepal.Width, iris$Sepal.Length) ~ iris$Species, FUN = "max"))
mm # View output
(colnames(mm) <- c("Species", "SW_Min", "SL_Min", 
                   "Species", "SW_Max", "SL_Max")) # Change the column names
limits.1 <- mm[ , c(1:3,5:6)] # Exclude the repeated column
limits.1 # View the limits

## ggplot with annotations

flower <- # Save graph into object
ggplot( # Graph space for all you are about to add
  data = iris) + # dataset being used
  ggtitle("Correlation Between Sepal Width and Length", # Title
          subtitle = "iris dataset provided by R") + # Subtitle
  geom_point( # Scatterplot
    size = 4, # Size of point
    aes(x = Sepal.Length, # Variable for X-axis
      y = Sepal.Width, # Variable for Y-axis
      shape = Species, # Variable to determine different shapes
      color = Species)) + # Variable to determine different colors
  theme(
    plot.title = element_text(color = "black", size = 17, face = "bold"),
    plot.subtitle = element_text(color = "black", size = 13, face = "italic"),
    panel.background = element_rect(fill = "light gray", color = "black"), 
    plot.background = element_blank(), 
    panel.grid.major = element_line(color = "white", linetype = "solid", size = 1),
    panel.grid.minor = element_line(color = "white", linetype = "solid", size = 1),
    axis.title = element_text(size = 15, color = "black", face = "bold"), 
    axis.text = element_text(size = 10, color = "black"), 
    axis.ticks = element_line(color = "black", linetype = "solid", size = 1), 
    axis.ticks.length = unit(0.25, "cm"), 
    legend.background = element_rect(fill = "white", color = "black"), 
    legend.text = element_text(face = "italic", size = 13), 
    legend.title = element_text(size = 15, face = "bold"),
    legend.key = element_rect(fill = "white", color = "white")) + 
  scale_y_continuous(name = "Sepal Width", limits = c(2, 4.4), breaks = seq(1.5, 4.5, by = 0.5)) +
  scale_x_continuous(name = "Sepal Length", limits = c(4.25, 7.9), breaks = seq(4.5, 7.5, by = 1)) +
  scale_fill_manual(guide_legend(title = "Species", nrow = 3, label.position = "right")) +
  geom_dl( # Direct labels
    aes(x = Sepal.Length, y = Sepal.Width, # Variables
        label = Species, color = Species), # Label and color according to the same variable
    method = list("smart.grid", cex = 1.5, face = "bold")) + # cex = size
  labs(caption = "plot by @MilesToKilo")
flower

# Save your graph
ggsave(flower, filename = paste("graph_scatter_flower.png"), 
       path = "Pictures") # Destination
# Ideally, you have a folder within your directory for saving these graphs 

#### College Example ####

# Manipulate data for example
college <- college %>%
  mutate(state = as.factor(state), region = as.factor(region),
         highest_degree = as.factor(highest_degree),
         control = as.factor(control), gender = as.factor(gender),
         loan_default_rate = as.numeric(loan_default_rate))
college[1:5,]
str(college)

## ggplot with annotations
school <- # Save graph into object
ggplot(data = college) +
  ggtitle("Correlation Between SAT Scores and Cost of Tuition", subtitle = "dataset provided by Mike Chapple from Lynda.com") +
  geom_point(mapping = aes(x = tuition, y = sat_avg, # X and Y variables
                           color = control, # Color points by institution type
                           size = undergrads,# Have size proportional to undergraduate population
                           stroke = 1.25), # Border width of points
             alpha = 1/2) + # Transparancy of points on a scale from 0-1
  annotate("text", label = "Elite Privates", # Label on graph
           x = 45000,y = 1500) + # Coordinates for label
  geom_hline( # Horizontal line
    yintercept = mean(college$sat_avg), # Extend line from the y-intercept showing the mean SAT score 
    color = "dark grey") + # Color of line
  annotate("text", label = "Mean SAT", x = 47500, y = mean(college$sat_avg) - 15) + # -15 to place label under line for the mean
  geom_vline( # Vertical line
    xintercept = mean(college$tuition), color = "dark grey") + # Extend line from x-intercept showing the mean tuition
  annotate("text", label = "Mean Tuition", x = mean(college$tuition) + 5000, y = 700) +
  theme(panel.background = element_blank(), plot.background = element_blank(),
        plot.title = element_text(face = "bold", size = 17, color = "black"),
        plot.subtitle = element_text(size = 13, face = "italic", color = "black"),
        legend.key = element_rect(fill = "white", color = "white"),
        legend.title = element_text(face = "bold", size = 15),
        legend.text = element_text(size = 13),
        axis.title = element_text(size = 13, face = "bold"),
        axis.line = element_line(size = 1, linetype = "solid"),
        axis.text = element_text(size = 11),
        axis.ticks = element_line(linetype = "solid", size = 1),
        axis.ticks.length = unit(0.25, "cm")) +
  scale_color_discrete(name = "Institution Type") + # Legend name for categorical data
  scale_size_continuous(name = "Undergraduates") + # Legend name for continuous data
  scale_x_continuous(name = "Tuition") +
  scale_y_continuous(name = "SAT Scores") +
  labs(caption = "plot by @MilesToKilo")
school

# Save your graph
ggsave(school, filename = paste("graph_scatter_school.png"), 
       path = "Pictures") # Destination
# Ideally, you have a folder within your directory for saving these graphs 

#### Final Products ####
flower
school

# Clean Up
rm(list = ls())
detach("package:tidyverse", unload = TRUE)
detach("package:directlabels", unload = TRUE)
