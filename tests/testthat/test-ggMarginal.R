runMarginalTests <- function(ggplot2Version) {
  context <- paste("ggMarginal under ggplot2 version", ggplot2Version)

  context(context)

  test_that("ggMarginal can produce basic marginal plots", {
    sapply(c(
      "basic density", "basic histogram", "basic boxplot", "basic densigram",
      "basic violin plot", "scatter plot from data"
    ), function(x) expectDopp2(x, ggplot2Version))
  })

  test_that("ggMarginal's other params work", {
    sapply(c(
      "only x margin", "smaller marginal plots", "both hists red col",
      "top hist red col and fill"
    ), function(x) expectDopp2(x, ggplot2Version))
  })

  test_that("Misc. issues are solved", {
    sapply(c(
      "theme bw", "legend and title",
      "flipped coord where x is drat and y is wt",
      "subtitle but no title",
      "geom_line provided as first geom",
      "no density fill for densigrams"
    ), function(x) expectDopp2(x, ggplot2Version))
  })

  test_that("Grouping feature works as expected", {
    sapply(
      c(
        "col and fill mapped", "fill mapped with low alpha",
        "colour mapped with grey fill",
        "colour mapped and colour param provided",
        "colour & fill mapped and both params provided"
      ), function(x) expectDopp2(x, ggplot2Version)
    )
  })

  test_that("Transforms to scatter plot scales are reflected in marginals", {
    sapply(
      c(
        "x-axis limits using scale_x_continuous",
        "axis limits using xlim and ylim", "x-axis limits for histograms",
        "x-axis limits for marginals with y aes", "x and y scale_reverse",
        "geom_smooth with aligned marg plots"
      ), function(x) expectDopp2(x, ggplot2Version)
    )
  })
}

# Function to run all visual regression tests across all ggplot2 versions
runMarginalTestsApply <- function() {
  withVersions(
    vdiffr = "0.1.1", fontquiver = "0.2.1", svglite = "1.2.0", code = {
      sapply(c("2.2.0", "2.2.1", "latest"), function(ggplot2Version) {
        withVersions(ggplot2 = ggplot2Version, code = {
          runMarginalTests(ggplot2Version)
        })
      })
    }
  )
}

if (shouldTest()) {
  runMarginalTestsApply()
}
