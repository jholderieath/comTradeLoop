devtools::use_package("rjson")
devtools::use_package("plyr")
devtools::use_package("jsonlite")
#will iterate over list of reporters and years
## create a list of country ISO3 number for reporters
r <- c("842", "826", "752")
#create a list of times
ps <- c("2013", "2014", "2015")
#create a list of classification codes as a string
cc <- "0101,0102,0103,0104,0105,0106,0201,0202,0203,0204,0205,0206,0207,0208,0209,0210,04,05"

multComtrade <- function(r, p="all", ps, px= "HS",rg="2", cc, max="250000"){
    for (a in 1:length(r)){
        for (b in 1:length(ps)){
            c <- get.ComtradeL(r=r[a],ps=ps[b],cc=cc)
        }
    }
}
    var1 = rep(r, length(ps))
    var1 = var1[order(var1)]
    var2 = rep(ps, length(r))
    df = data.frame(r = var1, ps = var2)
    
}
 

hs_4_2010 <-get.Comtrade(r="4", p="all", ps="2010", rg="2", cc, max="50000")
