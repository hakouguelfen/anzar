class Tokens {
  final String accessToken;
  final String refreshToken;

  Tokens(this.accessToken, this.refreshToken);

  factory Tokens.fromJson(Map<String, dynamic> json) =>
      Tokens(json['accessToken'], json['refreshToken']);

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };
}
