testthat::test_that('testing the Prepare_data function',{
  X <- data.frame("ID" = 1:4, "Sex" = c("Male", "Male", "Female", "Female" ), "Name" = c("John","Samer", "Sara", "Carolina"), Smoking = c("Yes","No", "No","Yes"))
  expect_equivalent(purrr::map(Prepare_data(X), length), purrr::map(X, length) )
})
