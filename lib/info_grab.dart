import 'dart:convert';
import 'package:http/http.dart' as http;

class InfoGrab{
  final String name;
  final String type;
  final String desc;

  InfoGrab(Map<String,dynamic> cardJson):
      name=cardJson['name'],
      type=cardJson['type'],
      desc=cardJson['desc'];

  static Future<InfoGrab> fetchCard(String cardName) async{
    final url=Uri.parse(
      'https://db.ygoprodeck.com/api/v7/cardinfo.php?name=${Uri.encodeComponent(cardName)}',
    );//构建请求地址

    final response=await http.get(url);//打开网址，等待网站回应

    if(response.statusCode==200){
      final jsonData=jsonDecode(response.body);
      final cardJson=jsonData['data'][0];//交给InfoGrab构造函数，提取出name,type,desc
      return InfoGrab(cardJson);
    }else{
      throw Exception('Card not found: $cardName');
    }
  }
}