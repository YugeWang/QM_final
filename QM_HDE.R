install.packages("naniar") 
install.packages("VIM")

library(readr)
library(VIM)
library(naniar)
library(tidyverse)
library(faraway)

#upload files
cgss2017 <- read_csv("cgss2017.csv")
n1 <- read_csv("n1.csv")
n2 <- read_csv("n2.csv")


#use hot deck imputation
#for n1
n1_HDE<- n1 %>% replace_with_na(replace = list(c_educ = c(14,98,99), c_sc = c(98,99),
                                               p_sc = c(98,99),f_educ = c(14, 98,99),
                                               c_income = c(9999996,9999997,9999998,9999999),
                                               c_hukou= c(98.99)))
n1_imp <- hotdeck(n1_HDE, variable = c("c_educ","c_sc", "p_sc","f_educ", "c_income","c_hukou"),ord_var = "birth_year")
n1_imp <- n1_imp[c(1:9)]

#for n2
n2_HDE<- n2 %>% replace_with_na(replace = list(c_educ = c(14,98,99), c_sc = c(98,99),
                                               p_sc = c(98,99),f_educ = c(14, 98,99),
                                               c_income = c(9999996,9999997,9999998,9999999),
                                               c_hukou= c(98.99)))
n2_imp <- hotdeck(n2_HDE, variable = c("c_educ","c_sc", "p_sc","f_educ", "c_income","c_hukou"),ord_var = "birth_year")
n2_imp <- n2_imp[c(1:9)]

write.csv(n1_imp,"n1_imp.csv", row.names = FALSE)
write.csv(n2_imp,"n2_imp.csv", row.names = FALSE)

#finding vif
vif(n1_imp)
vif(n2_imp)
