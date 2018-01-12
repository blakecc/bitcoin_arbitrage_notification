library(data.table)
library(lubridate)
library(scales)
library(tidyverse)


CEX_data <- readxl::read_excel("../ExchangeComp/170921_CEXdata_bitcoinchartsdotcom.xlsx")
Bitstamp_data <- readxl::read_excel("../ExchangeComp/170921_Bitstampdata_bitcoinchartsdotcom.xlsx")

Bitstamp_data$Timestamp <- parse_date_time(Bitstamp_data$Timestamp, "%Y-%m-%d %H:%M:%S")
CEX_data$Timestamp <- parse_date_time(CEX_data$Timestamp, "%Y-%m-%d %H:%M:%S")

combined_data <- inner_join(Bitstamp_data, CEX_data, by = "Timestamp")

combined_data <- combined_data %>%
  rename(Bitstamp_close = Close.x,
         CEX_close = Close.y) %>%
  select(Timestamp, Bitstamp_close, CEX_close) %>%
  mutate(CEX_premium = CEX_close / Bitstamp_close)

ggplot(combined_data) +
  stat_smooth(aes(x = Timestamp, y = Bitstamp_close, colour = "Bitstamp"), method = "loess", span = 0.01) +
  stat_smooth(aes(x = Timestamp, y = CEX_close, colour = "CEX"), method = "loess", span = 0.01) +
  scale_color_discrete("") +
  theme_light() +
  theme(axis.text.x=element_text(angle=45, hjust=1)) +
  ggtitle("Comparison between CEX and Bitstamp exchanges")

ggplot(combined_data) +
  stat_smooth(aes(x = Timestamp, y = CEX_premium), method = "loess", span = 0.15) +
  theme_light() +
  theme(axis.text.x=element_text(angle=45, hjust=1)) +
  ggtitle("CEX premium to Bitstamp")

