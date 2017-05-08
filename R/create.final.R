create.final <- function(parsed, final.filename, initial.filename,
                         coded.answer.key)
{
  ## create the final .Rmd version of the lab
  parsed.transformed <- transform.quiz.chunks(parsed)
  x.out.no.na <- insert.transformed.quiz.chunks(initial.filename,
                                                transformed.chunk.list
                                                = parsed.transformed)
  ## insert the encoded stuff into x.out.no.na
  x.final = x.out.no.na
  s <- grep("tot = 0", x.out.no.na)[1]
  x.final <- c(x.out.no.na[1:s],
               paste0("answer.key = ", "\"", coded.answer.key, "\""),
               "source.coded.txt(answer.key)",
               x.out.no.na[(s+1):length(x.out.no.na)])
  cat(x.final, sep = "\n", file = final.filename)
}


