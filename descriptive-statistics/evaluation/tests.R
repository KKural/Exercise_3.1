
```R name=evaluation/tests.R
context({
  testcase("Checking answer", function() {
    # Get the last value from student's environment
    student_output <- capture.output(eval(parse(text = readLines("student.R"))))
    
    # If there's nothing in the output, try to get the last value
    if (length(student_output) == 0) {
      student_code <- parse(text = readLines("student.R"))
      if (length(student_code) > 0) {
        student_output <- capture.output(eval(student_code[length(student_code)]))
      }
    }
    
    # Clean up the student's output
    student_answer <- trimws(paste(student_output, collapse = ""))
    
    # Check if the student's answer is exactly "2"
    testcaseAssert("The answer is correct", {
      identical(student_answer, "2")
    })
  })
})