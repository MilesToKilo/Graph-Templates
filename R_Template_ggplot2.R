#############################################
#### ggplot2 Templates by Miles Valencia ####
#############################################

# Choosing Colors --------------------------------------------------------------

# Create an object for trying out different colors
x <-  c(12, 4, 21, 17, 13, 9)
barplot(x)

# R specifies color in several ways
?colors
colors()  # Gives list of color names
# PDF of colors in R; more online if you search for them
browseURL("http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf")

# Built-in palettes ------------------------------------------------------------

barplot(x, col = 1:6)
# rainbow(n, s = 1, v = 1, start = 0, end = max(1, n - 1)/n, alpha = 1)
barplot(x, col = rainbow(6))
# heat.colors(n, alpha = 1)  # Yellow through red
barplot(x, col = heat.colors(6))
# terrain.colors(n, alpha = 1)  # Gray through green
barplot(x, col = terrain.colors(6))
# topo.colors(n, alpha = 1)  # Purple through tan
barplot(x, col = topo.colors(6))
# cm.colors(n, alpha = 1)  # Blues and pinks
barplot(x, col = cm.colors(6)) 

# RColorBrewer -----------------------------------------------------------------
# Most essential for color choice b/c it has colorblind options

browseURL("http://colorbrewer2.org/")  # Uses Flash
# install.packages("RColorBrewer") # If not installed already
require("RColorBrewer") # Load package
help(package = "RColorBrewer")
# Cannot use this package for selecing specific, individual colors

# Show all of the palettes in a graphics window
display.brewer.all()
# Colors divided by Sequential, Qualitative, and Divergent groups

## To see palette colors in separate window, give number of 
## desired colors and name of palette in quotes
display.brewer.pal(8, "Accent") # Qualitative
display.brewer.pal(4, "Spectral") # Divergent

# Can save palette as vector or call in function
blues <- brewer.pal(6, "Blues")
barplot(x, col = blues)
barplot(x, col = brewer.pal(6, "Greens"))

# If you need to clean your workspace:
rm(list = ls())

## Most graphing examples use the datasets built into R ##

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
# Not completely necessary for raincloud plots, but adjusts plot's theme
if (!require("cowplot")) {
  install.packages("cowplot", dependencies = TRUE)
  library(cowplot)
}
# Necessary for raincloud plots; loaded w/ggRidges if you already using it
if (!require("plyr")) {
  install.packages("plyr", dependencies = TRUE)
  library(plyr)
}
# Necessary for ggridge plots
if (!require("ggridges")) {
  install.packages("ggridges", dependencies = TRUE)
  library(ggridges)
}

# Barplots ---------------------------------------------------------------------

#### Chicken Feed Example ####

?chickwts # Information on the dataset being used
data("chickwts")  # Load data into workspace
# Different options for viewing data
chickwts  # Look at data
str(chickwts) # Look at overall structure of data
head(chickwts) # First few lines of data
tail(chickwts) # Last few lines of data

## Plot with Base R functions
feeds <- table(chickwts$feed) # Create a table with frequencies of each feed
feeds
par(oma = c(1, 1, 1, 1))  # Sets outside margins: b, l, t, r
par(mar = c(4, 5, 2, 1))  # Sets plot margins
barplot(feeds[order(feeds)], # Increasing order is default
        horiz  = TRUE, # Switch orientation of variables x <-> y
        las    = 1,  # las gives orientation of axis labels
        col    = c("beige", "blanchedalmond", "bisque1", 
                   "bisque2", "bisque3", "bisque4"), # Color
        border = NA,  # No borders on bars
        main   = "Frequencies of Different Feeds\nin 
        chickwts Dataset",  # Title; \n = line break
        xlab   = "Number of Chicks") # Horizontal label

