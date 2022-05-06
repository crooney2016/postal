var_df <- read.csv([file = 'data/postalzones.csv', header = FALSE])
# or read table with correct specs
for (i in 1:dim(var_df)[1]) { # vectorise for speed; doing it with loops to 
# make this clearer
   this_var_a <- var_df[i,1]
   this_var_b <- var_df[i,2]
   source([fetch_zones_five_digit()], local=T) #set local=T as otherwise the vars
# will not be visible to the script's operations

}