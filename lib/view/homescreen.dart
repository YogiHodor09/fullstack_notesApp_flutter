import 'package:flutter/material.dart';
import 'package:notes_app/model/notes/NotesResponse.dart';

import '../bloc/notes/notesBloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getNotesData();
  }

  @override
  Widget build(BuildContext context) {
    return _buildUserWidget();
  }
}

Widget _buildLoadingWidget() {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [Text("Loading Notes ..."), CircularProgressIndicator()],
  ));
}

Widget _buildErrorWidget(String error) {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Error occurred: $error"),
    ],
  ));
}

Widget _buildUserWidget() {
  return Container();
}

getNotesData() async {
  try {
    var notesData = await notesBloc.getNotes();
    debugPrint('Notes data :: $notesData');
  } catch (e) {
    debugPrint('Exception :: ${e.toString()}');
  }
}