## Plot with ggplot
ggplot( # Graph space for all that you are about to add
  data = chickwts) + # Data being used
  ggtitle("Chicken Feed Influence on Offspring Production", # Graph title
          subtitle = "chickwts dataset provided by R ") + # Graph subtitle
  geom_bar( # Bar graph
    color = "black", # Bar outline color
    mapping = aes(x = chickwts$feed, # Bar graph data
                         fill = chickwts$feed # Fill bar colors according to variable
                         # sort.list(chickwts$feed, decreasing = TRUE)
                         )) + #
  # grid.major.y for Y-axis, and grid.major.x for X-axis
    theme(panel.background = element_rect(color = "black", fill = "white"), # Graph panel background
        plot.background = element_rect(fill = "white"), # Entire plot background
        panel.grid.major.x = element_line(color = "gray"), # Major gridlines
        panel.grid.major.y = element_blank(), # .x or .y signals a specific axis
        panel.grid.minor = element_blank(), # Minor gridlines
        legend.position = "right", # Legend position
        legend.background = element_rect(fill = "white", # Area color
                                         color = "black"), # Perimeter color
        legend.key = element_rect(color = "black"), # Border for legend key
        axis.title = element_text(size = 13, color = "black", face = "bold"), # Axis title
        axis.text.y = element_text(size = 13, color = "black", face = "bold"), # Y-axis tick labels
        axis.text.x = element_text(size = 13, color = "black"), # X-axis tick labels
        axis.ticks = element_line(linetype = "solid", size = 1), # Axis ticks
        axis.ticks.length = unit(0.25, "cm"), # Axis tick lengths
        axis.line = element_line(color = "black", linetype = "solid", size = 1), # X-axis line
        plot.title = element_text(size = 17, color = "black", hjust = 0.5, face = "bold"), # Title font
        plot.subtitle = element_text(size = 14, hjust = 0.5, color = "black", face = "italic")) + # Subtitle font
  scale_y_continuous(name = "Number of Chicks", # Continuous y variable name
                     limits = c(0,15)) + # Adjust Y-axis values
  # OR ylab("Number of Chicks") + ylim(0,15) +
  scale_x_discrete(name = (title = NULL)) + # Discrete x variable name
  # OR title = "Chicken Feed"
  scale_fill_manual(values = c("beige", "blanchedalmond", "bisque1", "bisque2", "bisque3", "bisque4"), # Color
                    guide = guide_legend(title = "Chicken Feed", # Legend title
                                         label.position = "right", # Label position according to label color
                                         nrow = 6, # Number of rows to organize legend
                                         keywidth = 3)) + # Width of label color
  coord_flip() + # Switch X and Y variables; have last in code to avoid confusion
  labs(caption = "plot by @MilesToKilo")

?theme # Helpful in knowing what you can change

## Preferred ggplot without annotations ##

chick <- # Save graph into object
ggplot(data = chickwts) +
  ggtitle("Chicken Feed Influence on Offspring Production", 
          subtitle = "chickwts dataset provided by R ") + 
  geom_bar(color = "black",
    mapping = aes(x = chickwts$feed, fill = chickwts$feed)) +
  theme(panel.background = element_blank(), plot.background = element_blank(),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        axis.title = element_text(size = 13, color = "black", face = "bold"),
        axis.text.y = element_text(size = 13, color = "black", face = "bold"),
        axis.text.x = element_text(size = 13, color = "black"),
        axis.ticks = element_line(linetype = "solid", size = 1),
        axis.ticks.length = unit(0.25, "cm"),
        axis.line.x = element_line(color = "black", linetype = "solid", size = 1),
        plot.title = element_text(size = 17, color = "black", face = "bold"),
        plot.subtitle = element_text(size = 14, color = "black", face = "italic")) +
  scale_y_continuous(name = "Number of Chicks", limits = c(0,15)) + 
  scale_x_discrete(name = (title = NULL)) + 
  scale_fill_manual(values = c("beige", "blanchedalmond", "bisque1", "bisque2", "bisque3", "bisque4"),
                    guide = "none") +
  coord_flip() +
  labs(caption = "plot by @MilesToKilo")
chick

# Save your graph
ggsave(chick, filename = paste("graph_bar_chick.png"), 
       path = "Pictures") # Destination
# Ideally, you have a folder within your directory for saving these graphs 

# Histograms -------------------------------------------------------------------

