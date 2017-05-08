create.coded.answer.key <- function(parsed)
{
  parsed.vec <- unlist(parsed)
  txt.gz.64 <- create.coded.txt(parsed.vec)
  return(txt.gz.64)
}
