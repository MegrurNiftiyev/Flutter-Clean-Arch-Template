import 'package:get_it/get_it.dart';
import 'cubits.dart';
import 'data_sources.dart';
import 'repositories.dart';

final GetIt sl = GetIt.instance;

Future<void> setupLocator() async {
  setupDataSources();
  setupRepositories();
  setupCubits();
}