#### Fertility Example ####

data("swiss")
str(swiss)
fertility <- swiss$Fertility # For easier referencing of variables

## Stacked plots with Base R
# Plot 1: Histogram
h <- hist( # Histogram
  fertility, # Data
  prob = TRUE,  # Flipside of "freq = FALSE"
  ylim = c(0, 0.04), # Y-axis limits
  # Two lines above change frequency to proportions/probability
  # When overlaying plots, frequency does not always match, so probability is better to use
  xlim = c(30, 100), # X-axis limits
  breaks = 11, # Suggested bin count
  col = "#E5E5E5", # Color
  border = 1, # Bin border
  main = "Fertility for 47 French-Speaking\nSwiss Provinces, c. 1888") # Title

# Plot 2: Normal curve (if prob = TRUE)
curve( # Distribution line of dataset
  dnorm( # Normal distribution
    x, mean = mean(fertility), # Mean
    sd = sd(fertility)), # Standard deviation
  col = "red", # Color
  lwd = 3, # Line width
  add = TRUE) # Add to previous graph

# Plot 3 & 4: Kernel density lines (if prob = TRUE)
# Loosely described: Kernel density lines = smoothed histograms
lines(density(fertility), col = "blue") # Smoothed histogram curve
lines(density(fertility, adjust = 3), col = "darkgreen") # Adjusted, smoothed histogram curve

# Plot 5: Rug (That is, lineplot under histogram)
# Shows the frequency of data along the x-axis
rug(fertility, col = "red") # Frequencies shown on X-axis

## Plots with ggplot

ggplot( # Graph space for all you are about to add
  data = swiss, # dataset being used
  aes(x = fertility)) + # Variable being accessed
  ggtitle("Fertility for 47 French-Speaking Swiss Provinces, c. 1888", # Title
          subtitle = "swiss dataset Provided by R") + # Subtitle
  geom_histogram( # Histogram (Plot 1)
    boundary = 0, # Specifies bin position
    color = "black", # Border color
    fill = "light gray", # Fill color
    binwidth = 5, # Bin width
    aes(y = stat(density), # Statistical curve wanted
        fill = fertility)) + # Variable being used
  stat_function( # Superimposes a function onto an existing plot
    fun = dnorm, # Normal distribution (Plot 2)
    args = list(mean = mean(swiss$Fertility), # Mean
                sd = sd(swiss$Fertility)), # Standard deviation
    lwd = 1, # Line width
    color = "blue") + # Line color
  geom_density( # Smoothed histogram curve (Plot 3)
    color = "green", # Line color
    lwd = .5) + # Line width
    # maping = aes(element_line(color = "red", linetype = "solid", size = 0.5))) +
  geom_density( # Smoothed histogram curve (Plot 4)
    color = "black", # Line color
    lwd = .5, # Line width
    adjust = 3) + # Adjustment to smoothed curve
  geom_rug( # Rug plot; shows frequencies of each input (Plot 5)
    sides = "b", # Rug plot location; can be on all 4 sides (trbl)
    color = "red") + # Line color
  theme(panel.background = element_blank(), # Graph panel background
        plot.background = element_blank(), # Plot background
        panel.grid.major.y = element_line(color = "gray"), # Major gridlines
        axis.title = element_text(size = 15, color = "black", face = "bold"), # Axis title 
        axis.text = element_text(size = 12, color = "black"), # Axis text for tick marks
        axis.line = element_line(color = "black", linetype = "solid", size = 1), # Axis lines
        axis.ticks = element_line(linetype = "solid", size = 1), # Axis ticks
        axis.ticks.length = unit(0.25, "cm"), # Axis tick lengths
        plot.title = element_text(size = 17, color = "black", face = "bold"), # Title
        plot.subtitle = element_text(size = 14, face = "italic", color = "black")) + # Subtitle
  scale_y_continuous(name = "Density", # Y-axis name
                     limits = c(0, 0.04)) + # Y-axis limits
  scale_x_continuous(name = "Fertility", # X-axis name
                     limits = c(35, 95), # X-axis limits
                     breaks = seq(35, 95, by = 10)) + # X-axis major tick mark locations
  labs(caption = "plot by @MilesToKilo")

