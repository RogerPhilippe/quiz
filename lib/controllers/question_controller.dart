import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quiz_app/models/Questions.dart';
import 'package:quiz_app/screens/score/score_screen.dart';

// We use get package for our state manager

class QuestionController extends GetxController with SingleGetTickerProviderMixin {

  AnimationController _animationController;
  Animation _animation;
  // That we can access our animation outside
  Animation get animation => this._animation;

  PageController _pageController;
  PageController get pageController => this._pageController;

  List<Question> _questions = sample_data.map((question) =>
      Question(
          id: question['id'],
          question: question['question'],
          options: question['options'],
          answer: question['answer_index']
      )).toList();

  List<Question> get questions => this._questions;

  bool _isAnswered = false;
  bool get isAnswered => this._isAnswered;

  int _correctAns = 0;
  int get correctAns => this._correctAns;

  int _selectedAns;
  int get selectedAns => _selectedAns;

  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  int _numOfCorrectAns = 0;
  int get numOdCorrectAns => this._numOfCorrectAns;

  // Called immediately after the widget is allocated in memory
  @override
  void onInit() {
    // Our animation duration is 60 seconds
    // so our plan is to fill the progress bar within 60s
    _animationController =
        AnimationController(duration: Duration(seconds: 60), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        // Update like setState
        update();
      });

    // Start animation
    // Once 60s is completed go to the next question
    _animationController.forward().whenComplete(nextQuestion);

    _pageController = PageController();

    super.onInit();
  }

  // Called just before the controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  void checkAns(Question question, int selectedIndex) {

    // set for once user press any option then it will run
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) _numOfCorrectAns++;

    // It will stop the counter
    _animationController.stop();
    update();

    // Once user select ans after 3s it will go to the next question
    Future.delayed(Duration(seconds: 3), (){
      nextQuestion();
    });

  }

  void nextQuestion() {

    if (_questionNumber.value != _questions.length) {

      _isAnswered = false;
      _pageController
          .nextPage(duration: Duration(milliseconds: 250), curve: Curves.ease);

      // Reset the counter
      _animationController.reset();

      // Then start it again
      // Once timer is finish go to the next question
      _animationController.forward().whenComplete(nextQuestion);

    } else {
      // Get package provider us simple way to navigate another page
      Get.to(() => ScoreScreen());
    }

  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index +1;
  }

}