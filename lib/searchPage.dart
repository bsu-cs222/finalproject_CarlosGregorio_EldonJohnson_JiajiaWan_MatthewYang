import 'package:flutter/material.dart';
import 'package:finalproject/info_grab.dart';
//info 复杂存储卡牌信息，调用API
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState()=>_SearchPageState();
  //创建State对象，UI页面写在_SearchPageState()里
}

class _SearchPageState extends State<SearchPage>{
  final TextEditingController _controller=TextEditingController();
//读取用户在输入框中输入的文字
  InfoGrab? _cardInfo;//卡牌信息对象
  bool _isLoading = false;//是否正在加载中
  String? _errorMessage;//存储错误提示文字

  Future<void> _search() async{//调用API并更新UI状态
    setState((){//每次调用都会触发build()重新渲染UI
      _isLoading=true;//显示转圈动画
      _errorMessage=null;//清楚上次的错误信息
      _cardInfo=null;//清楚上次的搜索结果
    });

    try{//调用InfoGrab.fetchCard()
      final result=await InfoGrab.fetchCard(_controller.text.trim());
      setState((){//请求成功，保存卡牌数据
        _cardInfo = result;//触发UI更新，显示卡牌信息
      });
    } catch(e){
      setState((){
        _errorMessage='Card not found.Please check the name and try again.';
      });
    }finally{
      setState(() {
        _isLoading=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {//构建UI页面
    //每次setState()被调用，build()会重新执行
    return Scaffold(
      appBar: AppBar(
        title: const Text('YuGiOh Card Search'),//顶部标题栏
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),//页面四周留16像素边距
        child: Column(//垂直排列所有子组件
          children: [
            // 搜索栏
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter card name...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _isLoading ? null : _search(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _isLoading ? null : _search,
                  child: const Text('Search'),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 加载中
            if (_isLoading)
              const CircularProgressIndicator(),

            // 错误信息
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),

            if (_cardInfo != null) ...[
              ListTile(
                title: const Text('Card Name'),
                subtitle: Text(_cardInfo!.name),
              ),
              ListTile(
                title: const Text('Card Type'),
                subtitle: Text(_cardInfo!.type),
              ),
              ListTile(
                title: const Text('Card Effect'),
                subtitle: Text(_cardInfo!.desc),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
