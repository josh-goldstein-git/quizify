
transform.quiz.chunks <- function(chunk.out.list)
{
  ## turns list of original chunks from initial into list of
  ## transformed chunks for final the transformed chunks have the
  ## quiz as we want the students to see it.
  ## ```{r}
  ## # ... instructions ...
  ## answer2.1 = NA
  ## quiz.check(answer2.1)
  ## ```
  out.list <- chunk.out.list

  transformed.chunk.list <- vector("list", length(chunk.out.list))
  for (i in 1:length(chunk.out.list))
  {
    chunk.vec <- out.list[[i]]
    qnumber <- names(out.list)[1]

    this.answer.name = paste0("answer", qnumber)
    ## get this.instructions
    foo <- chunk.vec[grep("instructions", chunk.vec)]
    this.instructions = unlist(strsplit(foo, split = "="))[2]
    transformed.chunk <- capture.output(
      cat("```{r}\n",
          "## ", this.instructions, "\n",
          this.answer.name, " = NA", "\n",
          "quiz.check(", this.answer.name, ")", "\n",
          "```\n",
          sep = ""))
    cat(transformed.chunk, sep = "\n")
    transformed.chunk.list[[i]] <- transformed.chunk

  }
  return(transformed.chunk.list)
}
