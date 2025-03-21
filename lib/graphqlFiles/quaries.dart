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

String singleSearchQuery = r''' 
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
        description
    }
}

''';

String searchQueryForPages = r''' 
  query ($id: Int, $page: Int, $perPage: Int, $search: String) {
    Page(page: $page, perPage: $perPage) {
        pageInfo {
            perPage
            currentPage
            hasNextPage
        }
        media(id: $id, search: $search, type: ANIME) {
            title {
                romaji
                english
                native
                userPreferred
            }
            
              coverImage {
                extraLarge
                large
                medium
                color
            }
            
            
            status
            description(asHtml:false)
            genres
            averageScore
            popularity
            
            nextAiringEpisode {
                airingAt
                timeUntilAiring
                episode
            }
            
            
        } 
    }
    
    
}


''';

String trendingAnime = r'''

  
  query ($page: Int, $perPage: Int) {
      Page(page: $page, perPage: $perPage) {
          media(sort: TRENDING_DESC, type: ANIME) {
              id
              title {
                  romaji
                  english
                  native
              }
              coverImage {
                  large
                  color
                  extraLarge
              }
              description
              genres
              averageScore
              popularity
              bannerImage
              
              nextAiringEpisode {
                airingAt
                timeUntilAiring
                episode
            }
            
              characters(role: MAIN) {
                nodes {
                    name {
                        full
                    }
                    image {
                        medium
                    }
                }
            }
            status
            episodes
            format
          }
      }
  }


 ''';

String allTimePopular = r''' 

  query ($page: Int, $perPage: Int, $season: MediaSeason, $seasonYear: Int) {
    Page(page: $page, perPage: $perPage) {
        media(season: $season, seasonYear: $seasonYear, sort: POPULARITY_DESC, type: ANIME) {
            id
            title {
                romaji
                english
                native
            }
            coverImage {
                large
                color
                extraLarge
            }
            description
            genres
            averageScore
            popularity
            bannerImage
            
            nextAiringEpisode {
                airingAt
                timeUntilAiring
                episode
            }
            
              characters(role: MAIN, perPage: 5) {
                nodes {
                    name {
                        full
                    }
                    image {
                        medium
                    }
                }
            }
            status
            episodes
            format
        }
    }
}


''';
