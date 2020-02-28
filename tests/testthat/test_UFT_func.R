testthat::test_that('Testing that UFT_func is',{
  X <- data.frame("ID" = as.numeric(c(1,2,3,4)), "Age" = c(21,15,44,14), "Sex" = c("Male", "Male", "Female", "Female" ), "Name" = c("John","Samer", "Sara", "Carolina"), Smoking = c("Yes","No", "No","Yes"))
  uft_x <- UFT_func(Data = X,Seed = 11)
  expect_equal(dim(uft_x), c(4,3))
  expect_equal(colnames(uft_x), c('Sex', 'Name', 'Smoking'))
})
