---
title       : dplyr
subtitle    : A gamechanger for data manipulation in R
author      : Kevin Ferris
job         : Montana State University
framework   : io2012        # 
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
assets:
  css:
    - "assets/css/styles.css"
---





## dplyr

A new R package written by Hadley Wickham and Romain Francois (Wickham and Francois, 2014)

It provides a "flexible grammar of data manipulation"

> * Identifies the most important tasks in data manipulation and makes them easy to use
> * Provides blazing fast performance by writing key code in C++
> * Uses the same interface to manipulate data frames, data tables, and databases

---
## Common functions

1. `tbl_df`: for printing data.frames nicely
2. `select`: for choosing columns in a dataset
3. `filter`: for choosing rows in a dataset
4. `arrange`: for reordering rows in a dataset
5. `mutate`: for adding new columns to the dataset
6. `group_by`: for creating a grouped dataset
7. `summarise`: for summarizing a dataset

---
## Baseball data for an example

Who hit the most home runs for one team since 1920?


```r
library(Lahman)
head(Batting)
```

```
#>    playerID yearID stint teamID lgID  G G_batting AB R H X2B X3B HR RBI SB
#> 1 aardsda01   2004     1    SFN   NL 11        11  0 0 0   0   0  0   0  0
#> 2 aardsda01   2006     1    CHN   NL 45        43  2 0 0   0   0  0   0  0
#> 3 aardsda01   2007     1    CHA   AL 25         2  0 0 0   0   0  0   0  0
#> 4 aardsda01   2008     1    BOS   AL 47         5  1 0 0   0   0  0   0  0
#> 5 aardsda01   2009     1    SEA   AL 73         3  0 0 0   0   0  0   0  0
#> 6 aardsda01   2010     1    SEA   AL 53         4  0 0 0   0   0  0   0  0
#>   CS BB SO IBB HBP SH SF GIDP G_old
#> 1  0  0  0   0   0  0  0    0    11
#> 2  0  0  0   0   0  1  0    0    45
#> 3  0  0  0   0   0  0  0    0     2
#> 4  0  0  1   0   0  0  0    0     5
#> 5  0  0  0   0   0  0  0    0    NA
#> 6  0  0  0   0   0  0  0    0    NA
```


---
## 1. Print data.frames with `tbl_df()`

Prints nicely and prevents you from accidentally printing the whole dataset.


```r
library(dplyr)
batting_df <- tbl_df(Batting)
batting_df
```

```
#> Source: local data frame [97,889 x 24]
#> 
#>     playerID yearID stint teamID lgID   G G_batting  AB   R   H X2B X3B HR
#> 1  aardsda01   2004     1    SFN   NL  11        11   0   0   0   0   0  0
#> 2  aardsda01   2006     1    CHN   NL  45        43   2   0   0   0   0  0
#> 3  aardsda01   2007     1    CHA   AL  25         2   0   0   0   0   0  0
#> 4  aardsda01   2008     1    BOS   AL  47         5   1   0   0   0   0  0
#> 5  aardsda01   2009     1    SEA   AL  73         3   0   0   0   0   0  0
#> 6  aardsda01   2010     1    SEA   AL  53         4   0   0   0   0   0  0
#> 7  aardsda01   2012     1    NYA   AL   1        NA  NA  NA  NA  NA  NA NA
#> 8  aaronha01   1954     1    ML1   NL 122       122 468  58 131  27   6 13
#> 9  aaronha01   1955     1    ML1   NL 153       153 602 105 189  37   9 27
#> 10 aaronha01   1956     1    ML1   NL 153       153 609 106 200  34  14 26
#> ..       ...    ...   ...    ...  ... ...       ... ... ... ... ... ... ..
#> Variables not shown: RBI (int), SB (int), CS (int), BB (int), SO (int),
#>   IBB (int), HBP (int), SH (int), SF (int), GIDP (int), G_old (int)
```

---
## 2. Select columns with `select()`

Subset columns by name


```r
batting_s <- select(batting_df, playerID, yearID, teamID, G, H, X2B, X3B, HR)
batting_s
```

```
#> Source: local data frame [97,889 x 8]
#> 
#>     playerID yearID teamID   G   H X2B X3B HR
#> 1  aardsda01   2004    SFN  11   0   0   0  0
#> 2  aardsda01   2006    CHN  45   0   0   0  0
#> 3  aardsda01   2007    CHA  25   0   0   0  0
#> 4  aardsda01   2008    BOS  47   0   0   0  0
#> 5  aardsda01   2009    SEA  73   0   0   0  0
#> 6  aardsda01   2010    SEA  53   0   0   0  0
#> 7  aardsda01   2012    NYA   1  NA  NA  NA NA
#> 8  aaronha01   1954    ML1 122 131  27   6 13
#> 9  aaronha01   1955    ML1 153 189  37   9 27
#> 10 aaronha01   1956    ML1 153 200  34  14 26
#> ..       ...    ...    ... ... ... ... ... ..
```

