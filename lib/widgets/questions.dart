class QuizQuestion{ //make a quiz question object 
  const QuizQuestion(this.text, this.answers);
  final String text;
  final List<String> answers;

  List<String> getShuffledAnswers(){
    final shuffledList = List.of(answers); //copies list
    shuffledList.shuffle(); //shuffles the copy in place
    return shuffledList; //returns the list values
  }
}

List<QuizQuestion> getShuffledQuestions(List<QuizQuestion> questions){
    final shuffledList = List.of(questions); //copies list
    shuffledList.shuffle(); //shuffles the copy in place
    return shuffledList; //returns the list values
  }

const easyQuestions = [
  QuizQuestion(
    'What does "¡Hola!" mean?',
    [
      'Hello', //correct
      'Goodbye',
      'Cookie'
    ]
  ),
  QuizQuestion(
    'What does "¡Buenos días!" mean?',
    [
      'Good morning!', //correct
      'Good afternoon!',
      'Good night!'
    ]
  ),
  QuizQuestion(
    'What does "¿Cómo está(s)?" mean?',
    [
      'How are you?', //correct
      'What is todays date?',
      'What time is it?',
    ]
  ),
];

const mediumQuestions = [
  QuizQuestion(
    'Present Tense Conjugation For: AMAR',
    [
      'amo, amas, ama, amamos, aman', //correct
      'ame, ames, ame, amemos, amen',
      'ami, amis, ami, amimos, amin',
    ]
  ),
  QuizQuestion(
    'Present Tense Conjugation For: COMER',
    [
      'como, comes, come, comemos, comen', //correct
      'comi, comis, comi, comimos, comin',
      'coma, comas, coma, comamos, coman',
    ]
  ),
  QuizQuestion(
    'Present Tense Conjugation For:  VIVIR',
    [
      'vivo, vivis, vive, vivimos, viven', //correct
      'viva, vivas, viva, vivamos, vivan',
      'vivo, vivos, vivo, vivomos, vivon'
    ]
  )
];

const hardQuestions = [
  QuizQuestion(
    'Translate: "My favorite food is tacos"?',
    [
      'Mi comida favorita son los tacos', //correct]
      'Yo comido favorito es los tacos',
      'Lo comido de mi favorito es tacos'
    ]
  ),
  QuizQuestion(
    'Translate: "Where is the library?"?',
    [
      'Donde está la biblioteca?', //correct
      'Whero iso the librario?',
      'Como te la biblioteca?'
    ]
  ),
  QuizQuestion(
    'Translate: Me amo a los perros pero odio a los gatos.',
    [
      'I love dogs but I hate cats.', //correct
      'I like parrots and gates',
      'I do not know the answer',
    ]
  )
];

const premiumQuestions = [

];

var eq = getShuffledQuestions(easyQuestions);
var mq = getShuffledQuestions(mediumQuestions);
var hq = getShuffledQuestions(hardQuestions);
// var pq = getShuffledQuestions(premiumQuestions);