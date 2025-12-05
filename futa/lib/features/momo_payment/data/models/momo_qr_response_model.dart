class MomoQrResponse {
  final String orderId;
  /// Có thể là qrCodeUrl hoặc payUrl (đều là string để encode QR)
  final String qrCodeUrl;
  final String? deeplink;

  MomoQrResponse({
    required this.orderId,
    required this.qrCodeUrl,
    this.deeplink,
  });

  factory MomoQrResponse.fromJson(Map<String, dynamic> json) {
    final qr = json['qrCodeUrl'] as String? ??
        json['payUrl'] as String? ??
        '';

    return MomoQrResponse(
      orderId: json['orderId']?.toString() ?? '',
      qrCodeUrl: qr,
      deeplink: json['deeplink'] as String? ?? json['payUrl'] as String?,
    );
  }
}
