# 
#
# API docs: https://spark.apache.org/docs/1.6.1/api/R/index.html
#
# SPARK_HOME needs to be defined (maybe in .Rprofile)
#

#load dependencites for visualisations
library(manipulate)
library(ggplot2)

#init local spark
source('spark.local.R')

#load dataFrame from a csv file
housingDF <- read.df(dc, "../data/housing.csv", source="csv", 
                     header='true', inferschema='true', delimiter=',', nullValue="NA")


#basic data frame operations

housingDF

head(housingDF)

count(housingDF)

colnames(housingDF)

# some things are a bit different thought

summary(housingDF)

collect(summary(housingDF))

housingDF$county

select(housingDF, housingDF$county)

head(select(housingDF, housingDF$county))

# filtering

head(housingDF[housingDF$medListPriceSqft < 100, c("county","medListPriceSqft")])

first(subset(housingDF, housingDF$medListPriceSqft > 100))

#aggregations

head(avg(groupBy(housingDF)))

head(avg(groupBy(housingDF, housingDF$state)))

head(min(groupBy(housingDF, housingDF$county, housingDF$state)))

head(summarize(groupBy(housingDF,"county", "state"),
         medListPriceSqftMean=mean(housingDF$medListPriceSqft), 
         medListPriceSqftStdDev=stddev(housingDF$medListPriceSqft),
         medListPriceSqftCurt=kurtosis(housingDF$medListPriceSqft)
))

# transformations

head(transform(housingDF, priceDiff = abs(housingDF$medSoldPriceSqft -  housingDF$medListPriceSqft)))

## there is also in place mutate
## not all R functions are available here (see the API docs for the list)

housingDFWithTime <- transform(housingDF, newcold = expr("unix_timestamp(time,'yyyy-MM-dd')"))

#
# basic GLM
#

housingDFWithTimestamp <- transform(housingDF, timestamp = unix_timestamp(housingDF$time,format='yyyy-MM-dd'))
first(housingDFWithTimestamp)

cache(housingDFWithTimestamp)
count(housingDFWithTimestamp)

model <- glm(medSoldPriceSqft ~ timestamp:state, dropna(housingDFWithTimestamp, cols=c("medSoldPriceSqft")), family="gaussian")

summary(model)

state_coeffs <- summary(model)$coefficients
state_names = sapply(strsplit(names(state_coeffs[-1, 1]), "_"), FUN=function(x){x[2]})
state_slopes = as.numeric(state_coeffs[-1, 1])
state_order = order(state_slopes, decreasing=FALSE)

par(las=2) # make label text perpendicular to axis
barplot(state_slopes[state_order], names.arg=state_names[state_order], horiz=TRUE, cex.names=0.6, 
         main="Price change over time per state")

# interactive plot

states <- collect(arrange(distinct(select(housingDF, housingDF$state)),housingDF$state))
                  
manipulate(
    ggplot(collect(filter(housingDFWithTimestamp, housingDFWithTimestamp$state == state)),
           aes(x=timestamp,y=medSoldPriceSqft)) 
        + geom_point() + stat_smooth(method="lm"),
    state = do.call(picker, as.list(states$state))
)

# other stuff
# sampling and correlation

housingDFNonNa <-dropna(housingDF, how="any", cols=c("medListPriceSqft", "medSoldPriceSqft"))
corr <- corr(housingDFNonNa, 
        "medListPriceSqft", "medSoldPriceSqft", method = "pearson")
print(corr)

housingDFsample100 <- collect(sample(housingDFNonNa, withReplacement=FALSE, fraction=0.05, 15))

ggplot(housingDFsample100, aes(x=medSoldPriceSqft,y=medListPriceSqft, col=state)) +
    geom_point()