## Preferred ggplot without annotations ##

fert <- # Save graph into object
ggplot(data = swiss, aes(x = fertility)) +
  ggtitle("Fertility for 47 French-Speaking Swiss Provinces, c. 1888", 
          subtitle = "swiss dataset Provided by R") +
  geom_histogram(boundary = 0, color = "black", fill = "light gray", 
                 binwidth = 5, aes(y = stat(density), fill = fertility)) + 
  stat_function(fun = dnorm, lwd = 1, color = "blue",
                args = list(mean = mean(swiss$Fertility), sd = sd(swiss$Fertility))) + 
  geom_density(color = "green", lwd = .5) +
  geom_density(color = "black", lwd = .5, adjust = 3) + 
  geom_rug(sides = "b", color = "red") + 
  theme(panel.background = element_blank(), plot.background = element_blank(), 
        panel.grid.major.y = element_line(color = "gray"), 
        axis.title = element_text(size = 15, color = "black", face = "bold"), 
        axis.text = element_text(size = 12, color = "black"), 
        axis.line = element_line(color = "black", linetype = "solid", size = 1), 
        axis.ticks = element_line(linetype = "solid", size = 1), 
        axis.ticks.length = unit(0.25, "cm"), 
        plot.title = element_text(size = 17, color = "black", face = "bold"), 
        plot.subtitle = element_text(size = 14, face = "italic", color = "black")) + 
  scale_y_continuous(name = "Density", limits = c(0, 0.04)) + 
  scale_x_continuous(name = "Fertility", limits = c(35, 95), breaks = seq(35, 95, by = 10)) +
  labs(caption = "plot by @MilesToKilo")
fert

# Save your graph
ggsave(fert, filename = paste("graph_histo_fertility.png"), path = "Pictures")

# Scatterplots -----------------------------------------------------------------

#### Iris Example ####

# Use directlabels package

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
ggsave(flower, filename = paste("graph_scatter_flower.png"), path = "Pictures")

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
ggsave(school, filename = paste("graph_scatter_school.png"), path = "Pictures")

# Violin Plots -----------------------------------------------------------------

#### Sleep Example ####
data("sleep") # Data on student sleep
str(sleep)

# Identify min and max for graph limits
ss <- cbind( # Column bind
  aggregate( # Apply a single function to multiple variables
    sleep$extra # Apply function to these variables
    ~ sleep$group, # Categorize output by another variable
    FUN = "min"), # Minimum function
  aggregate(sleep$extra ~ sleep$group, FUN = "max"))
ss # View output
colnames(ss) <- c("Group", "Min", "Group", "Max") # Change the column names
limits.2 <- ss[ , c(1:2,4)] # Exclude the repeated column
limits.2 # View the limits

## Vertical Violin Plot ##
sl.v <- # Save graph into object
ggplot(data = sleep, aes(x = sleep$group)) +
  ggtitle("Effect of Two Soporific Drugs on Student Sleep", subtitle = "sleep dataset provided by R") +
  geom_violin(mapping = aes(y = sleep$extra, fill = sleep$group),
              size = 1, color = "black", alpha = 0.6) +
  geom_boxplot(mapping = aes(y = sleep$extra, fill = sleep$group),
               width = 0.1, size = 1, color = "black"
               # ,outlier.size = 3, outlier.color = "black", outlier.alpha = 1 
               ) +
  theme(
    plot.title = element_text(size = 17, face = "bold", color = "black"),
    plot.subtitle = element_text(size = 13, face = "italic", color = "black"), 
    panel.background = element_blank(), plot.background = element_blank(),
    panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
    axis.title.y = element_text(size = 15, face = "bold"),
    axis.title.x = element_blank(),
    axis.text.x = element_blank(), 
    axis.text.y = element_text(size = 11, color = "black"),
    axis.ticks.x = element_blank(), axis.ticks.y = element_line(linetype = "solid", size = 1),
    axis.ticks.length = unit(0.25, "cm"), 
    axis.line.x = element_blank(), 
    axis.line.y = element_line(color = "black", linetype = "solid", size = 1), 
    legend.background = element_rect(color = "black", fill = "white"),
    legend.position = "bottom", 
    legend.title = element_text(size = 15, face = "bold"),
    legend.key = element_blank(), legend.key.size = unit(1, "cm"),
    legend.margin = margin(0.2, 1, 0.2, 1, "cm"),
    legend.text = element_text(color = "black", size = 15, face = "bold")) +
  scale_x_discrete(name = "Group") +
  scale_y_continuous(name = "Difference in Sleep, hours\n", limits = c(-2, 6.0)) +
  scale_fill_manual(values = c("tomato", "blue"),
                    guide_legend(title = "Group", position = "right", nrow = 1)) +
  labs(caption = "plot by @MilesToKilo")
