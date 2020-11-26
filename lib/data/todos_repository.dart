import 'package:built_redux_sample/data/file_storage.dart';

import 'web_client.dart';
import 'package:path_provider/path_provider.dart';

class TodosRepository {
  final FileStorage fileStorage;
  final WebClient webClient;

  const TodosRepository({
    this.fileStorage = const FileStorage(
      '__built_redux_sample_app__',
      getApplicationDocumentsDirectory,
    ),
    this.webClient = const WebClient(),
  });
}
