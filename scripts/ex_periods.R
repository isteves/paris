library(tidyverse)
library(lubridate)

events <- tibble(event = c("restaurant week", "shopalooza",
                           "gaming convention", "medical conference",
                           "frisbee tournament"),
                 start = ymd("2018-08-30") + sample(5, 5),
                 end = start + sample(5, 5))

# When do the most events overlap?

# Plot to visually check the overlap
events %>% 
    gather(bounds, dates, -event) %>% 
    ggplot(aes(dates, event)) +
    geom_point() +
    geom_line()

# For each event, list out all dates
all <- events %>% 
    mutate(period = end - start) %>% 
    mutate(all_dates = map2(start, period, ~.x + 0:.y)) %>% 
    unnest(all_dates) 

# Plot to check the changes
all %>% 
    ggplot(aes(all_dates, event)) +
    geom_point() +
    geom_line()

# Visualize number of events for each date
all %>% 
    ggplot(aes(all_dates)) +
    geom_bar()

# Or find the number of events for each date analytically
all %>% 
    count(all_dates) %>% 
    top_n(1)
