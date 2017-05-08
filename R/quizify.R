#' Create self-graded quizes within .Rmd files
#'
#' @param initial.filename Name of markdown file with quiz questions in {{...}} markup. E.g., quiz_initial.Rmd
#' @param final.filename Name of markdown file to output to. E.g., quiz_final.Rmd
#' @param answer.key.filename An intermediate file (will be deprecated someday)
#' @return No value is returned, but final file is created.
#' @examples
#' initial.filename = system.file("arithmetic_quiz_initial.Rmd",
#'                                package = "quizify")
#' quizify(initial.filename,
#'         final.filename = "arithmetic_quiz_final.Rmd",
#'         answer.key.filename = "check_arithmetic_quiz.R")
#' # can cat to screen
#' x = scan("arithmetic_quiz_final.Rmd", character(), sep = "\n")
#' cat(x, sep = "\n")
#' ## to clean up directory
#' ## file.remove("arithmetic_quiz_final.Rmd")

quizify <- function(initial.filename,
                    final.filename,
                    answer.key.filename)
{
  ## wrapper to create the whole machinery for the self-graded quizes
  parsed <- parse.initial(initial.filename)
  create.answer.key(parsed, answer.key.filename)
  coded.answer.key <- create.coded.answer.key(parsed)
  create.final(parsed, final.filename, initial.filename,
               coded.answer.key)
  return(NULL)
}
