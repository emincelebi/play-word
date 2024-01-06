import 'package:flutter/material.dart';
import 'package:play_word/models/question_model.dart';
import 'package:play_word/services/question_database.dart';

class AddView extends StatefulWidget {
  const AddView({super.key});

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  String? selectedLevel = 'A';
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late QuestionDatabaseHelper queDb;

  @override
  void initState() {
    queDb = QuestionDatabaseHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add Question'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Level: ',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'A',
                          groupValue: selectedLevel,
                          onChanged: (value) {
                            setState(() {
                              selectedLevel = value;
                            });
                          },
                        ),
                        const Text('A'),
                        Radio<String>(
                          value: 'B',
                          groupValue: selectedLevel,
                          onChanged: (value) {
                            setState(() {
                              selectedLevel = value;
                            });
                          },
                        ),
                        const Text('B'),
                        Radio<String>(
                          value: 'C',
                          groupValue: selectedLevel,
                          onChanged: (value) {
                            setState(() {
                              selectedLevel = value;
                            });
                          },
                        ),
                        const Text('C'),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Enter Question:',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    TextFormField(
                      controller: questionController,
                      maxLines: 2,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a question';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Type your question here',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Enter Answer of Question:',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    TextFormField(
                      controller: answerController,
                      maxLines: 2,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an answer';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Type your answer here',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            bool x = await queDb.doesQuestionExistByWord(questionController.text);
                            if (!x) {
                              int i = await queDb.insertQuestion(
                                QuestionModel(
                                    question: questionController.text,
                                    answer: answerController.text,
                                    level: selectedLevel),
                              );
                              if (i > 0) {
                                questionController.clear();
                                answerController.clear();
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('This question already exists in the database.'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    questionController.dispose();
    answerController.dispose();
    super.dispose();
  }
}
