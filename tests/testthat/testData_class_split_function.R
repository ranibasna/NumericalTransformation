test_that("testing the split function", {
  X <- data.frame("ID" = as.numeric(c(1,2,3,4)), "Age" = c(21,15,44,14), "Sex" = c("Male", "Male", "Female", "Female" ), "Name" = c("John","Samer", "Sara", "Carolina"), Smoking = c("Yes","No", "No","Yes"))
  data_split_test <- Data_Classes_Split(X)
  expect_equivalent(class(data_split_test), "list")
})
