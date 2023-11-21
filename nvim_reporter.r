parse <- function(results) {
  results <- results[[1]]$results
  lapply(results, function(x) {
    type <- testthat:::expectation_type(x)
    if (type != "success") {
      message <- x$message
    } else {
      message <- ""
    }
    if (type == "success") {
      type <- "✅"
    } else {
      type <- "❌"
    }
    data.frame(message = paste(type, message), type = type, line = x$srcref[1])
  }) |> Reduce(f = rbind)
}
