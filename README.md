
<!-- README.md is generated from README.Rmd. Please edit that file -->
Goal of the quizify package
===========================

The quizify package is a tool for creating R notebooks with interactive quizes for students to use in RStudio. The idea is that the instructor creates an "initial" quiz notebook with regular contents, free-form quiz questions, and *marked-up structured answers*, and then the quizify package transforms this into the "final" version of the quiz. The final version of the quiz encodes all of the answers as well as hints, instructions, and explanations to each quiz question. The final version also replaces the instructors marked-up answers with the format to be presented to the student.

An illustrative example of the "final" format
=============================================

You can see the package in action by running the built-in example.

1.  Open RStudio and set the working directory to where you want the "final" file to reside.

2.  From the console,

    ``` r
    library(quizify)  
    example(quizify)
    ```

3.  In RStudio, open the newly-created R notebook file `arithmetic_quiz_final.Rmd`.

4.  Run the code in the notebook chunk by chunk.

The "initial" format.
=====================

To see the "initial" format, make a copy of the file located at

``` r
system.file("arithmetic_quiz_initial.Rmd", package="quizify")
```

You will see that the answer-key is given between double-braces {{...}} and contains the variables

``` r
{{  
qnumber = 1.1 # any unique number is fine here  
instructions = "Replace the NA with your answer (e.g., 'A' in quotes)" # any text string is fine here  
correct.answer = "A" # only letters in quotes are allowed, e.g., "A","B", ...  
hint = "Try '2+2' from R console" # any text string  
explanation = "Hard to explain" # any text string   
}}
```

Notes:

1.  Avoid using equals signs within your explanations as the parser will think there are more assignments to make

2.  Avoid using newlines in your text strings as these will also format incorrectly

Installation instructions
=========================

``` r
devtools::install_github(“josh-goldstein-git/quizify”)
```
