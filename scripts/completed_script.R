#################################
# load data
#################################
# load tidyverse package (subsequently loads multiple packages including dplyr, tidyr, ggplot2...)
library(tidyverse)

# loads starwars dataframe from dplyr package
data(starwars)

# look at starwars dataframe in Rstudio
View(starwars)

#################################
# dplyr::filter()
#################################
# Filter the starwars dataframe to keep only humans
dplyr::filter(starwars, species == "Human")

# Filter the starwars dataframe to keep only male humans
dplyr::filter(starwars, species == "Human", gender == "male")

# Filter the starwars dataframe to keep humans and droids
dplyr::filter(starwars, species %in% c("Human", "Droid"))

# Filter the starwars dataframe to keep characters with a height less than 100
dplyr::filter(starwars, height < 100)

# Filter the starwars dataframe to keep all characters that are non-human
dplyr::filter(starwars, species != "Human")

# Filter the starwars dataframe to remove unknown species (i.e. species == NA)
dplyr::filter(starwars, !is.na(species))

#################################
# piping in tidyverse
#################################
# Filter the starwars dataframe to keep only male humans
starwars %>%
    dplyr::filter(species == "Human") %>%
    dplyr::filter(gender == "male")

#################################
# dplyr::select()
#################################
# Select only name, species, and films variables from the starwars dataframe
dplyr::select(starwars, name, species, films)

# Select all columns except the gender
dplyr::select(starwars, -gender)

# Select columns name, height, mass, hair color, and skin color
dplyr::select(starwars, name:skin_color)

# Select all columns except hair color, skin color, and eye color
dplyr::select(starwars, -hair_color, -skin_color, -eye_color)
dplyr::select(starwars, -(hair_color:eye_color))

# Select columns name, mass, skin color, hair color, and height (in order)
dplyr::select(starwars, name, mass, skin_color, hair_color, height)

# rename the "name" column to "character" and the "mass" column to "weight" using select()
dplyr::select(character = name, weight = mass)

# Keep:  height greater than 100 &
# Keep: humans &
# Remove: brown hair color &
# Remove: vehicles &
# Keep: name, homeworld, height, species, hair color

df <- starwars %>%
    dplyr::filter(height > 100) %>%
    dplyr::filter(species == "Human") %>%
    dplyr::filter(hair_color != "brown") %>%
    dplyr::select(-vehicles) %>%
    dplyr::select(name, homeworld, height, species, hair_color)

#################################
# dplyr::rename()
#################################

# Rename the "name" column to "character" 
renamed <- starwars %>%
    dplyr::rename(character = name)

# Rename the "name" column to "character" and the "mass" column to "weight"
renamed2 <- starwars %>%
    dplyr::rename(character = name, weight = mass)

#################################
# dplyr::mutate()
#################################

# check out the starwars dataframe help page to see what the units are for mass and height
?starwars

# Calculate the BMI of all starwars characters
# Step 1: convert height in cm to height in m (save as new dataframe)
new_starwars <- dplyr::mutate(starwars, height_m = height / 100)

# Step 2: calculate BMI with formula: BMI = weight (kg) / [height (m)]^2
new_starwars <- starwars %>%
    dplyr::mutate(height_m = height / 100) %>%
    dplyr::mutate(bmi = mass / height_m^2)

# select only name, height, mass, height_m, and bmi and view dataframe
new_starwars <- new_starwars %>%
    dplyr::select(name, height, mass, height_m, bmi)
View(new_starwars)

# re-calculate the bmi by changing the height column to meters instead of creating a new column
new_starwars <- starwars %>%
    dplyr::mutate(height = height / 100) %>%
    dplyr::mutate(bmi = mass / height^2) %>%
    dplyr::select(name, height, mass, bmi)

# Make a new column to find the average height (in meters)
test <- starwars %>%
    dplyr::mutate(avg_height = mean(height)/100) %>%
    dplyr::select(name, height, mass, avg_height)

# check the help page for mean
?mean

# use na.rm = TRUE in the mean() function
test <- starwars %>%
    dplyr::mutate(avg_height = mean(height, na.rm = TRUE)/100) %>%
    dplyr::select(name, height, mass, avg_height)

# Standardize the heights of the starwars characters (height / avg_height)
test <- starwars %>%
    dplyr::mutate(height = height / 100) %>%
    dplyr::mutate(avg_height = mean(height, na.rm = TRUE)) %>%
    dplyr::mutate(std_height = height / avg_height) %>%
    dplyr::select(name, height, mass, avg_height, std_height)

