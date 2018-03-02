
class Movie {
    String title;
    String author;
    String director;
    String posterUrl;
    String description;

     Movie(String title, String description, String posterUrl) {
       this.title = title;
       this.description = description;
       this.posterUrl = posterUrl;
     }

     Movie.fromJson(Map<String, String> jsonObj) {
      this.title = jsonObj['Title'];
      this.author = jsonObj['Writer'];
      this.director = jsonObj['Director'];
      this.posterUrl = jsonObj['Poster'];
      this.description = jsonObj['Plot'];
    }
  }