---
## 3. Filter rows with `filter()`

Chooses rows that match your criteria criteria


```r
batting_f <- filter(batting_s, yearID > 2000, HR > 10)
batting_f
```

```
#> Source: local data frame [2,290 x 8]
#> 
#>     playerID yearID teamID   G   H X2B X3B HR
#> 1  abreubo01   2001    PHI 162 170  48   4 31
#> 2  abreubo01   2002    PHI 157 176  50   6 20
#> 3  abreubo01   2003    PHI 158 173  35   1 20
#> 4  abreubo01   2004    PHI 159 173  47   1 30
#> 5  abreubo01   2005    PHI 162 168  37   1 24
#> 6  abreubo01   2007    NYA 158 171  40   5 16
#> 7  abreubo01   2008    NYA 156 180  39   4 20
#> 8  abreubo01   2009    LAA 152 165  29   3 15
#> 9  abreubo01   2010    LAA 154 146  41   1 20
#> 10 ackledu01   2012    SEA 153 137  22   2 12
#> ..       ...    ...    ... ... ... ... ... ..
```

---
## 4. Arrange rows with `arrange()`

Reorders rows


```r
batting_a <- arrange(batting_f, yearID, desc(HR))
batting_a
```

```
#> Source: local data frame [2,290 x 8]
#> 
#>     playerID yearID teamID   G   H X2B X3B HR
#> 1  bondsba01   2001    SFN 153 156  32   2 73
#> 2   sosasa01   2001    CHN 160 189  34   5 64
#> 3  gonzalu01   2001    ARI 162 198  36   7 57
#> 4  rodrial01   2001    TEX 162 201  34   1 52
#> 5  greensh01   2001    LAN 161 184  31   4 49
#> 6  heltoto01   2001    COL 159 197  54   2 49
#> 7  thomeji01   2001    CLE 156 153  26   1 49
#> 8  palmera01   2001    TEX 160 164  33   0 47
#> 9  sexsori01   2001    MIL 158 162  24   3 45
#> 10 glaustr01   2001    ANA 161 147  38   2 41
#> ..       ...    ...    ... ... ... ... ... ..
```

---
## 5. Add new columns with `mutate()`

Adds new columns


```r
batting_m <- mutate(batting_a, X1B = H - X2B - X3B - HR)
batting_m
```

```
#> Source: local data frame [2,290 x 9]
#> 
#>     playerID yearID teamID   G   H X2B X3B HR X1B
#> 1  bondsba01   2001    SFN 153 156  32   2 73  49
#> 2   sosasa01   2001    CHN 160 189  34   5 64  86
#> 3  gonzalu01   2001    ARI 162 198  36   7 57  98
#> 4  rodrial01   2001    TEX 162 201  34   1 52 114
#> 5  greensh01   2001    LAN 161 184  31   4 49 100
#> 6  heltoto01   2001    COL 159 197  54   2 49  92
#> 7  thomeji01   2001    CLE 156 153  26   1 49  77
#> 8  palmera01   2001    TEX 160 164  33   0 47  84
#> 9  sexsori01   2001    MIL 158 162  24   3 45  90
#> 10 glaustr01   2001    ANA 161 147  38   2 41  66
#> ..       ...    ...    ... ... ... ... ... .. ...
```

---
## Steps so far

1. Turn data.frame into a tbl with `tbl_df`
2. Select columns with `select`
3. Select rows with `filter`
4. Arrange rows with `arrange`
5. Add new columns with `mutate`

---
## Nested, Unreadable Code


```r
mutate(
  arrange(
    filter(
      select(
        tbl_df(
          Batting), 
        playerID, yearID, teamID, G, H, X2B, X3B, HR), 
      yearID > 2000, HR > 10), 
    yearID, desc(HR)), 
  X1B = H - X2B - X3B - HR)
```

```
#> Source: local data frame [2,290 x 9]
#> 
#>     playerID yearID teamID   G   H X2B X3B HR X1B
#> 1  bondsba01   2001    SFN 153 156  32   2 73  49
#> 2   sosasa01   2001    CHN 160 189  34   5 64  86
#> 3  gonzalu01   2001    ARI 162 198  36   7 57  98
#> 4  rodrial01   2001    TEX 162 201  34   1 52 114
#> 5  greensh01   2001    LAN 161 184  31   4 49 100
#> 6  heltoto01   2001    COL 159 197  54   2 49  92
#> 7  thomeji01   2001    CLE 156 153  26   1 49  77
#> 8  palmera01   2001    TEX 160 164  33   0 47  84
#> 9  sexsori01   2001    MIL 158 162  24   3 45  90
#> 10 glaustr01   2001    ANA 161 147  38   2 41  66
#> ..       ...    ...    ... ... ... ... ... .. ...
```

