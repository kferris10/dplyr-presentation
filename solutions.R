
library(ggplot2)
library(dplyr)
library(nycflights13)

f_df <- tbl_df(flights)

# Remove any rows where arr_delay or dep_delay are missing
f_df2 <- f_df %>% 
  filter(!is.na(arr_delay), !is.na(dep_delay))


# We'll only use the year, month, day, distance, dep_delay, arr_delay, carrier, and tailnum columns
f_df3 <- f_df2 %>% 
  select(year, month, day, distance, dep_delay, arr_delay, carrier, tailnum)
f_df3

# create a new column for total delay which is delay on departure plus delay on arrival
## don't use any dollar signs
f_df4 <- f_df3 %>% mutate(tot_delay = dep_delay + arr_delay)
f_df4

# practice chaining by combining these four steps into one 
f <- flights %>% 
  tbl_df() %>% 
  filter(!is.na(arr_delay), !is.na(dep_delay)) %>% 
  select(year, month, day, distance, dep_delay, arr_delay, carrier, tailnum) %>% 
  mutate(tot_delay = dep_delay + arr_delay)

# when did the longest delay occur?
f %>% 
  arrange(desc(tot_delay))

# Use group_by to find the average and total (sum) of delay for each month
f %>% 
  group_by(month) %>% 
  summarise(avg = mean(tot_delay), 
            tot = sum(tot_delay))

# which airplane had the longest delays on average? which carrier did it belong to?
f %>% 
  group_by(carrier, tailnum) %>% 
  summarise(tot = sum(tot_delay, na.rm = T)) %>% 
  arrange(desc(tot))

# plot of delay vs dist
qplot(distance, tot_delay, data = f)

# summarizing and removing
plot_dat <- f %>% 
  group_by(tailnum) %>% 
  summarise(avg_delay = mean(tot_delay), 
            avg_dist = mean(distance), 
            count = n()) %>% 
  filter(count > 20, avg_dist < 2000)
# plot by airplane
ggplot(plot_dat, aes(avg_dist, avg_delay)) +
  geom_point(aes(size = count), alpha = 1/2) +
  geom_smooth() +
  scale_size_area()


