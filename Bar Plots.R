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

# Load packages
# Loads ggplot and all other essential packages
if (!require("tidyverse")) { # If you can't load package
  install.packages("tidyverse", dependencies = TRUE) # Install the package
  library(tidyverse) # And load it
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
    mapping = aes(x = feed, # Bar graph data
                         fill = feed # Fill bar colors according to variable
                         # sort.list(feed, decreasing = TRUE)
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
    mapping = aes(x = feed, fill = feed)) +
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
       path = "Pictures",  # Destination
       height = 20, width = 20, units = "cm") 
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
ggsave(fert, filename = paste("graph_histo_fertility.png"), path = "Pictures", 
       height = 20, width = 20, units = "cm")

#### Final Products ####
chick # Bar Graph
fert # Stacked Histogram

# Clean Up
rm(list = ls())
detach("package:tidyverse", unload = TRUE)
