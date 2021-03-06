Sys.setenv(TZ = "Africa/Johannesburg")

# .libPaths("/Library/Frameworks/R.framework/Versions/3.3/Resources/library")
# .libPaths("/Applications/anaconda/lib/R/library")
# .libPaths()

# options( java.parameters = c("-Xss2560k", "-Xmx2g") )

require(jsonlite)
# remove.packages("mailR")
# remove.packages("rJava")
# options(java.parameters = "-Xss2560k")
# 
# install.packages("rJava", repos="http://cran.rstudio.com/", dependencies = T)
# install.packages("mailR", repos="http://cran.rstudio.com/", dependencies = T)


# require(rJava)
# library(mailR)

# tracking_df <- data.frame(Time = NULL, CEX = NULL, Luno = NULL, ZAR = NULL, Premium = NULL)
tracking_df <- readRDS("tracking_df.rds")
key_info <- readRDS("key_info.rds")
key_info$Key <- as.character(key_info$Key)
api_layer_path <- key_info$Key[1]
email_password <- key_info[3]

while(T){
  try({
    CEX_all <- fromJSON(file("https://cex.io/api/ticker/BTC/USD"), simplifyVector = FALSE)
    CEX_BTClast <- as.numeric(CEX_all$ask, type = "double") #changed to ask
    
    Luno_all <- fromJSON(file("https://api.mybitx.com/api/1/ticker?pair=XBTZAR"), simplifyVector = FALSE)
    Luno_BTClast <- as.numeric(Luno_all$bid, type = "double") #changed to bid
    
    CL_all <- fromJSON(file(api_layer_path), simplifyVector = FALSE)
    CL_ZArlast <- as.numeric(CL_all$quotes$USDZAR, type = "double")
    
    Luno_premium <- (Luno_BTClast / CL_ZArlast) / CEX_BTClast
    
    tracking_df <- rbind(tracking_df, data.frame(Time = Sys.time(), CEX = CEX_BTClast, Luno = Luno_BTClast, ZAR = CL_ZArlast, Premium = Luno_premium))
    saveRDS(tracking_df, "tracking_df.rds")
    
    # if (Luno_premium >= 1.11){
    #   
    #   # text_to_send <- paste0("Arbitrage opp - premium is: ", round(Luno_premium, 4))
    #   text_to_send <- paste0("Time: ", Sys.time(),
    #                          ", Opp, prem: ", round(Luno_premium, 4),
    #                          ", CEX: ", round(CEX_BTClast, 2),
    #                          ", Luno: ", round(Luno_BTClast, 2),
    #                          ", ZAR: ", round(CL_ZArlast, 2),
    #                          ", Luno spread: ", round(as.numeric(Luno_all$ask, type = "double") - as.numeric(Luno_all$bid, type = "double"), 2))
    #   
    #   send.mail(from = "blakec.mailr@gmail.com",
    #             to = c("blake.rsa@gmail.com"),
    #             replyTo = c("blake.rsa@gmail.com"),
    #             subject = "BTC Arbitrage opportuntity",
    #             body = text_to_send,
    #             smtp = list(host.name = "smtp.gmail.com", port = 465, user.name = "blakec.mailr", passwd = email_password, ssl = TRUE),
    #             authenticate = TRUE,
    #             send = TRUE)
    #   
    #   print(paste0("Time: ", Sys.time(),
    #                ", Opp, prem: ", round(Luno_premium, 4),
    #                ", CEX: ", round(CEX_BTClast, 2),
    #                ", Luno: ", round(Luno_BTClast, 2),
    #                ", ZAR: ", round(CL_ZArlast, 2),
    #                ", Luno spread: ", round(as.numeric(Luno_all$ask, type = "double") - as.numeric(Luno_all$bid, type = "double"), 2)))
    # } else {
    #   
      print(paste0("Time: ", Sys.time(),
                   ", Prem: ", round(Luno_premium, 4),
                   ", CEX: ", round(CEX_BTClast, 2),
                   ", Luno: ", round(Luno_BTClast, 2),
                   ", ZAR: ", round(CL_ZArlast, 2),
                   ", Luno spread: ", round(as.numeric(Luno_all$ask, type = "double") - as.numeric(Luno_all$bid, type = "double"), 2)))
    # }
  }, silent = TRUE)
  Sys.sleep(1800)
  
}



# quit(save = "no")
