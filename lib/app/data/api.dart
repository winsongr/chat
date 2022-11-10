class ApiConst {
  static const String baseUrl = 'http://13.235.33.199/';
  static const String user = '${baseUrl}user/';
  static const String alluser = '${baseUrl}users/';
  static const String allchat = '${baseUrl}get_all_chats/';
  static const String allmsgs = '$baseUrl+get_all_messages/';
  static const String signin = '${user}sign_in';
  static const String signup = user;
  static const String getuserid = user;
  static const String createChat = "${baseUrl}create_chat";
}

class Socket {
  static const String socketUrl = 'http://43.204.209.21';
}

enum ReqType { get, post, put, delete }
