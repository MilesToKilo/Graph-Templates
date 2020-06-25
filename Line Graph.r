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
ggsave(beav, filename = paste("graph_line_beaver.png"), 
       path = "Pictures") # Destination
# Ideally, you have a folder within your directory for saving these graphs 

#### Final Product ####
beav

# Clean Up
rm(list = ls())
detach("package:tidyverse", unload = TRUE)