sl.v

# Save your graph
ggsave(sl.v, filename = paste("graph_violin_sleepVertical.png"), path = "Pictures")

## Horizontal Violin Plot ##
sl.h <- # Save graph into object
ggplot(data = sleep, aes(x = sleep$group)) +
  ggtitle("Effect of Two Soporific Drugs on Student Sleep", subtitle = "sleep dataset provided by R") +
  geom_violin(mapping = aes(y = sleep$extra, fill = sleep$group),
              size = 1, color = "black", alpha = 0.6) +
  geom_boxplot(mapping = aes(y = sleep$extra, fill = sleep$group),
               width = 0.1, size = 1, color = "black"
               # ,outlier.size = 3, outlier.color = "black", outlier.alpha = 1 
  ) +
  coord_flip() +
  theme(
    plot.title = element_text(size = 17, face = "bold", color = "black"),
    plot.subtitle = element_text(size = 13, face = "italic", color = "black"), 
    panel.background = element_blank(), plot.background = element_blank(),
    panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
    axis.title.x = element_text(size = 15, face = "bold"),
    axis.title.y = element_blank(),
    axis.text.y = element_blank(), 
    axis.text.x = element_text(size = 11, color = "black"),
    axis.ticks.y = element_blank(), axis.ticks.x = element_line(linetype = "solid", size = 1),
    axis.ticks.length = unit(0.25, "cm"), 
    axis.line.y = element_blank(), 
    axis.line.x = element_line(color = "black", linetype = "solid", size = 1, lineend = "round"),
    legend.background = element_rect(color = "black", fill = "white"),
    legend.position = "bottom", 
    legend.title = element_text(size = 15, face = "bold"),
    legend.key = element_blank(), legend.key.size = unit(1, "cm"),
    legend.margin = margin(0.2, 1, 0.2, 1, "cm"),
    legend.text = element_text(color = "black", size = 15, face = "bold")) +
  scale_x_discrete(name = "Group") +
  scale_y_continuous(name = "Difference in Sleep, hours\n", limits = c(-2, 6.0)) +
  scale_fill_manual(values = c("tomato", "blue"),
                    guide_legend(title = "Group", position = "right", nrow = 1)) +
  labs(caption = "plot by @MilesToKilo")
sl.h

# Save your graph
ggsave(sl.h, filename = paste("graph_violin_sleepHorizontal.png"), path = "Pictures")

# Line Graphs ------------------------------------------------------------------

#### Beavers Example ####
data("beavers") 
str(beaver1)
str(beaver2)

# Subset data for example
(beav1.1 <- subset(beaver1, day == "346"))
beav1.mm <- cbind(mean(beav1.1$temp), sd(beav1.1$temp)/sqrt(beav1.1$temp))
beav1.mm

