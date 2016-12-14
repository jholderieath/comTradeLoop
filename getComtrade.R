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

multComtrade <-
    function(url = "http://comtrade.un.org/api/get?", maxrec = 250000, type = "C", freq = "A", px = "HS", ps = "now", r, p = "all", rg = "all",
             cc = "TOTAL", fmt = "json") {
        if (length(r) == 1 & length(ps) == 1) {
            string <-
                paste(
                    url, "max=", maxrec, "&"  #maximum no. of records returned
                    , "type=", type, "&"  #type of trade (c=commodities)
                    ,
                    "freq=", freq, "&"  #frequency
                    , "px=", px, "&"  #classification
                    , "ps=", ps, "&"  #time period
                    ,
                    "r=", r, "&"  #reporting area
                    , "p=", p, "&"  #partner country
                    , "rg=", rg, "&"  #trade flow
                    ,
                    "cc=", cc, "&"  #classification code
                    , "fmt=", fmt  #Format
                    , sep = ""
                )
            if (fmt == "csv") {
                raw.data <- read.csv(string, header = TRUE)
                return(list(validation = NULL, data = raw.data))
            } else {
                if (fmt == "json") {
                    raw.data <- fromJSON(file = string)
                    data <- raw.data$dataset
                    validation <-
                        unlist(raw.data$validation, recursive = TRUE)
                    ndata <- NULL
                    if (length(data) > 0) {
                        var.names <- names(data[[1]])
                        data <- as.data.frame(t(sapply(data, rbind)))
                        ndata <- NULL
                        for (i in 1:ncol(data)) {
                            data[sapply(data[, i], is.null), i] <- NA
                            ndata <- cbind(ndata, unlist(data[, i]))
                        }
                        ndata <- as.data.frame(ndata)
                        colnames(ndata) <- var.names
                    }
                    return(list(validation = validation, data = ndata))
                }
            }
        } else {
            for (a in 1:length(r)) {
                for (b in 1:length(ps)) {
                    r=r[a]
                    ps=ps[b]
                    string <-
                        paste(
                            url, "max=", maxrec, "&"  #maximum no. of records returned
                            , "type=", type, "&"  #type of trade (c=commodities)
                            ,
                            "freq=", freq, "&"  #frequency
                            , "px=", px, "&"  #classification
                            , "ps=", ps, "&"  #time period
                            , "r=", r, "&"  #reporting area
                            , "p=", p, "&"  #partner country
                            , "rg=", rg, "&"  #trade flow
                            , "cc=", cc, "&"  #classification code
                            , "fmt=", fmt  #Format
                            , sep = ""
                        )
                    if (fmt == "csv") {
                        raw.data <- read.csv(string, header = TRUE)
                        return(list(validation = NULL, data = raw.data))
                    } else {
                        if (fmt == "json") {
                            raw.data <- fromJSON(file = string)
                            data <- raw.data$dataset
                            validation <-
                                unlist(raw.data$validation, recursive = TRUE)
                            ndata <- NULL
                            if (length(data) > 0) {
                                var.names <- names(data[[1]])
                                data <- as.data.frame(t(sapply(data, rbind)))
                                ndata <- NULL
                                for (i in 1:ncol(data)) {
                                    data[sapply(data[, i], is.null), i] <- NA
                                    ndata <- cbind(ndata, unlist(data[, i]))
                                }
                                ndata <- as.data.frame(ndata)
                                colnames(ndata) <- var.names
                            }
                            return(list(
                                validation = validation, data = ndata
                            ))
                            Sys.sleep(40)
                        }
                    }
                }
            }
        }
    }
