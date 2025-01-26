String query = r'''
  query ($id: Int) { # Define which variables will be used in the query (id)
  Media (id: $id, type: ANIME) { # Insert our variables into the query arguments (id) (type: ANIME is hard-coded in the query)
    id
    title {
      romaji
      english
      native
    }
    coverImage {
            large
        }
  }
} ''';

String searchQuery = r''' 
  query ($search: String) {
    Media(type: ANIME, search: $search) {
        coverImage {
            large
            extraLarge
            color
        }
        title {
            romaji
            english
            native
        }
    }
}

''';