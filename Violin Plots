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
if (!require("tidyverse")) {
  install.packages("tidyverse", dependencies = TRUE)
  library(tidyverse)
}

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
ggsave(sl.v, filename = paste("graph_violin_sleepVertical.png"), 
       path = "Pictures") # Destination
# Ideally, you have a folder within your directory for saving these graphs 

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
ggsave(sl.h, filename = paste("graph_violin_sleepHorizontal.png"), 
       path = "Pictures") # Destination
# Ideally, you have a folder within your directory for saving these graphs 

#### Final Products ####
sl.v # Vertical Violin Plot
sl.h # Horizontal Violin Plot

# Clean Up
rm(list = ls())
detach("package:tidyverse", unload = TRUE)
