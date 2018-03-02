
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
      this.title = jsonObj['title'];
      this.author = jsonObj['author'];
      this.director = jsonObj['director'];
      this.posterUrl = jsonObj['posterUrl'];
      this.description = jsonObj['description'];
    }
  }
