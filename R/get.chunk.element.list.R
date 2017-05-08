
get.chunk.element.list <- function(initial.filename)
{
  ## helper function that takes initial file and returns (1) a list
  ## of indices corresponding to the elements of each quiz chunk and
  ## (2) "x", the scan of whole initial file.

  x <- scan(initial.filename,
            what=character(0),
            sep = "\n",
            blank.lines.skip = F)

  ## now deal with chunks
  left.bracket.index <- grep("^\\{\\{", x)   # tag to start quiz chunk
  right.bracket.index <- grep("^\\}\\}", x)  # tag to end quiz chunk
  ## make list of chunk indices. each element of list is a set of indices
  ## note: we exclude the bracket delimiters
  chunk.element.list <- mapply(seq,
                               from = left.bracket.index + 1,
                               to = right.bracket.index - 1,
                               ## from = left.bracket.index ,
                               ## to = right.bracket.index ,
                               SIMPLIFY = FALSE) # returns list
  return(list(x=x, chunk.element.list = chunk.element.list))
}
