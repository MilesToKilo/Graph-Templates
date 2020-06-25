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
# Necessary for ggridge plots
if (!require("ggridges")) {
  install.packages("ggridges", dependencies = TRUE)
  library(ggridges)
}

# ggRidges Plot ----------------------------------------------------------------

browseURL("https://cran.r-project.org/web/packages/ggridges/vignettes/introduction.html")
## This vignette does a better job of explaining all the variables. I learned from it
## and condensed everything into my own examples. 

### College Example ###
# Manipulate data for example
college <- college %>%
  mutate(state = as.factor(state), region = as.factor(region),
         highest_degree = as.factor(highest_degree),
         control = as.factor(control), gender = as.factor(gender),
         loan_default_rate = as.numeric(loan_default_rate))
str(college)

## ggRidges plot with most variables adjusted

## I wouldn't recommend making a graph look like this example. It's meant to show you 
## how to change different aspects of this graph.

gridge <- 
ggplot(college, 
       aes(sat_avg, region, # X-Y data
           fill = region)) + # If y-variable is a number, must use "group = "
  geom_density_ridges2(# _ridge w/o bottom black line; _ridge2 w/black line
    rel_min_height = 0.01, # Reduces the trailing tails
    scale = 2, # Amount of overlap between distributions
    alpha = 0.2, # Transparency
    aes(point_color = region, point_fill = region, # Points w/n distribution
    point_shape = region, point_alpha = 1,
    point_size = tuition), # Weight of variable relative to another variable 
    jittered_points = TRUE) + # Show individuals
    # position = "raincloud") # Position points below distribution
  theme(
    plot.title = element_text(size = 17, face = "bold", color = "black"),
    plot.subtitle = element_text(size = 13, face = "italic", color = "black"), 
    panel.background = element_blank(), plot.background = element_blank(),
    panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
    axis.title = element_text(size = 15, face = "bold"),
    axis.text = element_text(size = 11, color = "black"),
    axis.ticks = element_line(linetype = "solid", size = 1),
    axis.ticks.length = unit(0.25, "cm"), 
    axis.line = element_line(color = "black", linetype = "solid", size = 1),
    legend.background = element_rect(color = "black", fill = "white"),
    legend.position = "right", 
    legend.title = element_text(size = 15, face = "bold"),
    legend.key = element_blank(),
    legend.text = element_text(color = "black", size = 15, face = "bold")) +
  scale_point_size_continuous(range = c(0.25, 2)) + # Range of point sizes
  scale_discrete_manual(aesthetics = "point_shape", # Visuals according to variable
                        values = c(2, 4, 15, 22)) +# Shape choices must match in number with variable options
  scale_x_continuous(expand = c(0, 0)) + # Adjusted range of x-axis
  scale_y_discrete(expand = expand_scale(mult = c(0.02, 0.5))) + # Adjusted range of y-axis
  ggtitle("ggRidge Plot Showing Tuition by Region", 
          subtitle = "dataset provided by Mike Chapple from Lynda.com") +
  xlab("Tuition") + ylab("Region") +
  labs(caption = "plot by @MilesToKilo")
gridge

# Save your graph
ggsave(gridge, filename = paste("graph_ggridges_college.png"), 
       path = "Pictures") # Destination
# Ideally, you have a folder within your directory for saving these graphs 

## ggRidges with gradient
gridge_grad <- 
ggplot(college, 
       aes(x = tuition, y = region, 
           fill = stat(x))) + # Needed for calculating the color fill
  geom_density_ridges_gradient(scale = 2, rel_min_height = 0.01) +
  scale_fill_viridis_c(name = "Tuition", option = "E") + # Options A-E for colors
  theme(
    plot.title = element_text(size = 17, face = "bold", color = "black"),
    plot.subtitle = element_text(size = 13, face = "italic", color = "black"), 
    panel.background = element_blank(), plot.background = element_blank(),
    panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
    axis.title = element_text(size = 15, face = "bold"),
    axis.text = element_text(size = 11, color = "black"),
    axis.ticks = element_line(linetype = "solid", size = 1),
    axis.ticks.length = unit(0.25, "cm"), 
    axis.line = element_line(color = "black", linetype = "solid", size = 1),
    legend.background = element_rect(color = "black", fill = "white"),
    legend.position = "right", 
    legend.title = element_text(size = 15, face = "bold"),
    legend.key = element_blank(),
    legend.text = element_text(color = "black", size = 15, face = "bold")) +
  scale_point_size_continuous(range = c(0.25, 2)) + # Range of point sizes
  scale_discrete_manual(aesthetics = "point_shape", # Visuals according to variable
                        values = c(2, 4, 15, 22)) +# Shape choices must match in number with variable options
  scale_x_continuous(expand = c(0, 0)) + # Adjusted range of x-axis
  scale_y_discrete(expand = expand_scale(mult = c(0.02, 0.5))) + # Adjusted range of y-axis
  ggtitle("ggRidge Plot with Gradient Shading", 
          subtitle = "dataset provided by Mike Chapple from Lynda.com") +
  xlab("Tuition") + ylab("Region") +
  labs(caption = "plot by @MilesToKilo")
gridge_grad

# Save your graph
ggsave(gridge, filename = paste("graph_ggridges_collegeGradient.png"), 
       path = "Pictures") # Destination
# Ideally, you have a folder within your directory for saving these graphs 

#### Final Products ####
gridge # ggRidges Plot
gridge_grad # ggRidges plot with gradient

# Clean Up
rm(list = ls())
detach("package:tidyverse", unload = TRUE)
detach("package:ggridges", unload = TRUE)