# Make a new column to see if each character is above or below the average height
test <- starwars %>%
    dplyr::mutate(height = height / 100) %>%
    dplyr::mutate(avg_height = mean(height, na.rm = TRUE)) %>%
    dplyr::mutate(std_height = height / avg_height) %>%
    dplyr::select(name, height, mass, avg_height, std_height) %>%
    dplyr::mutate(relative_height = ifelse(std_height > 1, "above", "below"))

# Add on to previous code to filter to keep only characters with heights below average
test <- starwars %>%
    dplyr::mutate(height = height / 100) %>%
    dplyr::mutate(avg_height = mean(height, na.rm = TRUE)) %>%
    dplyr::mutate(std_height = height / avg_height) %>%
    dplyr::select(name, height, mass, avg_height, std_height) %>%
    dplyr::mutate(relative_height = ifelse(std_height > 1, "above", "below")) %>%
    dplyr::filter(relative_height == "below")

# OR dplyr::filter(std_height < 1)
# OR dplyr::filter(height > avg_height)

#################################
# dplyr::group_by()
#################################
# Group starwars dataframe by gender
grouped_starwars <- starwars %>%
    dplyr::group_by(gender)

# Calculate average height PER GENDER (hint: group by gender FIRST)
grouped_starwars <- starwars %>%
    dplyr::mutate(height = height / 100) %>%
    dplyr::group_by(gender) %>%
    dplyr::mutate(avg_height = mean(height, na.rm = TRUE)) %>%
    dplyr::select(name, gender, height, avg_height)

# Ungroup your grouped dataframe and re-calculate average height
ungrouped_starwars <- grouped_starwars %>%
    dplyr::ungroup() %>%
    dplyr::mutate(avg_height = mean(height, na.rm = TRUE))

# Calculate the average height per gender AND eye color
grouped_starwars <- starwars %>%
    dplyr::group_by(gender, eye_color) %>%
    dplyr::mutate(avg_height = mean(height, na.rm = TRUE)) %>%
    dplyr::select(name, gender, eye_color, height, avg_height)


#################################
# dplyr::summarize()
# dplyr::summarise()
#################################

summarized <- starwars %>%
    dplyr::group_by(gender) %>%
    dplyr::summarize(avg_height = mean(height, na.rm = TRUE))

# look at the difference between summarize() and mutate() to calculate average height by gender
mutated <- starwars %>%
    dplyr::group_by(gender) %>%
    dplyr::mutate(avg_height = mean(height, na.rm = TRUE))

#################################
# dplyr::arrange()
#################################

# Arrange the starwars dataframe by homeworld
arranged_df <- dplyr::arrange(starwars, homeworld)

# Arrange the starwars dataframe by homeworld in descending order
# hint: use desc()
arranged_df <- dplyr::arrange(starwars, desc(homeworld))

# Arrange starwars by species then height
arranged_df <- dplyr::arrange(starwars, species, height)

#################################
# dplyr::xxx_join()
#################################

# read in example csv files (join_df1 and join_df2)
join_df1 <- read.csv("~/Downloads/data/join_df1.csv")
join_df2 <- read.csv("~/Downloads/data/join_df2.csv")

# left join df1 and df2
left <- dplyr::left_join(join_df1, join_df2)

# right join df1 and df2
right <- dplyr::right_join(join_df1, join_df2)

# full join df1 and df2
full <- dplyr::full_join(join_df1, join_df2)

# full join df1 and df2 specifying which column is the same
full <- dplyr::full_join(join_df1, join_df2, by = "A")

# Create df1 by selecting name, height and mass
# Create df2 by selecting name, eye_color, hair_color, and gender and arrange by name
# Join df1 and df2 so as to not lose any rows
df1 <- starwars %>%
    dplyr::select(name, height, mass)

df2 <- starwars %>%
    dplyr::select(name, eye_color, hair_color, gender) %>%
    dplyr::arrange(name)

joined_df <- dplyr::full_join(df1, df2, by = "name")

# Create df3 by selecting name and gender
# Create df4 as a table counting number of males and females in starwars data
# Join df3 and df4 by left and right join, compare.
df3 <- starwars %>%
    dplyr::select(name, gender)

df4 <- starwars %>%
    dplyr::filter(gender %in% c("male", "female"))%>%
    dplyr::group_by(gender) %>%
    dplyr::summarize(number = n())

