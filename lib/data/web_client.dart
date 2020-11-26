/// A class that is ment to represent a Web service you would call to fetch
/// and presist Todos and from the cloud.
///
/// Since we're trying to keep this example simple, it doesn't communicate with
/// a real server but simply emulates the functionality.
class WebClient {
  final Duration delay;

  const WebClient([this.delay = const Duration(milliseconds: 1200)]);
}
