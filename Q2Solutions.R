##Quiz 2
setwd("./Courses/Getting&CleaningData/Quiz2")

#Question 1
library(httr)

#Determine github oauth settings
oauth_endpoints("github")
#<oauth_endpoint>
#authorize: https://github.com/login/oauth/authorize
#access:    https://github.com/login/oauth/access_token

#register for app via: https://github.com/settings/developers
Test_app <- oauth_app("github", key = "b7de38c9bfdf53e1e168", secret = "29b2dca14cd576f5ca1854f8f265dccabd3974b0")
github_token <- oauth2.0_token(oauth_endpoints("github"), Test_app)
req <- GET("https://api.github.com/rate_limit", config(token = github_token))
stop_for_status(req)
content(req)
BROWSE("https://api.github.com/users/jtleek/repos",authenticate("Access Token","x-oauth-basic","basic"))
#2013-11-07T13:25:07Z

#Question 2
library(sqldf)
Q2fileURL <-  "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(Q2fileURL, destfile = "acs.csv")
acs <- read.csv("acs.csv")
sqldf("select pwgtp1 from acs where AGEP < 50")
#Solution: sqldf("select pwgtp1 from acs where AGEP < 50")

#Question 3
sqldf("select distinct AGEP from acs")
length(unique(acs$AGEP))
#Output:
#[1] 91
#Solution: 91

# Question 4
Q4fileURL <- "http://biostat.jhsph.edu/~jleek/contact.html" 
Q4con <- url(Q4fileURL)
Q4html <- readLines(Q4con)
close(Q4con)
sapply(Q4html[c(10, 20, 30, 100)], nchar)
#Ouput:
#<meta name="Distribution" content="Global" /> 
#45 
#<script type="text/javascript"> 
#     31 
#})(); 
#7 
#\t\t\t\t<ul class="sidemenu"> 
#    25 
#Solution: 45 31 7 25

#Question 5
Q5fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(Q5fileURL, destfile = "Q5Data.for")
df <- read.fwf("Q5Data.for", skip=4, widths=c(12, 7,4, 9,4, 9,4, 9,4))
sum(df$V4)
#Output:
#[1] 32426.7
#Solution: 32426.7

