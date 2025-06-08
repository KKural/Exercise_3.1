from evaluation_utils import EvaluationResult


def check_multiple_choice(context):
    answer = context.actual.strip()
    correct_answer = context.expected.strip()

    feedback_messages = {
        "1": "❌ Incorrect. This describes inferential statistics - predicting future outcomes based on sample data.",
        "2": "✅ Correct! Descriptive statistics summarize and describe the main features of collected data.",
        "3": "❌ Incorrect. This describes inferential statistics - establishing causal relationships between variables.",
        "4": "❌ Incorrect. This describes inferential statistics - testing hypotheses about population parameters."
    }

    is_correct = (answer == correct_answer)
    message = feedback_messages.get(
        answer, "Please enter a number between 1 and 4.")

    return EvaluationResult(
        result=is_correct,
        readable_expected=f"Choice {correct_answer}",
        readable_actual=f"Choice {answer}",
        messages=[message]
    )
