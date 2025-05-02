import 'package:flutter/material.dart';

class AssetsImage {
  const AssetsImage._();
  static const AssetsImagesGen images = AssetsImagesGen();
}

class AssetsImagesGen {
  const AssetsImagesGen();


  // Cara pertama
  static Image get idn =>
      const AssetGenImage('assets/images/idn.png').image(100, 50);

  static Image get back =>
      const AssetGenImage('assets/images/back.png').image(100, 50);

  static Image get logoWhite =>
      const AssetGenImage('assets/images/logo_white.png').image(200, 100);

  // Cara kedua
  AssetGenImage get imageFile => const AssetGenImage('assets/images/logo_blue.png');
  AssetGenImage get receiptCard => const AssetGenImage('assets/images/receipt_card.png');
  AssetGenImage get SPIDN => const AssetGenImage('assets/images/icon.png');
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  ImageProvider provider() => AssetImage(_assetName);

  final String _assetName;

  Image image(double? width, double? height) {
    return Image.asset(
      _assetName,
      width: width,
      height: height,
    );
  }
}