beav <-
ggplot(data = beav1.1) +
  ggtitle("Long-Term Temperature Dynamics of Beavers", subtitle = "beavers dataset provided by R") +
  geom_line(aes(x = beav1.1$time, y = beav1.1$temp),
            color = "red", lwd = 2, alpha = 0.5) +
  theme(
    plot.title = element_text(size = 17, face = "bold", color = "black"),
    plot.subtitle = element_text(size = 13, face = "italic", color = "black"), 
    panel.background = element_blank(), plot.background = element_blank(),
    panel.grid.major = element_line(color = "gray"), panel.grid.minor = element_line(color = "gray"),
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
  scale_x_continuous(name = "Time") +
  scale_y_continuous(name = "Body Temperature, degrees Celcius") +
  scale_fill_manual(guide_legend(title = "Beaver", position = "right", nrow = 1)) +
  labs(caption = "plot by @MilesToKilo")

beav

# Save your graph
ggsave(beav, filename = paste("graph_line_beaver.png"), path = "Pictures")

# Raincloud Plots --------------------------------------------------------------

# For Referencing raincloud plots:
## "Allen M, Poggiali D, Whitaker K et al. Raincloud plots: a multi-platform tool for 
## robust data visualization [version 1; peer review: 2 approved]. Wellcome Open Res 
## 2019, 4:63. DOI: 10.12688/wellcomeopenres.15191.1"
## "Allen M, Poggiali D, Whitaker K, Marshall TR, Kievit R. (2018) RainCloudPlots 
## tutorials and codebase (Version v1.1). Zenodo. http://doi.org/10.5281/zenodo.3368186"

# Use cowplot and plyr packages
# Information on how everything is done
browseURL("https://github.com/RainCloudPlots/RainCloudPlots/blob/master/tutorial_R/raincloud_tutorial_r.pdf")

### Copy/Paste and then run code ###
### It's necessary for the function to work ###
"%||%" <- function(a, b) {
  if (!is.null(a)) a else b
}

geom_flat_violin <- function(mapping = NULL, data = NULL, stat = "ydensity",
                             position = "dodge", trim = TRUE, scale = "area",
                             show.legend = NA, inherit.aes = TRUE, ...) {
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomFlatViolin,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      trim = trim,
      scale = scale,
      ...
    )
  )
}
GeomFlatViolin <-
  ggproto("GeomFlatViolin", Geom,
          setup_data = function(data, params) {
            data$width <- data$width %||%
              params$width %||% (resolution(data$x, FALSE) * 0.9)
            
            # ymin, ymax, xmin, and xmax define the bounding rectangle for each group
            data %>%
              group_by(group) %>%
              mutate(ymin = min(y),
                     ymax = max(y),
                     xmin = x,
                     xmax = x + width / 2
  )
          },
  
  draw_group = function(data, panel_scales, coord) {
    # Find the points for the line to go all the way around
    data <- transform(data, xminv = x,
                      xmaxv = x + violinwidth * (xmax - x))
    
    # Make sure it's sorted properly to draw the outline
    newdata <- rbind(plyr::arrange(transform(data, x = xminv), y),
                     plyr::arrange(transform(data, x = xmaxv), -y))
    
    # Close the polygon: set first and last point the same
    # Needed for coord_polar and such
    newdata <- rbind(newdata, newdata[1,])
    
    ggplot2:::ggname("geom_flat_violin", GeomPolygon$draw_panel(newdata, panel_scales, coord))
  },
  
  draw_key = draw_key_polygon,
  
  default_aes = aes(weight = 1, colour = "grey20", fill = "white", size = 0.5,
                    alpha = NA, linetype = "solid"),
  
  required_aes = c("x", "y")
  )

#### College Example ####
college[1:5,]
str(college)
rain_basic <-
  ggplot(college, aes(x = control, y = sat_avg, 
                      fill = control, color = control)) +
  geom_flat_violin(position = position_nudge(x = .3, y = 0), 
                   adjust = 2) + # change adjust for smoothing of distribution
  geom_point(position = position_jitter(width = .15), size = .25) +
  geom_boxplot(aes(x = as.numeric(control) + 0.25, y = sat_avg),
               outlier.shape = NA, alpha = 0.3, width = .1, colour = "BLACK") +
  ylab('Score') + xlab('College') + 
  theme_cowplot() + guides(fill = FALSE, color = FALSE) +
  scale_colour_brewer(palette = "Dark2") +
  scale_fill_brewer(palette = "Dark2") +
  ggtitle('Basic Raincloud Plot',
          subtitle = "dataset provided by Mike Chapple from Lynda.com") +
  coord_flip() +
  labs(caption = "plot by @MilesToKilo")
