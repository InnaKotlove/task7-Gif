import 'package:task7/helpers/fetch.dart';
import 'package:task7/helpers/constants.dart';

class GifsFetch {
  static Future<Map<String, dynamic>?> getGifs(String searchString) async {
    FetchHelper fetchData = FetchHelper(
        "$giphyUrl?api_key=$giphyApiKey&q=$searchString&limit=$numberOfGifs&offset=0&rating=g");

    Map<String, dynamic>? decodedData = await fetchData.getData();
    return decodedData;
  }
}
