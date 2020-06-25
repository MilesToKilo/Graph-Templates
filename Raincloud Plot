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
# Color palettes for examples
if (!require("RColorBrewer")) {
  install.packages("RColorBrewer", dependencies = TRUE)
  library(RColorBrewer)
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

# Raincloud Plots --------------------------------------------------------------

# These plots are packed with information! It combines jitter and violin plots.
# Make sure to reference the creators if you end up using their code. 
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
ggsave(rain_basic, filename = paste("graph_rain_collegeBasic.png"), 
       path = "Pictures") # Destination
# Ideally, you have a folder within your directory for saving these graphs 

## In many situations you may have nested, factorial, or repeated 
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
ggsave(rain_complex, filename = paste("graph_rain_collegeComplex.png"), 
       path = "Pictures") # Destination
# Ideally, you have a folder within your directory for saving these graphs 

#### Final Products ####
rain_basic # Basic Raincloud Plot
rain_complex # Complex Raincloud Plot

# Clean Up
rm(list = ls())
detach("package:tidyverse", unload = TRUE)
detach("package:RColorBrewer", unload = TRUE)
detach("package:cowplot", unload = TRUE)
detach("package:plyr", unload = TRUE)
