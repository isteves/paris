library(tidyverse)
library(lubridate)

events <- tibble(event = c("restaurant week", "shopalooza",
                           "gaming convention", "medical conference",
                           "frisbee tournament"),
                 start = ymd("2018-08-30") + sample(5, 5),
                 end = start + sample(5, 5))

events %>% 
    gather(bounds, dates, -event) %>% 
    ggplot(aes(dates, event)) +
    geom_point() +
    geom_line()

all <- events %>% 
    mutate(period = end - start) %>% 
    mutate(all_dates = map2(start, period, ~.x + 0:.y)) %>% 
    unnest(all_dates) 

all %>% 
    ggplot(aes(all_dates, event)) +
    geom_point() +
    geom_line()

all %>% 
    ggplot(aes(all_dates)) +
    geom_bar()

all %>% 
    count(all_dates) %>% 
    top_n(1)
