import 'dart:io';

/// Loads and saves a list of todos using a text file stored on the device.
class FileStorage {
  final String tag;
  final Future<Directory> Function() getDirectory;

  const FileStorage(this.tag, this.getDirectory);
}
