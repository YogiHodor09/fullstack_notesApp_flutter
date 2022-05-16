import 'package:flutter/material.dart';
import 'package:notes_app/model/notes/NotesResponse.dart';

import '../bloc/notes/notesBloc.dart';

var notesResponse = NotesResponse(notesData: [], success: false);

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
    Future.delayed(const Duration(milliseconds: 500), () {
      notesBloc.getNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HomeScreen'),
          centerTitle: true,
          elevation: 2.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildNotesWidget(),
        ));
  }
}

Widget _buildNotesWidget() {
  return StreamBuilder<NotesResponse>(
    stream: notesBloc.subject.stream,
    builder: (context, AsyncSnapshot<NotesResponse> snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data == null) {
          return _buildErrorWidget(snapshot.data.toString());
        }
        return _buildUserWidget(snapshot.data!);
      } else if (snapshot.hasError) {
        return _buildErrorWidget(snapshot.error.toString());
      } else {
        return _buildLoadingWidget();
      }
    },
  );
}

Widget _buildLoadingWidget() {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Text("Loading data from API..."),
      CircularProgressIndicator()
    ],
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

Widget _buildUserWidget(NotesResponse data) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [Text('Notes Data :: ${data.notesData![index].note}')],
          );
        },
        itemCount: data.notesData?.length),
  );
}
