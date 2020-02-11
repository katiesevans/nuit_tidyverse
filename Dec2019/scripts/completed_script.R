####################################################################################
####################################################################################
# Part 1
####################################################################################
####################################################################################


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

# Rename the "name" column to "character" and the "mass" column to "weight" using select()
renamed <- starwars %>%
    dplyr::select(character = name, weight = mass)

# Rename the "name" column to "character" and the "mass" column to "weight" using rename()
renamed <- starwars %>%
    dplyr::rename(character = name, weight = mass)

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

# select only name, height, mass, height_m, and bmi 
new_starwars <- new_starwars %>%
    dplyr::select(name, height, mass, height_m, bmi)

# and view new dataframe
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



####################################################################################
####################################################################################
# Part 2
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
# Extra practice
#################################

# practice 1
# select all characters and their homeworlds in Return of the Jedi
# try using 'grepl()' or 'stringr::str_detect()'
practice1 <- starwars %>%
    dplyr::filter(grepl("Return of the Jedi", films)) %>%
    # dplyr::filter(stringr::str_detect(films, "Return of the Jedi")) %>%
    dplyr::select(name, homeworld)

# practice 2
# calculate the birth year of all characters (who have an age) given the "birth_year" column is actually AGE in 2019
# Hint: rename "birth_year" as "age" then calculate birth year
practice2 <- starwars %>%
    dplyr::select(name, age = birth_year) %>%
    dplyr::mutate(birth_year = 2019 - age) %>%
    dplyr::filter(!is.na(age))

# practice 3
# calculate the number of characters with each hair color combination
# Note: "blonde, brown" is different than "blonde" and "brown"
# hint: the function n() counts the number of observations in a group.
practice3 <- starwars %>%
    dplyr::select(name, hair_color) %>%
    dplyr::group_by(hair_color) %>%
    dplyr::mutate(number = n())

# practice 4
# combine hair, skin, and eye_color as one "color" column. Separate by "&"
# first remove anyone with any NA in these columns
practice4 <- starwars %>%
    dplyr::select(name, hair_color, eye_color, skin_color) %>%
    dplyr::filter(!is.na(hair_color),
                  !is.na(eye_color),
                  !is.na(skin_color)) %>%
    tidyr::unite(hair_color, eye_color, skin_color, col = "color (hair & eye & skin)", sep = " & ")

# practice 5 - see example dataframe
practice5 <- starwars %>%
    dplyr::select(name:species) %>%
    dplyr::filter(species == "Human",
                  gender == "female") %>%
    tidyr::gather(variable, value, -name) %>%
    tidyr::spread(name, value)

