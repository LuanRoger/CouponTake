class RedeemHistoryHttpRequest {
  String authKey;
  int page;
  int limitPerPage;

  RedeemHistoryHttpRequest(this.authKey,
      {required this.page, this.limitPerPage = 5});
}
