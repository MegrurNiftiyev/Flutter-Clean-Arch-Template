import 'package:get_it/get_it.dart';
import 'cubits.dart';
import 'data_sources.dart';
import 'managers.dart';
import 'network.dart';
import 'repositories.dart';
import 'use_cases.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeDependencies() async {
  initializeManagers();
  initializeNetwork();
  initializeDataSources();
  initializeRepositories();
  initializeUseCases();
  initializeCubits();
}
