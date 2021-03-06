library("pols503")
context("to_dummies")

test_df <- data.frame(x = c(rep("a", 2), rep("b", 2), rep("c", 2)),
                      y = 1)

test_that("to_dummies_ works as expected", {
  df2 <- to_dummies(test_df, "x")
  expect_equal(colnames(df2),
               c("y", "xa", "xb", "xc"))
  expect_equivalent(df2$xa, c(rep(1, 2), rep(0, 4)))
  expect_equivalent(df2$xb, c(rep(0, 2), rep(1, 2), rep(0, 2)))
  expect_equivalent(df2$xc, c(rep(0, 4), rep(1, 2)))
  expect_equivalent(df2$x, NULL)
})

test_that("to_dummies_ if remove = FALSE", {
  df2 <- to_dummies(test_df, "x", remove = FALSE)
  expect_equal(colnames(df2),
               c("x", "y", "xa", "xb", "xc"))
  expect_equivalent(df2$xa, c(rep(1, 2), rep(0, 4)))
  expect_equivalent(df2$xb, c(rep(0, 2), rep(1, 2), rep(0, 2)))
  expect_equivalent(df2$xc, c(rep(0, 4), rep(1, 2)))
  expect_equivalent(df2$x, test_df$x)
})

test_that("to_dummies_ if drop_level = TRUE", {
  df2 <- to_dummies(test_df, "x", drop_level = TRUE)
  expect_is(df2, "data.frame")
  expect_equal(colnames(df2),
               c("y", "xb", "xc"))
  expect_equivalent(df2$xb, c(rep(0, 2), rep(1, 2), rep(0, 2)))
  expect_equivalent(df2$xc, c(rep(0, 4), rep(1, 2)))
})

test_that("to_dummies_ with different sep", {
  df2 <- to_dummies(test_df, "x")
  expect_is(df2, "data.frame")
  expect_equal(colnames(df2),
               c("y", "xa", "xb", "xc"))
})

test_that("to_dummies using a bare column name", {
  df2 <- to_dummies(test_df, x)
  expect_equal(colnames(df2),
               c("y", "xa", "xb", "xc"))
  expect_is(df2, "data.frame")
})

test_that("to_dummies_ nethod for tbl_df", {
  df2 <- to_dummies(tbl_df(test_df), x)
  expect_equal(colnames(df2),
               c("y", "xa", "xb", "xc"))
  expect_is(df2, "tbl_df")
})

test_that("to_dummies works with factor variable", {
  test_df <- data.frame(x = ordered(c(rep("a", 2), rep("b", 2), rep("c", 2))))
  df2 <- to_dummies(test_df, "x",
                    drop_level = TRUE)
  expect_equal(colnames(df2), c("x.L", "x.Q"))
})

test_that("to_dummies works with missing variable expected", {
  .df <- test_df
  .df$x[1] <- NA
  df2 <- to_dummies(.df, "x")

})
