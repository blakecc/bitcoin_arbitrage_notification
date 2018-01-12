library(ggplot2)
library(magrittr)
library(dplyr)

intermediate_check <- readRDS("tracking_df.rds")
intermediate_check$log_Luno <- log10(intermediate_check$Luno)

t_rows <- nrow(intermediate_check)
graph_length <- 1000

intermediate_check %>%
  slice(c((t_rows - graph_length):t_rows)) %>%
  ggplot() +
  theme_minimal() +
  theme(axis.text.x=element_text(angle=45, hjust=1)) +
  ggtitle("ZAR exchange rate") +
  # stat_smooth(aes(x = Time, y = ZAR), span = 0.17)
  geom_line(aes(x = Time, y = ZAR))

intermediate_check %>%
  slice(c((t_rows - graph_length):t_rows)) %>%
  ggplot() +
    theme_minimal() +
    theme(axis.text.x=element_text(angle=45, hjust=1)) +
    ggtitle("Luno ZAR exchange price premium to CEX") +
    geom_hline(yintercept = 1) +
    # stat_smooth(aes(x = Time, y = Premium), span = 0.1)
    geom_line(aes(x = Time, y = Premium))

intermediate_check %>%
  slice(c((t_rows - graph_length):t_rows)) %>%
  ggplot() +
  theme_minimal() +
  theme(axis.text.x=element_text(angle=45, hjust=1)) +
  ggtitle("Log Luno ZAR exchange price") +
  # stat_smooth(aes(x = Time, y = Luno), span = 0.17)
  geom_line(aes(x = Time, y = log_Luno))
# geom_jitter(aes(x = Time, y = Luno))

intermediate_check %>%
  slice(c((t_rows - graph_length):t_rows)) %>%
  ggplot() +
  theme_minimal() +
  theme(axis.text.x=element_text(angle=45, hjust=1)) +
  ggtitle("Luno ZAR exchange price") +
  # stat_smooth(aes(x = Time, y = Luno), span = 0.17)
  geom_line(aes(x = Time, y = Luno))
  # geom_jitter(aes(x = Time, y = Luno))

intermediate_check %>%
  slice(c((t_rows - graph_length):t_rows)) %>%
  ggplot() +
  theme_minimal() +
  theme(axis.text.x=element_text(angle=45, hjust=1)) +
  ggtitle("CEX exchange price") +
  # stat_smooth(aes(x = Time, y = CEX), span = 0.1)
  geom_line(aes(x = Time, y = CEX))

intermediate_check %>% slice(c(t_rows - 1, t_rows))