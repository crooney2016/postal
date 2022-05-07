var_df <- read.csv("C:\Users\crooney\OneDrive - Century LLC\Desktop\PostalZones\postal\data\postalzones.csv", header = F) # nolint
for (i in 1:dim(var_df)[1]) {
   this_var_a <- var_df[i,1]
   this_var_b <- var_df[i,2]
   source(fetch_zones_five_digit(), local = T)

}
