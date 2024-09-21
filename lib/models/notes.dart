class notes{
  String title;
  String description;

  notes({
    required this.title,
    required this.description
});

  Map<String,dynamic> toJson(){
    return {
      'title':title,
      'description':description,
    };
  }

  factory notes.fromJson(Map<String,dynamic> json){
    return notes(title:json['title'], description: json['description']);
  }
}