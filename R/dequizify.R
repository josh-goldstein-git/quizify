## dequizify -- transform "final" version back into initial

## (0) read in final version (1 element per line)
## (1) get rmarkdown R chunks
## (2) decode 1st chunk to produce original quiz questions
## (3) transform chunks
## (4) write out the whole file

## (0) read in final version (1 element per line)
## this approach preserved empty lines for nice output

dequizify <- function(final_file_name)
{
    fileName <- final_file_name ## note this is the input (we're reverting)
    x_all_one_element <- readChar(fileName, file.info(fileName)$size)
    x <- strsplit(x_all_one_element, "\n")[[1]]
    ## x is one line per element (and preserves blank lines for nice
    ## formatting of output)


    ## (1) get rmarkdown R chunks
    r.chunk.starts <- grep("\\`\\`\\`\\{r\\}", x)
    r.chunk.ends <- grep("\\`\\`\\`$", x)
    if (length(r.chunk.starts) != length(r.chunk.ends))
        print("error: length(r.chunk.starts) != length(r.chunk.ends)")
    r.chunk.list <- vector("list", length = length(r.chunk.starts))
    for (i in 1:length(r.chunk.starts))
    {
        r.chunk.list[[i]] <- x[r.chunk.starts[i]:
                               r.chunk.ends[i]]
    }

    ## (2) decode 1st r chunk to produce original quiz questions
    foo <- r.chunk.list[[1]][4]
    coded.txt <- strsplit(x = foo, split = " ")[[1]][3]
    decode <- function(coded.txt)
    {
        txt.gz.64 <- coded.txt
        txt.gz.hat <- base64enc::base64decode(txt.gz.64)
        txt.hat.raw <- memDecompress(txt.gz.hat, "g")
        txt.hat <- rawToChar(txt.hat.raw)
        txt.hat.split <- strsplit(txt.hat, "\n")[[1]]
        z <- txt.hat.split
        return(z)
    }
    ## now get rid of initial dots .qnumber1.1 --> qnumber1.1
    z <- decode(coded.txt)
    dedot <- function(txt)
    {
        gsub("^\\.", "", txt)
    }
    zz <- dedot(z)

    ## now separate into chunks
    ## get qnumber.vec
    q.number.vec <- gsub(".*= ", "", zz[grep("qnumber", zz)])
    ## eg.,     [1] "1.1" "1.2"
    q.chunk.list <- vector("list", length = length(q.number.vec))
    for (i in 1:length(q.number.vec))
    {
        this.q.number <- q.number.vec[i]
        q.chunk.list[[i]] <- zz[grep(this.q.number, zz)]
        ## add {{ and }} at beginning and end of chunks
        q.chunk.list[[i]] <- c("{{", q.chunk.list[[i]],
                               "}}")
    }

    ## now get rid of suffix numbers in variables
    ## "qnumber1.2 = 1.2" --> "qnumber = 1.2"
    ## "hint1.2 =  ..." --> "hint = ..."
    q.chunk.list <-
        lapply(q.chunk.list, gsub, pattern = "[0-9]\\.[0-9] = ",
           replacement = " = ")

    ## (3) now structure whole thing to consist of prelude, quiz, and
    ## regular text chunks
    y <- x
    ## get full set of chunk deliminators -- working from r-code chunks
### (warning: this is ugly)
    all.chunk.starts <- unique(sort(c(1, r.chunk.starts, r.chunk.ends + 1)))
    ## challenge at end: our last line is a quiz chunk
    all.chunk.ends  <- unique(sort(c(r.chunk.ends, r.chunk.starts -1)))
    if (all.chunk.ends[length(all.chunk.ends)] == length(y))
    {
        ## remove last element of all.chunk.starts
        all.chunk.starts <- all.chunk.starts[-length(all.chunk.starts)]
    }
    if (all.chunk.ends[length(all.chunk.ends)] < length(y))
    {
        all.chunk.ends <- c(all.chunk.ends, length(y))
    }

    print(
        rbind(all.chunk.starts, all.chunk.ends)
    )
    ## line numbers
    ##                  [,1] [,2] [,3] [,4] [,5] [,6]
    ## all.chunk.starts    1    9   16   19   24   29
    ## all.chunk.ends      8   15   18   23   28   33

    all.chunk.list <- vector("list", length = length(all.chunk.starts))
    for (i in 1:length(all.chunk.starts))
    {
        all.chunk.list[[i]] <- y[all.chunk.starts[i]:
                                 all.chunk.ends[i]]
    }
    ## let's label each chunk as
    ## "prelude"
    ## "quiz"
    ## "regular_text"
    names(all.chunk.list) <- rep("regular_text", length(all.chunk.list))
    for (i in 1:length(all.chunk.list))
    {
        this.chunk <- all.chunk.list[[i]]
        print(i)
        prelude.flag <- sum(grepl("answer.key", this.chunk)) > 0
        if( prelude.flag)
            names(all.chunk.list)[i] <- "prelude"
        r.chunk.flag <- sum(grepl("\\{r\\}", this.chunk)) > 0
        if( r.chunk.flag & !prelude.flag)
            names(all.chunk.list)[i] <- "quiz"
        print(r.chunk.flag)
    }

    ## Now substitute
    reverted.chunk.list <- all.chunk.list
    prelude_initial <- c("```{r}",
                         "# leave this chunk as-is",
                         "tot = 0",
                         "```")

    reverted.chunk.list$prelude <- prelude_initial

    ## now replace list of quiz chunks with list of reverted quiz chunks
    quiz.chunk.elements <- grepl("quiz", names(reverted.chunk.list))
    reverted.chunk.list[quiz.chunk.elements] <- q.chunk.list

    random.number <- round(runif(1)*10^5, 4)

    initial_file_name <- paste0("reconstructed_",
                                gsub("_final", "",
                                     basename(final_file_name)))
    print(initial_file_name)
    write(x = unlist(reverted.chunk.list),
          file = initial_file_name)
    return(reverted.chunk.list)
}

if (0) {
    ## usage example: not run
dequizify("../arithmetic_quiz_final.Rmd")
library(quizify)
quizify("reconstructed_arithmetic_quiz.Rmd", "carl_final.Rmd", answer.key.filename = "foo")
}
