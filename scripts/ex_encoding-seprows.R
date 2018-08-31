library(tidyverse)

lunch <- tribble(
    ~name, ~lunch_items,
    "Hélène", "cola; fries; burger",
    "Tammy", "salad; crêpe"
)

write.csv(lunch, "lunch.csv", row.names = FALSE)
read.csv("lunch.csv")
write_csv(lunch, "lunch.csv")
read_csv("lunch.csv")

lunch %>% 
    mutate(lunch_items = str_split(lunch_items, "; ")) %>% 
    unnest(lunch_items)

lunch %>% 
    separate_rows(lunch_items)

lunch %>% 
    separate_rows(lunch_items) %>% 
    nest(lunch_items) 

lunch %>% 
    separate_rows(lunch_items) %>% 
    group_by(name) %>% 
    summarize(data = list(lunch_items))
