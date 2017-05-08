source.coded.txt <- function(coded.txt)
{
  txt.gz.64 <- coded.txt
  txt.gz.hat <- base64enc::base64decode(txt.gz.64)
  txt.hat.raw <- memDecompress(txt.gz.hat, "g")
  txt.hat <- rawToChar(txt.hat.raw)
  txt.hat.split <- strsplit(txt.hat, "\n")[[1]]
  z <- txt.hat.split
  eval(parse(text = z), envir = .GlobalEnv)
  #    return("answers now in .GlobalEnv")
}
