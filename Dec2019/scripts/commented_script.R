####################################################################################
####################################################################################
# Part 1
####################################################################################
####################################################################################


#################################
# load data
#################################
# load tidyverse package (subsequently loads multiple packages including dplyr, tidyr, ggplot2...)


# loads starwars dataframe from dplyr package


# look at starwars dataframe in Rstudio


#################################
# dplyr::filter()
#################################
# Filter the starwars dataframe to keep only humans


# Filter the starwars dataframe to keep only male humans


# Filter the starwars dataframe to keep humans and droids


# Filter the starwars dataframe to keep characters with a height less than 100


# Filter the starwars dataframe to keep all characters that are non-human


# Filter the starwars dataframe to remove unknown species (i.e. species == NA)


#################################
# piping in tidyverse
#################################
# Filter the starwars dataframe to keep only male humans



#################################
# dplyr::select()
#################################
# Select only name, species, and films variables from the starwars dataframe


# Select all columns except the gender


# Select columns name, height, mass, hair color, and skin color


# Select all columns except hair color, skin color, and eye color



# Select columns name, mass, skin color, hair color, and height (in order)


# Rename the "name" column to "character" and the "mass" column to "weight" using select()



# Rename the "name" column to "character" and the "mass" column to "weight" using rename()



# Keep:  height greater than 100 &
# Keep: humans &
# Remove: brown hair color &
# Remove: vehicles &
# Keep: name, homeworld, height, species, hair color







#################################
# dplyr::mutate()
#################################

# check out the starwars dataframe help page to see what the units are for mass and height


# Calculate the BMI of all starwars characters
# Step 1: convert height in cm to height in m (save as new dataframe)


# Step 2: calculate BMI with formula: BMI = weight (kg) / [height (m)]^2




# select only name, height, mass, height_m, and bmi 




# and view new dataframe


# re-calculate the bmi by changing the height column to meters instead of creating a new column





# Make a new column to find the average height (in meters)




# check the help page for mean


# use na.rm = TRUE in the mean() function




# Standardize the heights of the starwars characters (height / avg_height)






# Make a new column to see if each character is above or below the average height








# Add on to previous code to filter to keep only characters with heights below average










# OR dplyr::filter(std_height < 1)
# OR dplyr::filter(height > avg_height)

#################################
# dplyr::group_by()
#################################
# Group starwars dataframe by gender




# Calculate average height PER GENDER (hint: group by gender FIRST)






# Ungroup your grouped dataframe and re-calculate average height
ungrouped_starwars <- grouped_starwars %>%
    dplyr::ungroup() %>%
    dplyr::mutate(avg_height = mean(height, na.rm = TRUE))

# Calculate the average height per gender AND eye color







####################################################################################
####################################################################################
# Part 2
####################################################################################
####################################################################################


#################################
# tidyr::gather()
#################################

# Convert the starwars dataframe from wide to long, containing three columns: name, characteristic, value




# gather as above but deselect the name column instead of selecting the others




# Gather height, mass, eye color, skin color, and gender



#################################
# tidyr::spread()
#################################

# Un-gather (spread) the starwars dataframe



# OYO:
# GOAL: each name is a column with one row (eye color)
# Step 1: select columns to keep (name, eye_color)
# Step 2: spread the data frame



# What if you didn't select only name and eye color first?



# Spread the starwars dataframe by name, eye color and fill all missing values with '0'



#################################
# tidyr::unite()
#################################

# combine name and homeworld into one column named character (e.g. Luke Skywalker, Tatooine)



# Combine name, homeworld, and species into one column named character (e.g. Luke Skywalker, Tatooine, Human)



# Combine name, homeworld, and species into one column named character but keep name and homeworld columns also
# hint: remove = FALSE



# !!Advanced!!: Combine name, homeworld, and species into one column named character (e.g. Luke Skywalker, Tatooine (Human))
# Hint: this might take multiple steps...
# Hint: paste("My name is", "Katie", sep = " ") => "My name is Katie"





#################################
# tidyr::separate()
#################################

# Separate the 'character' column back into name and homeworld 



# Separate the 'character' column back into name and homeworld but keep character also



# Separate characters into first and last names



#################################
# Extra practice
#################################

# practice 1
# select all characters and their homeworlds in Return of the Jedi
# try using 'grepl()' or 'stringr::str_detect()'





# practice 2
# calculate the birth year of all characters (who have an age) given the "birth_year" column is actually AGE in 2019
# Hint: rename "birth_year" as "age" then calculate birth year





# practice 3
# calculate the number of characters with each hair color combination
# Note: "blonde, brown" is different than "blonde" and "brown"
# hint: the function n() counts the number of observations in a group.





# practice 4
# combine hair, skin, and eye_color as one "color" column. Separate by "&"
# first remove anyone with any NA in these columns






# practice 5 - see example dataframe







