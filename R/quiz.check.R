#' Check a quiz answer
#'
#' @param ans An answer. E.g., "A", or 3.14
#' @return No value is returned, but message is displayed.
#' @examples
#' .tot = 0
#' .correct.answer1.1 = "A"
#' .hint1.1 = "'2+2'"
#' .explanation1.1 = "Arithmetic"
#' ## Q1.1 What is 2 + 2?
#' ## A. 4
#' ## B. 3
#' ## Replace the NA with your answer (e.g., 'A' in quotes)"
#' answer1.1 = NA
#' quiz.check(answer1.1)
#' answer1.1 = "A"
#' quiz.check(answer1.1)
#' answer1.1 = "B"
#' quiz.check(answer1.1)
#' answer1.1 = "C"
#' quiz.check(answer1.1)
#' answer1.1 = 4
#' quiz.check(answer1.1)
quiz.check <- function(ans)
{

    message.if.correct = "Correct."
    message.if.incorrect = "Sorry, incorrect. Try again."
    message.if.not.answered = "Question still lacks answer."
    message.if.not.in.quotes = paste("Your multiple choice answer needs to be in quotes. (For example, try \"A\" instead of A.)")
    message.if.numeric = paste("Please answer with the letter of your choice, not a number. (For example, \"A\", with the quotation marks.)")
    ##     if(!is.character(ans) &  length(ans) > 1) # to also detect char vector
    ## If NA
    if(is.na(ans))
        stop(message.if.not.answered)

    ## If A,B,C,D exists and is a numeric vector longer than 1
    if(is.numeric(ans) & length(ans) > 1)
        stop(message.if.not.in.quotes)

    ## If a single number
    if(is.numeric(ans) & length(ans) == 1)
        stop(message.if.numeric)

    ## If other answer not in quotes
    if(!is.character(ans))
        stop(message.if.not.in.quotes)


    ## parse name of ans
    name.of.ans <- deparse(substitute(ans))
    ## get qnumber
    qnumber = gsub("answer", "", name.of.ans)
    ## get names of vars we need
    this.correct.answer.name = paste0(".correct.answer", qnumber)
    this.hint.name = paste0(".hint", qnumber)
    this.explanation.name = paste0(".explanation", qnumber)

    this.correct.answer = get(this.correct.answer.name)
    this.hint = get(this.hint.name)
    this.explanation = get(this.explanation.name)

    cat("Your ",  name.of.ans, ": ")
    cat(ans)
    cat("\n")

    if (ans == this.correct.answer) {
        tot <<- tot + 1
        cat(message.if.correct)
        cat("\n")
        cat("Explanation: ", this.explanation)
        cat("\n")
    }
    if (ans != this.correct.answer) {
        ## cat(message.if.incorrect)
        ## cat("\n")
        ## cat("Hint:", this.hint)
        ## cat("\n")
        warning(message.if.incorrect, "\n")
        warning("Hint: ", this.hint, "\n")
    }
}
