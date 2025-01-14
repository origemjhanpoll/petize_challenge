import 'package:url_launcher/url_launcher.dart';

Future<void> launchInAppWithBrowserOptions(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.inAppBrowserView,
    browserConfiguration: const BrowserConfiguration(showTitle: true),
  )) {
    throw Exception('Could not launch $url');
  }
}

Future<void> launchInWebView(Uri url) async {
  if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
    throw Exception('Could not launch $url');
  }
}
