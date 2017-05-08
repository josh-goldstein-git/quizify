
parse.initial <- extract.quiz.chunks <- function(initial.filename)
{
  ## parses the chunks, attaches question number to each variable,
  ## and prefixes variables with dot.

  ## (note-to-self: to avoid having multiline strings chopped up,
  ## don't insert new-lines in hints, answers, and such)

  out <- get.chunk.element.list(initial.filename)
  chunk.element.list <- out$chunk.element.list
  x <- out$x

  ## initialize list for results
  chunk.out.list <- vector("list", length(chunk.element.list))
  ## loop through chunks and transform them
  ## 1. add "." before each varname
  ## 2. add qnumber to each varname
  for (i in 1:length(chunk.element.list))
  {
    chunk.vec <- x[chunk.element.list[[i]]] # get next chunk
    ## get qnumber
    qnumber.str = chunk.vec[grep("qnumber", chunk.vec)]
    qnumber = unlist(strsplit(qnumber.str, split = " "))[3]
    ## 1. add "." before each varname
    ## (variables have " =" following them)
    dot.chunk.vec <- gsub("^", ".", chunk.vec)
    ## bug: this doesn't check to see if we have an equals sign
    ## and so it adds dots to every line
    ## 2. add qnumber to each varname
    chunk.out = gsub(" =", paste0(qnumber, " ="), dot.chunk.vec)
    chunk.out.list[[i]] <- chunk.out
    names(chunk.out.list)[i] <- qnumber
  }
  return(chunk.out.list)
}

