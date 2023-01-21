import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class MessagesScreen extends StatefulWidget {
  final List messages;
  final ScrollController scrollController;
  const MessagesScreen({Key? key, required this.messages, required this.scrollController}) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}


class _MessagesScreenState extends State<MessagesScreen> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
     SchedulerBinding.instance.addPostFrameCallback((_) {
  widget.scrollController.jumpTo(
    widget.scrollController.position.maxScrollExtent,
  );
});
    return ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: widget.messages[index]['isUserMessage']
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: const Radius.circular(
                            20,
                          ),
                          topRight: const Radius.circular(20),
                          bottomRight: Radius.circular(
                              widget.messages[index]['isUserMessage'] ? 0 : 20),
                          topLeft: Radius.circular(
                              widget.messages[index]['isUserMessage'] ? 20 : 0),
                        ),
                        color: widget.messages[index]['isUserMessage']
                            ? Colors.blue[200]
                            : Colors.white.withOpacity(0.8)
                            ),
                    constraints: BoxConstraints(maxWidth: w * 2 / 3),
                    child:
                        Text(widget.messages[index]['message'].text.text[0])),
              ],
            ),
          );
        },
        controller: widget.scrollController,
        separatorBuilder: (_, i) => const Padding(padding: EdgeInsets.only(top: 10)),
        itemCount: widget.messages.length);
  }
}
