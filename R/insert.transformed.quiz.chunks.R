insert.transformed.quiz.chunks <- function(initial.filename,
                                           transformed.chunk.list)
{

  ## put the transformed quiz chunks into the original file
  ## for subsequent output in create.final()

  out <- get.chunk.element.list(initial.filename)
  chunk.element.list <- out$chunk.element.list
  x <- out$x
  x.out = x
  x.out[unlist(chunk.element.list)] <- NA
  tag.start.index.vec <- unlist(lapply(chunk.element.list, min))
  transformed.out.list <- transformed.chunk.list
  for (i in 1:length(transformed.out.list))
  {
    new.chunk <- transformed.out.list[[i]]
    k <- tag.start.index.vec[i]
    n <- length(new.chunk) - 1
    ## check if new chunk smaller than old chunk
    n.old <- length(chunk.element.list[[i]])
    if (n > n.old)
      print("error")
    if (n <= n.old)
      print("ok, new chunk smaller than old chunk")
    x.out[k:(k+n)] <- new.chunk
    x.out.no.na <- x.out[!is.na(x.out) &
                           !(x.out %in% c("{{", "}}"))]
  }
  return(x.out.no.na)
}
