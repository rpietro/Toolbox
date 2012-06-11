# options(RCurlOptions = list(capath = system.file("CurlSSL", "cacert.pem", package = "RCurl"), ssl.verifypeer = FALSE))
# #see http://goo.gl/mQwxO on how to get this link
# #link below won't work until data is entered in the right format
# 
# olecranon.dat <- getURL("https://docs.google.com/spreadsheet/pub?key=0ArVW3PoO2euydHVHcVU2S3BROWRYM29OYWhNTGlMUVE&single=true&gid=5&output=csv", header=TRUE)
# olecranon.data <- read.csv(textConnection(olecranon.dat), header=TRUE)
# head(olecranon.data) #first row is wrong, below will first replace variable names by first row and then delete first row
# olecranon.data[1,]
# view(olecranon.data)
# as.character(olecranon.data[1,])
# names(olecranon.data)  <- as.character(olecranon.data[1,])
# names(olecranon.data)
