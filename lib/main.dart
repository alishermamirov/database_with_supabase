import 'package:database_with_supabase/screens/notes_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://rfquurjzjbhczxjdncdh.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJmcXV1cmp6amJoY3p4amRuY2RoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE1MDg4NzUsImV4cCI6MjA0NzA4NDg3NX0.1xcLw1S1SyLfIHdctyOuT7CedSZZbnrk1tTfV8h1jq4",
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesScreen(),
    );
  }
}
