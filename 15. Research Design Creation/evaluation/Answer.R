context({
  testcase(
    "Research Design Evaluation",
    {
      testEqual(
        "Evaluating research design comprehensiveness",
        function(env) env$evaluationResult,
        "PLACEHOLDER_FOR_MANUAL_REVIEW",  # This exercise requires manual review
        comparator = function(generated, expected, ...) {
          # This is a template for open-ended evaluation that requires manual review
          # Automatic scoring is not applied for this creative-level question
          
          # Provide feedback about what constitutes a strong answer
          feedback <- paste(
            "✅ Your response has been submitted for review. A strong answer should include:",
            "",
            "1. **Research Design**: A clearly articulated research design that can establish causality",
            "   - Example: Quasi-experimental design with difference-in-differences analysis",
            "   - Example: Interrupted time-series with non-equivalent control group design",
            "",
            "2. **Sampling Strategy**: Well-defined sampling approach with appropriate comparison groups",
            "   - Should address selection of neighborhoods and methods to ensure comparability",
            "",
            "3. **Key Variables**: Identification of dependent, independent, and control variables",
            "   - Should include operational definitions and measurement approaches",
            "",
            "4. **Statistical Methods**: Appropriate statistical techniques for the proposed design",
            "   - Could include regression models, time-series analysis, propensity score matching, etc.",
            "   - Should match the data structure and research questions",
            "",
            "5. **Validity Considerations**: Strategies to address threats to internal and external validity",
            "   - Discussion of confounding variables and how they will be controlled",
            "",
            "Your instructor will assess how well your design integrates statistical principles and creates a methodologically sound approach.",
            sep = "\n"
          )
          
          get_reporter()$add_message(feedback, type = "markdown")
          
          # Always return TRUE since this is manually graded
          return(TRUE)
        }
      )
    }
  )
})