---
## Chaining

`dplyr` provides the `%>%` operator.  


```r
x <- 1:3
prod(cumsum(x))
```

```
#> [1] 18
```

```r
x %>% 
  cumsum() %>% 
  prod()
```

```
#> [1] 18
```

> * This executes one command, **THEN** executes a second command.

> * This makes your code much more readable.

---
## Chaining Example


```r
Batting %>%                                                 # takes the Batting data.frame, THEN
  tbl_df() %>%                                              # turns it into a tbl_df, THEN
  select(playerID, yearID, teamID, G, H, X2B, X3B, HR) %>%  # selects the columns, THEN
  filter(yearID > 2000, HR > 10) %>%                        # filters the rows, THEN
  arrange(yearID, desc(HR)) %>%                             # reorders the rows, THEN
  mutate(X1B = H - X2B - X3B - HR)                          # adds columns
```

```
#> Source: local data frame [2,290 x 9]
#> 
#>     playerID yearID teamID   G   H X2B X3B HR X1B
#> 1  bondsba01   2001    SFN 153 156  32   2 73  49
#> 2   sosasa01   2001    CHN 160 189  34   5 64  86
#> 3  gonzalu01   2001    ARI 162 198  36   7 57  98
#> 4  rodrial01   2001    TEX 162 201  34   1 52 114
#> 5  greensh01   2001    LAN 161 184  31   4 49 100
#> 6  heltoto01   2001    COL 159 197  54   2 49  92
#> 7  thomeji01   2001    CLE 156 153  26   1 49  77
#> 8  palmera01   2001    TEX 160 164  33   0 47  84
#> 9  sexsori01   2001    MIL 158 162  24   3 45  90
#> 10 glaustr01   2001    ANA 161 147  38   2 41  66
#> ..       ...    ...    ... ... ... ... ... .. ...
```

---
## 6) Grouping with `group_by()`

Created a grouped tbl where operations are performed "by group"

Not really useful on its own, so let's combine it with...

--- 
## 7) Summarizing with `summarise()`

Summarize each group in a tbl


```r
batting_m %>%            # take the batting_m tbl_df, THEN
  group_by(yearID) %>%   # groups it by year, THEN
  summarise(sum(HR)) %>% # sums HR for each yearID, THEN
  head()                 # prints the first six years
```

```
#> Source: local data frame [6 x 2]
#> 
#>   yearID sum(HR)
#> 1   2001    3988
#> 2   2002    3616
#> 3   2003    3855
#> 4   2004    4073
#> 5   2005    3696
#> 6   2006    3950
```

---
## `dplyr` is much, much, much, faster


```r
library(microbenchmark)
microbenchmark(dplyr = batting_m %>% group_by(yearID) %>% summarise(sum(HR)), 
               plyr = ddply(batting_m, .(yearID), summarise, sum(HR)), 
               agg = aggregate(batting_m$HR, list(year = batting_m$yearID), sum), 
               tapp = tapply(batting_m$HR, list(batting_m$yearID), sum), 
               times = 500L)
```

```
#> Unit: milliseconds
#>   expr  min   lq mean median   uq   max neval  cld
#>  dplyr  3.3  3.9  4.8    4.8  5.4  18.2   500  b  
#>   plyr 44.3 51.2 56.0   54.2 57.7 223.2   500    d
#>    agg 24.3 31.6 34.4   34.4 36.9  63.9   500   c 
#>   tapp  1.4  1.6  2.2    2.4  2.5   7.3   500 a
```

---
## `dplyr` is even faster than `tapply` when there are many groups


```r
microbenchmark(dplyr = batting_m %>% group_by(yearID, playerID) %>% summarise(sum(HR)),
               tapp = tapply(batting_m$HR, list(batting_m$yearID, batting_m$playerID), sum), 
               times = 500L)
```

```
#> Unit: milliseconds
#>   expr min lq mean median uq max neval cld
#>  dplyr  13 17   20     18 20 849   500  a 
#>   tapp  31 41   45     44 47  73   500   b
```


---
## So who hit the most home runs for one team since 1920?


