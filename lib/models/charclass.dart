
class Character
{
  int char_id ;
  String name , birthday ,img,status,nickname ,portrayed ,category;
  List<String> occupation =[];
  List<int> appearance =[];
  List<int> better_call_saul_appearance =[];
  Character.fromJson(Map<String,dynamic>json)
  {
    char_id = json['char_id'] ;
    name = json['name'] ;
    birthday = json['birthday'] ;
    img = json['img'] ;
    status = json['status'] ;
    nickname = json['nickname'] ;
    portrayed = json['portrayed'] ;
    category = json['category'] ;
    occupation = json['occupation'].cast<String>();
    appearance = json['appearance'].cast<int>();
    better_call_saul_appearance = json['better_call_saul_appearance'].cast<int>();
  }


}