left_df <- dplyr::left_join(df3, df4, by = "gender")
right_df <- dplyr::right_join(df3, df4, by = "gender")

#################################
# dplyr::bind_rows()
# dplyr::bind_cols()
#################################

### bind_rows()
# read in bind_df3.csv
bind_df3 <- read.csv("~/Downloads/data/bind_df3.csv")

# bind rows with join_df1
bound <- dplyr::bind_rows(join_df1, bind_df3)

# Create "females" dataframe by selecting name, gender (only females), species
# Create "males" dataframe by selecting name, gender (only males), species
# Combine male and female dataframes using dplyr::bind_rows()
females <- starwars %>%
    dplyr::select(name, gender, species) %>%
    dplyr::filter(gender == "female")

males <- starwars %>%
    dplyr::select(name, gender, species) %>%
    dplyr::filter(gender == "male")

bound <- females %>%
    dplyr::bind_rows(males)

# or bound <- dplyr::bind_rows(females, males)

### bind_cols()
# Make "d" vector
d <- c(3, 5, 7, 1, 3, 6, NA, NA)

# bind d as a column to join_df1
dplyr::bind_cols(join_df1, D = d)

# Create df1 by selecting name, height and mass
# Create df2 by selecting name, eye_color, hair_color, and gender and arrange by name
# Combine df1 and df2 using dplyr::bind_cols()
bound2 <- dplyr::bind_cols(df1, df2)

# compare with joined_df
joined_df <- dplyr::full_join(df1, df2, by = "name")


#################################
# Extra practice
#################################

# practice 1
# calculate the birth year of all characters (who have an age) given the "birth_year" column is actually AGE in 2019
# Hint: rename "birth_year" as "age" then calculate birth year
practice1 <- starwars %>%
    dplyr::select(name, age = birth_year) %>%
    dplyr::mutate(birth_year = 2019 - age) %>%
    dplyr::filter(!is.na(age))

# practice 2
# calculate the number of characters with each hair color combination
# Note: "blonde, brown" is different than "blonde" and "brown"
# hint: the function n() counts the number of observations in a group.
# BONUS: Combine 'blond' and 'blonde' as one category and re-calculate
practice2 <- starwars %>%
    dplyr::select(name, hair_color) %>%
    dplyr::group_by(hair_color) %>%
    dplyr::summarize(number = n())

# BONUS:
practice2 <- starwars %>%
    dplyr::mutate(hair_color = ifelse(hair_color == "blond", "blonde", hair_color)) %>%
    dplyr::select(name, hair_color) %>%
    dplyr::group_by(hair_color) %>%
    dplyr::summarize(number = n())

# practice 3
# calculate the number of characters with each hair color combination, keep ALL characters
# Note: "blonde, brown" is different than "blonde" and "brown"
# hint: the function n() counts the number of observations in a group.
practice3 <- starwars %>%
    dplyr::select(name, hair_color) %>%
    dplyr::group_by(hair_color) %>%
    dplyr::mutate(number = n())

# practice 4
# select all characters and their homeworlds in Return of the Jedi
# try using 'grepl()' 
practice4 <- starwars %>%
    dplyr::filter(grepl("Return of the Jedi", films)) %>%
    dplyr::select(name, homeworld)


####################################################################################
####################################################################################
# Day 2
####################################################################################
####################################################################################


#################################
# tidyr::gather()
#################################

# Convert the starwars dataframe from wide to long, containing three columns: name, characteristic, value
gathered <- starwars %>%
  tidyr::gather(characteristic, value, height:starships)

# gather as above but deselect the name column instead of selecting the others
gathered <- starwars %>%
  tidyr::gather(characteristic, value, -name)

# Gather height, mass, eye color, skin color, and gender
gathered <- starwars %>%
  tidyr::gather(characteristic, value, height, mass, eye_color, skin_color, gender)

#################################
# tidyr::spread()
#################################

# Un-gather (spread) the starwars dataframe
ungathered <- gathered %>%
  tidyr::spread(characteristic, value)

# OYO:
# GOAL: each name is a column with one row (eye color)
# Step 1: select columns to keep (name, eye_color)
# Step 2: spread the data frame
eyes <- starwars %>%
    dplyr::select(name, eye_color) %>%
    tidyr::spread(name, eye_color)

# What if you didn't select only name and eye color first?
eyes <- starwars %>%
    tidyr::spread(name, eye_color)

# Spread the starwars dataframe by name, eye color and fill all missing values with '0'
eyes <- starwars %>%
    tidyr::spread(name, eye_color, fill = 0)

