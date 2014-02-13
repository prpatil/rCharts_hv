library(rCharts)
library(MASS)
library (nnet) # contains function multinom
library(colorspace)

# Point your working dir to .../rCharts_hv/
setwd(SET/TO/YOUR/FOLDER)
source("healthvis.R")
source("icon_ArrayRC.R")

mobj <- multinom(Age~Eth+Sex+Lrn+Days, data=quine)
fig <- iconArrayRC(mobj, data=quine, colors=rainbow_hcl(4), plot.title="School Absenteeism")

fig$setLib(getwd())
fig$setTemplate(page="rChartControls2.html",script="icon_array.html")
fig

# If you set all 4 options, you should see the figure update