```r
result <- Batting %>% 
  tbl_df() %>% 
  filter(yearID >= 1920) %>% 
  group_by(playerID, teamID) %>% 
  summarise(HR = sum(HR), 
            years = paste(min(yearID), max(yearID), sep = ":")) %>% 
  ungroup() %>% 
  arrange(desc(HR))
head(result)
```

```
#> Source: local data frame [6 x 4]
#> 
#>    playerID teamID  HR     years
#> 1  ruthba01    NYA 659 1920:1934
#> 2 bondsba01    SFN 586 1993:2007
#> 3 schmimi01    PHI 548 1972:1989
#> 4  sosasa01    CHN 545 1992:2004
#> 5 mantlmi01    NYA 536 1951:1968
#> 6 willite01    BOS 521 1939:1960
```
<!--
---
## Joining with the `join()` verbs

`dplyr` implements SQL style joins with `inner_join()`, `left_join()`, `semi_join()`, and `anti_join()`


```r
inner_join(batting_m, Master)
```

```
#> Source: local data frame [2,290 x 34]
#> 
#>     playerID yearID teamID   G   H X2B X3B HR X1B birthYear birthMonth
#> 1  bondsba01   2001    SFN 153 156  32   2 73  49      1964          7
#> 2   sosasa01   2001    CHN 160 189  34   5 64  86      1968         11
#> 3  gonzalu01   2001    ARI 162 198  36   7 57  98      1967          9
#> 4  rodrial01   2001    TEX 162 201  34   1 52 114      1975          7
#> 5  greensh01   2001    LAN 161 184  31   4 49 100      1972         11
#> 6  heltoto01   2001    COL 159 197  54   2 49  92      1973          8
#> 7  thomeji01   2001    CLE 156 153  26   1 49  77      1970          8
#> 8  palmera01   2001    TEX 160 164  33   0 47  84      1964          9
#> 9  sexsori01   2001    MIL 158 162  24   3 45  90      1974         12
#> 10 glaustr01   2001    ANA 161 147  38   2 41  66      1976          8
#> ..       ...    ...    ... ... ... ... ... .. ...       ...        ...
#> Variables not shown: birthDay (int), birthCountry (chr), birthState (chr),
#>   birthCity (chr), deathYear (int), deathMonth (int), deathDay (int),
#>   deathCountry (chr), deathState (chr), deathCity (chr), nameFirst (chr),
#>   nameLast (chr), nameGiven (chr), weight (int), height (int), bats
#>   (fctr), throws (fctr), debut (chr), finalGame (chr), retroID (chr),
#>   bbrefID (chr), deathDate (date), birthDate (date)
```
-->

---
## Other cool `dplyr` features

* `dplyr` implements SQL style joins


```r
inner_join(result, Master %>% select(playerID, nameLast)) %>% head()
```

```
#> Source: local data frame [6 x 5]
#> 
#>    playerID teamID  HR     years nameLast
#> 1  ruthba01    NYA 659 1920:1934     Ruth
#> 2 bondsba01    SFN 586 1993:2007    Bonds
#> 3 schmimi01    PHI 548 1972:1989  Schmidt
#> 4  sosasa01    CHN 545 1992:2004     Sosa
#> 5 mantlmi01    NYA 536 1951:1968   Mantle
#> 6 willite01    BOS 521 1939:1960 Williams
```

* can connect to SQL databases, run SQL code outside of R, then pull the results into R
* `dplyr` uses the same commands whether the data are stored in a database or loaded into R

---
## Other cool `dplyr` features

* other people are actively providing enhancements to `dplyr`
   * `tidyr` for reshaping data
   * `assertr` for making assertions about the data
   * `magrittr` and `pipeR` for chaining
   * `Rcpp` for speeding things up

---
## Other Resources


1. [dplyr cheatsheet](http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)
2. `dplyr`'s vignettes `browseVignettes(package = "dplyr")`
3. Introductions: 
    * [5 minute intro](http://practicalrvideos.blogspot.com/2014/08/dplyr-gamechanger-for-data-manipulation.html)
    * [Wickham's tutorial](https://www.dropbox.com/sh/i8qnluwmuieicxc/AAAgt9tIKoIm7WZKIyK25lh6a) (open the dplyr-tutorial.pdf document)
    * [Vivek Patil's thorough tutorial](http://patilv.com/dplyr/)
4. [Migrating from `plyr`](https://github.com/jimhester/plyrTodplyr)
5. [Some general thoughts on the dplyr API](http://datascience.la/dplyr-some-more-reflections/)
6. [More advanced example and plotting](http://timelyportfolio.github.io/rCharts_factor_analytics/factors_with_new_R.html)
7. [`dplyr's GitHub repo](https://github.com/hadley/dplyr)



