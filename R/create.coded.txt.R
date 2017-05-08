create.coded.txt <- function(txt)
{
  ## txt could be something like the answer key
  ## answer key is a vector of strings
  ## [1] ".qnumber1.1 = 1.1"
  ## [2] ".correct.answer1.1 = \"B\""
  ## [3] ".hint1.1 = \"Ask someone ... given above.\""
  txt.gz <- memCompress(txt, "g")
  txt.gz.64 <- base64enc::base64encode(txt.gz)
  return(txt.gz.64)
}
