I created this when I first began coding, so I list different options for selecting colors. 
My go-to color choices are from RColorBrewer mainly because they have color-blind friendly palettes.

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
