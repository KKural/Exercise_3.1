from evaluation_utils import EvaluationResult, Message


def check_multiple_choice(context):
    # Remove newline and any whitespace
    actual = context.actual.strip()

    feedback = {
        "1": {
            "correct": False,
            "message": "Incorrect. This describes inferential statistics, which predict future outcomes based on sample data.",
            "concept": "This is actually the purpose of inferential statistics, not descriptive statistics."
        },
        "2": {
            "correct": True,
            "message": "Correct! Descriptive statistics summarize and describe the main features of collected data.",
            "concept": "Descriptive statistics help us understand what the data shows us through measures like mean, median, mode, and visualizations."
        },
        "3": {
            "correct": False,
            "message": "Incorrect. Establishing causal relationships is typically done through inferential statistics.",
            "concept": "While descriptive statistics can show correlations, establishing causation requires inferential methods and experimental design."
        },
        "4": {
            "correct": False,
            "message": "Incorrect. Testing hypotheses about population parameters is the main purpose of inferential statistics.",
            "concept": "Hypothesis testing uses sample data to make inferences about populations, which is inferential statistics."
        }
    }

    if actual in feedback:
        result = feedback[actual]
        messages = [
            Message(result["message"]),
            Message(result["concept"])
        ]
        return EvaluationResult(
            result=result["correct"],
            dsl_expected="2",
            dsl_actual=actual,
            messages=messages
        )
    else:
        return EvaluationResult(
            result=False,
            dsl_expected="2",
            dsl_actual=actual,
            messages=[Message("Please enter a number between 1 and 4.")]
        )
