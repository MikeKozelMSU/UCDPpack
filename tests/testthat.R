library(testthat)
library(UCDPack)

test_check("UCDPack")

test_that(
  (
    expect_success(map_plot())
  )
)