rain_basic
# Save your graph
ggsave(rain_basic, filename = paste("graph_rain_collegeBasic.png"), path = "Pictures")

# Must calculate summary statistics for mean with errorbars
# Have not completed the following example
# college_sum <- college %>%
#   mutate(sat_mean = mean(sat_avg),
#          sd_pos = mean(sat_avg) + sd(sat_avg),
#          sd_neg = mean(sat_avg) - sd(sat_avg))
# head(college_sum)
# ggplot(college, aes(x=control,y=sat_avg, fill = control, color = control))+
#   geom_flat_violin(position = position_nudge(x = .3, y = 0),adjust = 2)+ # change adjust for smoothing of distribution
#   geom_point(position = position_jitter(width = .15), size = .25)+
#   geom_point(data = college_sum, aes(x = college$control, y = sat_mean), position = position_nudge(.25), colour = "BLACK")+
#   geom_errorbar(data = college_sum, aes(x = college$control, y = sat_mean, ymin = sd_neg, ymax = sd_pos), position = position_nudge(.25), colour = "BLACK", width = 0.1, size = 0.8)+
#   ylab('Score')+xlab('Group')+theme_cowplot()+guides(fill = FALSE, color = FALSE) +
#   scale_colour_brewer(palette = "Dark2")+
#   scale_fill_brewer(palette = "Dark2")+
#   ggtitle('Rainclouds w/confidence intervals') +
#   coord_flip()

## Finally, in many situations you may have nested, factorial, or repeated 
## measures data. In this case, one option is to use plot facets to group by 
## factor, emphasizing pairwise differences between conditions or factor levels:
rain_complex <- 
ggplot(college, aes(x = control, y = sat_avg, 
                    fill = control, colour = control)) +
  geom_flat_violin(position = position_nudge(x = .25, y = 0), 
                   adjust =2, trim = TRUE) +
  geom_point(position = position_jitter(width = .15), size = .25) +
  geom_boxplot(aes(x = as.numeric(control) + 0.25, y = sat_avg), 
               outlier.shape = NA, alpha = 0.3, width = .1, colour = "BLACK") +
  ylab('SAT Score') + xlab('College') + coord_flip() + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) + facet_wrap(college$highest_degree) +
  scale_colour_brewer(palette = "Dark2") +
  scale_fill_brewer(palette = "Dark2") +
  ggtitle("Complex Raincloud Plots with Facet Wrap", 
          subtitle = "dataset provided by Mike Chapple from Lynda.com") +
  labs(caption = "plot by @MilesToKilo")
rain_complex
# Save your graph
ggsave(rain_complex, filename = paste("graph_rain_collegeComplex.png"), path = "Pictures")

?scale_color_brewer

# ggRidges Plot ----------------------------------------------------------------
browseURL("https://cran.r-project.org/web/packages/ggridges/vignettes/introduction.html")

### College Example ###
str(college)

## ggRidges plot with most variables adjusted
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
ggsave(gridge, filename = paste("graph_ggridges_college.png"), path = "Pictures")

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
ggsave(gridge, filename = paste("graph_ggridges_collegeGradient.png"), path = "Pictures")

#### Final Products ####
chick # Bar Graph
fert # Stacked Histogram
flower # Scatterplot
school # Scatterplot
sl.v # Vertical Violin Plot
sl.h # Horizontal Violin Plot
beav # Line Plot
rain_basic # Raincloud Plot
rain_complex # Raincloud Plot
gridge # ggRidges Plot
gridge_grad # ggRidges plot with gradient

# Clean Up
rm(list = ls())
detach("package:tidyverse", unload = TRUE)
detach("package:directlabels", unload = TRUE)
detach("package:RColorBrewer", unload = TRUE)
detach("package:cowplot", unload = TRUE)
detach("package:ggridges", unload = TRUE)
detach("package:plyr", unload = TRUE)