#################################
# tidyr::unite()
#################################

# combine name and homeworld into one column named character (e.g. Luke Skywalker, Tatooine)
united <- starwars %>%
    tidyr::unite(name, homeworld, col = "character", sep = ", ")

# Combine name, homeworld, and species into one column named character (e.g. Luke Skywalker, Tatooine, Human)
united <- starwars %>%
    tidyr::unite(name, homeworld, species, col = "character", sep = ", ")

# Combine name, homeworld, and species into one column named character but keep name and homeworld columns also
# hint: remove = FALSE
united <- starwars %>%
    tidyr::unite(name, homeworld, col = "character", sep = ", ", remove = FALSE)

# !!Advanced!!: Combine name, homeworld, and species into one column named character (e.g. Luke Skywalker, Tatooine (Human))
# Hint: this might take multiple steps...
# Hint: paste("My name is", "Katie", sep = " ") => "My name is Katie"
united <- starwars %>%
    tidyr::unite(name, homeworld, col = "character", sep = ", ") %>%
    dplyr::mutate(species = paste("(", species, ")", sep = "")) %>%
    tidyr::unite(character, species, col = "character", sep = " ")

#################################
# tidyr::separate()
#################################

# Separate the 'character' column back into name and homeworld 
separated <- united %>%
    tidyr::separate(character, into = c("name", "homeworld"), sep = ",")

# Separate the 'character' column back into name and homeworld but keep character also
separated <- united %>%
    tidyr::separate(character, into = c("name", "homeworld"), sep = ",", remove = FALSE)

# Separate characters into first and last names
names <- starwars %>%
    tidyr::separate(name, into = c("first_name", "last_name"), sep = " ")

#################################
# tidyr::separate_rows()
#################################

# Separate the "hair_color" column to be separate observations (rows) e.g. brown, grey
hair_cleaned <- starwars %>%
    tidyr::separate_rows(hair_color, sep = ", ")

# split the films column so that each film is represented in its own row per character
separated <- starwars %>% 
  tidyr::separate_rows(films, sep = ", ")

#################################
# tidyr::drop_na()
#################################

# Remove all observations with no species
no_species <- starwars %>%
    tidyr::drop_na(species)

# Remove all rows with any NA value
no_na <- starwars %>%
    na.omit()

#################################
# readr::write_csv()
#################################

# Save the starwars data frame as a .csv file
starwars %>%
  dplyr::select(name:species) %>%
  readr::write_csv("starwars.csv")

# Save the starwars data frame as a .csv file without column names
starwars %>%
  dplyr::select(name:species) %>%
  readr::write_csv("starwars.csv", col_names = F)

#################################
# readr::read_csv()
#################################

# Read the starwars .csv file you just saved
# hint: where is your working directory?
new_starwars <- readr::read_csv("starwars.csv")

# Read the starwars .csv file but specify the name column as a character and height as an integer
new_starwars <- readr::read_csv("starwars.csv", 
                                 col_types = cols(
                                   name = col_character(),
                                   height = col_integer()
                                 )
)

new_starwars <- readr::read_csv("starwars.csv", 
                                col_types = "ci????????"
)

#################################
# stringr
#################################

# which rows have hair colors that mention brown?
stringr::str_detect(hair_color, "brown")

# Keep all hair colors that mention brown
brown_hair <- starwars %>%
  dplyr::filter(stringr::str_detect(hair_color, "brown"))

# Make a new column counting how many a's are in each character’s name
count_a <- starwars %>%
    dplyr::mutate(vowels = stringr::str_count(name, "a"))

# Make a new column counting how many vowels are in each character’s name
# Hint: "this|that" reads "this OR that"
vowels <- starwars %>%
  dplyr::mutate(vowels = stringr::str_count(name, "a|e|i|o|u"))

# Make a new column counting how many vowels are in each character’s name
# Hint: "this|that" reads "this OR that"
# Make sure you get both UPPER and lower case vowels
vowels <- starwars %>%
    dplyr::mutate(vowels = stringr::str_count(name, "a|e|i|o|u|A|E|I|O|U"))

# Make a new column counting how many vowels are in each character’s name
# hint: change all names to lower case first
vowels2 <- starwars %>%
  dplyr::mutate(name = stringr::str_to_lower(name)) %>%
  dplyr::mutate(vowels = stringr::str_count(name, "a|e|i|o|u"))

