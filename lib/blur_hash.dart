library blur_hash;

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:image/image.dart';

import 'blurHash/blurHash.dart';

class BlurHash {

  /// for (460*240, x:9 y:5) take 9 sec, 95 char
  static String rgbaToHash(Uint8List bytes, int width, int height, {int numCompX = 8, int numCompY = 5}) {
    return encodeRgbaFast(bytes, width, height, numCompX: numCompX, numpCompY: numCompY);
  }

  /// for (240*140, x:8 y:5) take 3-8 sec
  /*static String picToHash(pic.Pic pic, int width, int height, {int numCompX = 8, int numCompY = 5}) {
    return encodeBlurHashFromPic(pic, width, height, numCompX: numCompX, numpCompY: numCompY);
  }*/

  static Uint8List hashToRgba(String hash, int width, int height, {double punch = 1.0}) {
    return decodeToRgba(hash, width, height, punch: punch);
  }

  /// take  mils
  static Future<ui.Image> hashToImage(String hash, int width, int height, {double punch = 1.0}) async {
    final rgb = decodeToRgba(hash, width, height, punch: punch);

    return rgbaToPng(rgb, width, height);
  }

  static Future<Uint8List> hashToImageBytes(String hash, int width, int height, {double punch = 1.0}) async {
    final rgb = decodeToRgba(hash, width, height, punch: punch);

    return rgbaToPngBytes(rgb, width, height);
  }

  static Image hashToImagePkg(String hash, int width, int height, {double punch = 1.0}) {
    return decodeToImage(hash, width, height, punch: punch);
  }

  static Future<ui.Image> rgbaToPng(Uint8List rgb, int width, int height) async {
    ui.Image? img;
    final c = Completer();
    ui.decodeImageFromPixels(rgb, width, height, ui.PixelFormat.rgba8888, (ui.Image result) {
      img = result;
      c.complete();
    });

    await c.future;
    return img!;
  }

  static Future<Uint8List> rgbaToPngBytes(Uint8List rgb, int width, int height) async {
    final img = await rgbaToPng(rgb, width, height);
    return (await img.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
}
