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


# rename the "name" column to "character" and the "mass" column to "weight" using select()


# Keep:  height greater than 100 &
# Keep: humans &
# Remove: brown hair color &
# Remove: vehicles &
# Keep: name, homeworld, height, species, hair color






#################################
# dplyr::rename()
#################################

# Rename the "name" column to "character" 



# Rename the "name" column to "character" and the "mass" column to "weight"



#################################
# dplyr::mutate()
#################################

# check out the starwars dataframe help page to see what the units are for mass and height


# Calculate the BMI of all starwars characters
# Step 1: convert height in cm to height in m (save as new dataframe)


# Step 2: calculate BMI with formula: BMI = weight (kg) / [height (m)]^2




# select only name, height, mass, height_m, and bmi and view dataframe




# re-calculate the bmi by changing the height column to meters instead of creating a new column




# Make a new column to find the average height (in meters)



# check the help page for mean


# use na.rm = TRUE in the mean() function




# Standardize the heights of the starwars characters (height / avg_height)





# Make a new column to see if each character is above or below the average height





# Add on to previous code to filter to keep only characters with heights below average








#################################
# dplyr::group_by()
#################################
# Group starwars dataframe by gender



# Calculate average height PER GENDER (hint: group by gender FIRST)





# Ungroup your grouped dataframe and re-calculate average height




# Calculate the average height per gender AND eye color





#################################
# dplyr::summarize()
# dplyr::summarise()
#################################

# Summarize height by gender



# look at the difference between summarize() and mutate() to calculate average height by gender




#################################
# dplyr::arrange()
#################################

# Arrange the starwars dataframe by homeworld


# Arrange the starwars dataframe by homeworld in descending order
# hint: use desc()


# Arrange starwars by species then height


#################################
# dplyr::xxx_join()
#################################

# read in example csv files (join_df1 and join_df2)



# left join df1 and df2


# right join df1 and df2


# full join df1 and df2


# full join df1 and df2 specifying which column is the same


# Create df1 by selecting name, height and mass
# Create df2 by selecting name, eye_color, hair_color, and gender and arrange by name
# Join df1 and df2 so as to not lose any rows









# Create df3 by selecting name and gender
# Create df4 as a table counting number of males and females in starwars data
# Join df3 and df4 by left and right join, compare.











#################################
# dplyr::bind_rows()
# dplyr::bind_cols()
#################################

### bind_rows()
# read in bind_df3.csv


# bind rows with join_df1


# Create "females" dataframe by selecting name, gender (only females), species
# Create "males" dataframe by selecting name, gender (only males), species
# Combine male and female dataframes using dplyr::bind_rows()










### bind_cols()
# Make "d" vector


# bind d as a column to join_df1


# Create df1 by selecting name, height and mass
# Create df2 by selecting name, eye_color, hair_color, and gender and arrange by name
# Combine df1 and df2 using dplyr::bind_cols()


# compare with joined_df



#################################
# Extra practice
#################################

# practice 1
# calculate the birth year of all characters (who have an age) given the "birth_year" column is actually AGE in 2019
# Hint: rename "birth_year" as "age" then calculate birth year





# practice 2
# calculate the number of characters with each hair color combination
# Note: "blonde, brown" is different than "blonde" and "brown"
# hint: the function n() counts the number of observations in a group.
# BONUS: Combine 'blond' and 'blonde' as one category and re-calculate






# BONUS:






# practice 3
# calculate the number of characters with each hair color combination, keep ALL characters
# Note: "blonde, brown" is different than "blonde" and "brown"
# hint: the function n() counts the number of observations in a group.






# practice 4
# select all characters and their homeworlds in Return of the Jedi
# try using 'grepl()' 






####################################################################################
####################################################################################
# Day 2
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
# tidyr::separate_rows()
#################################

# Separate the "hair_color" column to be separate observations (rows) e.g. brown, grey




# split the films column so that each film is represented in its own row per character




#################################
# tidyr::drop_na()
#################################

# Remove all observations with no species




# Remove all rows with any NA value




#################################
# readr::write_csv()
#################################

# Save the starwars data frame as a .csv file




# Save the starwars data frame as a .csv file without column names




#################################
# readr::read_csv()
#################################

# Read the starwars .csv file you just saved
# hint: where is your working directory?


# Read the starwars .csv file but specify the name column as a character and height as an integer








#################################
# stringr
#################################

# which rows have hair colors that mention brown?


# Keep all hair colors that mention brown




# Make a new column counting how many a's are in each character’s name



# Make a new column counting how many vowels are in each character’s name
# Hint: "this|that" reads "this OR that"



# Make a new column counting how many vowels are in each character’s name
# Hint: "this|that" reads "this OR that"
# Make sure you get both UPPER and lower case vowels



# Make a new column counting how many vowels are in each character’s name
# hint: change all names to lower case first




# Replace all mentions of "Human" with "Homo sapien"



# Give each starwars character a PhD
# hint: add “, PhD” to the end of the name column



# compare to paste()



# split "name" into "first name" and "last name"
# hint: try str_split_fixed("Luke Skywalker", " ", 2) first to see output







# Compare to tidyr::separate()




# Add a new column that counts the number of letters in each name



# Remove whitespace surrounding “ test “


#################################
# lubridate
#################################

# parsing date and times
# “1 Jan 2014”


# “2018-03-15”


# “1999/12/01T14”


# “December 24th, 1960”


# “20180405 02:45:51”


# “1741, 5th August”


# “7 1993 feb”


# “2030/04/16 20:30”


# “Nov. 2001 5th”


# get and set times


# date


# year


# month


# day


# weekday


# hour


# minute


# second


# week


# am or pm?


# daylight saving time?


# leap year?


# Math with date-times

# How much time until Christmas??


# What day will it be in 30 days?


# What time is it in London?


# PERIODS, DURATIONS, INTERVALS

# Add 2 hours to “2019-07-29 11:01:59”


# Find the number of seconds in 30 days



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






# practice 6
# combine hair, skin, and eye_color as one "color" column. Separate by "&"
# first remove anyone with any NA in these columns






# practice 7 - see example dataframe






