class Response {
  final Map data;
  final bool result;
  final String message;

  Response(this.data, this.result, {this.message = 'suceess'});
}
