import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;
  int _rightAnswerCount = 0;
  int _wrongAnswerCount = 0;

  List<Question> _questionBank = [
    Question('Some cats are actually allergic to humans', true),
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true),
    Question('Buzz Aldrin\'s mother\'s maiden name was \"Moon\".', true),
    Question('It is illegal to pee in the Ocean in Portugal.', true),
    Question(
        'No piece of square dry paper can be folded in half more than 7 times.',
        false),
    Question(
        'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
        true),
    Question(
        'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
        false),
    Question(
        'The total surface area of two human lungs is approximately 70 square metres.',
        true),
    Question('Google was originally called \"Backrub\".', true),
    Question(
        'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
        true),
    Question(
        'In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.',
        true),
  ];

  // getter for questionNumber
  int get questionNumber => _questionNumber;

  // getter for totalQuestions
  int get totalQuestions => _questionBank.length;

  // getter for rightAnswerCount
  int get rightAnswerCount => _rightAnswerCount;

  // getter for wrongAnswerCount
  int get wrongAnswerCount => _wrongAnswerCount;

  // getter for correctAnswer
  bool get correctAnswer => _questionBank[_questionNumber].questionAnswer;

  void incrementRightAnswer() => _rightAnswerCount++;

  void incrementWrongAnswer() => _wrongAnswerCount++;

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    } else {
      _questionNumber = -1;
    }
  }

  String getQuestionText() {
    if (isFinished()) {
      return 'Finished!\nTap any button to restart.';
    } else {
      return _questionBank[_questionNumber].questionText;
    }
  }

  //TODO: Step 3 Part A - Create a method called isFinished() here that checks to see if we have reached the last question. It should return (have an output) true if we've reached the last question and it should return false if we're not there yet.
  bool isFinished() {
    if (_questionNumber == -1) {
      return true;
    } else {
      return false;
    }
  }

  //TODO: Step 3 Part B - Use a print statement to check that isFinished is returning true when you are indeed at the end of the quiz and when a restart should happen.

  //TODO: Step 4 Part B - Create a reset() method here that sets the questionNumber back to 0.
  void reset() {
    _questionNumber = 0;
    _rightAnswerCount = 0;
    _wrongAnswerCount = 0;
  }
}
