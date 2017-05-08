create.answer.key <- function(parsed, answer.key.filename)
{
  ## create the answer key .R file for autocorrect
  parsed.vec <- unlist(parsed)
  cat(parsed.vec, sep = "\n", file = answer.key.filename)
}
