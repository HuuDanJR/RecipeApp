class VideoM{
  final int totalResults;
  final List<Videos> videos;
  VideoM({this.totalResults,this.videos});
  
  factory VideoM.fromJson(Map<String,dynamic> json){
    var list = json['videos'] as List;
    List<Videos> videoList = list.map((f)=>Videos.fromJson(f)).toList();
    return  VideoM(
      totalResults: json['totalResults'],
      videos: videoList
    );
  }
}

class Videos{
  final String title;
  final String shortTitle;
  final String  youTubeId;
  final double rating;
  final int views;
  final String thumbnail;
  final int length;

  Videos({this.title, this.shortTitle, this.youTubeId, this.rating, this.views, this.thumbnail, this.length});
  factory Videos.fromJson(Map<String,dynamic> json){
    return Videos(
      title:json['title'],
      shortTitle:json['shortTitle'],
      youTubeId:json['youTubeId'],
      rating:json['rating'],
      views:json['views'],
      thumbnail:json['thumbnail'],
      length:json['length'],
    );
  }
}