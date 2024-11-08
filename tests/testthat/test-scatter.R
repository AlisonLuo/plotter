library(palmerpenguins)
library(dplyr)
test_that("Basic testing and NA value handling", {
  # Test 1: Standard use case with no NAs
  expect_silent(scatter(penguins, bill_length_mm, bill_depth_mm))

  # Test 2: Handling of some NA values
  penguins_with_na <- penguins
  penguins_with_na$bill_length_mm[1] <- NA  # Introduce an NA value
  expect_no_error(scatter(penguins_with_na, bill_length_mm, bill_depth_mm))

  # Test 3: Handling of NA values in every row
  penguins_na_col <- penguins %>%
    mutate(na_column = NA) # add a column with only NA values
  expect_error(scatter(penguins_na_col, bill_length_mm, bill_depth_mm),
               "The selected columns contain no valid data after removing NA values.")

  # Test 4: Check for non-numeric inputs
  df <- data.frame(a = c("a", "b", "c"), b = c(1, 2, 3))
  expect_error(scatter(df, a, b),
               'Sorry, but this function only works for numeric data!')
  expect_error(scatter(penguins, bill_length_mm, island),
               'Sorry, but this function only works for numeric data!')
})

# Test 5: Testing missing arguments
test_that("Function throws errors for missing arguments", {
  expect_error(scatter(), "The 'data', 'x', and 'y' arguments are required and must be provided.")
  expect_error(scatter(penguins), "The 'data', 'x', and 'y' arguments are required and must be provided.")
  expect_error(scatter(penguins, bill_length_mm), "The 'data', 'x', and 'y' arguments are required and must be provided.")
})

# Test 6: Testing non existent columns
test_that("Function throws error if columns are not valid", {
  expect_error(scatter(penguins, non_existent_column, bill_depth_mm),
               "Both non_existent_column and bill_depth_mm must be valid column names in the provided data frame.")
  expect_error(scatter(penguins, bill_length_mm, non_existent_column),
               "Both bill_length_mm and non_existent_column must be valid column names in the provided data frame.")
})

# Test 7: Testing non data frame argument
test_that("Function throws error if data is not a data frame", {
  expect_error(scatter(matrix(1:10, nrow = 5), bill_length_mm, bill_depth_mm),
               "The 'data' argument must be a data frame.")
})
