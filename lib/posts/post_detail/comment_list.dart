part of 'page.dart';
class CommentListView extends StatefulWidget {
  CommentListView({Key key, this.filteredComment})
      : assert(filteredComment != null),
        super(key: key);

  final List<PostComment> filteredComment;

  @override
  _CommentListViewState createState() => _CommentListViewState();
}

class _CommentListViewState extends State<CommentListView> {
  final String title = "Post Detail";
  TextEditingController controller = new TextEditingController();


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.filteredComment.length != 0
        ? ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: widget.filteredComment.length,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5.0),
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            margin: EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 20.0,
                  ),
                ],
                border: Border.all(color: Colors.grey, width: 0.5)),
            alignment: Alignment.centerLeft,
            child: ListTile(
              title: RichText(
                text: TextSpan(
                    text: 'Name: ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                        text: '${widget.filteredComment[index].name}',
                        style: TextStyle(color: Colors.brown, fontSize: 16),
                      )
                    ]),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                          text: 'Email: ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${widget.filteredComment[index].email}',
                              style: TextStyle(
                                  color: Colors.brown, fontSize: 14),
                            )
                          ]),
                    ),
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Body: ${widget.filteredComment[index].body}"))
                ],
              ),
            ),
          );
        })
        : Constants.customMessage("Comments aren't available.");
  }
}
