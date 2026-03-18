import 'package:finalproject/info_grab.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  InfoGrab? _cardInfo;
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _search() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _cardInfo = null;
    });

    try {
      final result = await InfoGrab.fetchCard(_controller.text.trim());
      setState(() {
        _cardInfo = result;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Card not found.Please check the name and try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('YuGiOh Card Search')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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

            if (_isLoading) const CircularProgressIndicator(),

            if (_errorMessage != null)
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),

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