# Replace all mentions of "Human" with "Homo sapien"
species <- starwars %>%
  dplyr::mutate(species = stringr::str_replace(species, "Human", "Homo sapiens"))

# Give each starwars character a PhD
# hint: add “, PhD” to the end of the name column
doctorates <- starwars %>% 
  dplyr::mutate(name = stringr::str_c(name, ", PhD"))

# compare to paste()
doctorates2 <- starwars %>% 
    dplyr::mutate(name = paste(name, ", PhD", sep = ""))

# split "name" into "first name" and "last name"
# hint: try str_split_fixed("Luke Skywalker", " ", 2) first to see output
stringr::str_split_fixed("Luke Skywalker", " ", 2)

names <- starwars %>%
  dplyr::mutate(first_name = stringr::str_split_fixed(name, " ", 2)[,1],
                last_name = stringr::str_split_fixed(name, " ", 2)[,2])

# Compare to tidyr::separate()
names2 <- starwars %>%
    tidyr::separate(name, into = c("first_name", "last_name", sep = " "))


# Add a new column that counts the number of letters in each name
counts <- starwars %>%
  dplyr::mutate(name_counts = stringr::str_length(name))

# Remove whitespace surrounding “ test “
stringr::str_trim(" test ")

#################################
# lubridate
#################################

# parsing date and times
# “1 Jan 2014”
lubridate::dmy("1 Jan 2014")

# “2018-03-15”
lubridate::ymd("2018-03-15")

# “1999/12/01T14”
lubridate::ymd_h("1999/12/01T14")

# “December 24th, 1960”
lubridate::mdy("December 24th, 1960")

# “20180405 02:45:51”
lubridate::ymd_hms("20180405 02:45:51")

# “1741, 5th August”
lubridate::ydm("1741, 5th August")

# “7 1993 feb”
lubridate::dym("7 1993 feb")

# “2030/04/16 20:30”
lubridate::ymd_hm("2030/04/16 20:30")

# “Nov. 2001 5th”
lubridate::mdy("Nov. 2001 5th")

# get and set times
t <- lubridate::ymd_hms("2019-07-30 11:01:59")

# date
lubridate::date(t)

# year
lubridate::year(t)

# month
lubridate::month(t)

# day
lubridate::day(t)

# weekday
lubridate::wday(t)

# hour
lubridate::hour(t)

# minute
lubridate::minute(t)

# second
lubridate::second(t)

# week
lubridate::week(t)

# am or pm?
lubridate::am(t)

# daylight saving time?
lubridate::dst(t)

# leap year?
lubridate::leap_year(t)

# Math with date-times

# How much time until Christmas??
lubridate::ymd_hms("2019-12-25 00:00:01")-lubridate::now()

# What day will it be in 30 days?
lubridate::now() + lubridate::days(30)

# What time is it in London?
lubridate::with_tz(now(), tzone = "GMT")

# PERIODS, DURATIONS, INTERVALS

# Add 2 hours to “2019-07-29 11:01:59”
lubridate::ymd_hms("2019-07-29 11:01:59") + lubridate::hours(2)

# Find the number of seconds in 30 days
lubridate::ddays(30)


#################################
# Extra practice
#################################

# practice 5
# Split the films column so that each film is represented in its own row per character
# Keep only name and film
# Then use stringr to clean up the films column
# Hint: \\ is used to escape special characters like ( or "
## Example: cannot use "(" to detect a (, but use "\\("
# Hint: you can combine multiple patterns using "pattern1|pattern2"
practice5 <- starwars %>%
    dplyr::select(name, films) %>%
    tidyr::separate_rows(films, sep = ",") %>%
    dplyr::mutate(films = stringr::str_replace_all(string = films, 
                                                   pattern = 'c\\(|\\)|\\"', 
                                                   replacement = ""))

# practice 6
# combine hair, skin, and eye_color as one "color" column. Separate by "&"
# first remove anyone with any NA in these columns
practice6 <- starwars %>%
    dplyr::select(name, hair_color, eye_color, skin_color) %>%
    dplyr::filter(!is.na(hair_color),
                  !is.na(eye_color),
                  !is.na(skin_color)) %>%
    tidyr::unite(hair_color, eye_color, skin_color, col = "color (hair & eye & skin)", sep = " & ")

# practice 7 - see example dataframe
practice7 <- starwars %>%
    dplyr::select(name:species) %>%
    dplyr::filter(species == "Human",
                  gender == "female") %>%
    tidyr::gather(variable, value, -name) %>%
    tidyr::spread(name, value)
