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
