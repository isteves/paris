library(tidyverse)

lunch <- tribble(
    ~name, ~lunch_items,
    "Hélène", "cola; fries; burger",
    "Tammy", "salad; crêpe"
)

# Encoding is handled differently by base R vs the tidyverse
write.csv(lunch, "lunch.csv", row.names = FALSE)
read.csv("lunch.csv")
write_csv(lunch, "lunch.csv")
read_csv("lunch.csv")

# To separate all lunch_items by semicolons, you can use a `str_split` and `unnest`
lunch %>% 
    mutate(lunch_items = str_split(lunch_items, "; ")) %>% 
    unnest(lunch_items)

# ...but the `separate_rows` function does the same thing even more concisely!
lunch %>% 
    separate_rows(lunch_items, sep = "; ")

# lunch_items is essentially a kind of list column
# You can turn it into a real list-column by using either `nest` or `list`. Notice how the two methods produce slightly different types of list-columns
lunch %>% 
    separate_rows(lunch_items) %>% 
    nest(lunch_items) 

lunch %>% 
    separate_rows(lunch_items) %>% 
    group_by(name) %>% 
    summarize(data = list(lunch_items))
