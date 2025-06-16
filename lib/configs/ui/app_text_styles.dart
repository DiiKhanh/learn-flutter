import 'package:flutter/material.dart';
import 'package:my_app/configs/ui/app_colors.dart';

abstract final class AppTextStyles {
  const AppTextStyles._();

  static const _baseTextStyle = TextStyle();

  static TextStyle h1Bold = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 48,
    color: AppColors.current.greyscale900,
  );
  static TextStyle h2Bold = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 40,
    color: AppColors.current.greyscale900,
  );
  static TextStyle h3Bold = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 32,
    color: AppColors.current.greyscale900,
  );
  static TextStyle h4Bold = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 24,
    color: Colors.black,
  );
  static TextStyle h5Bold = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: AppColors.current.greyscale900,
  );
  static TextStyle h6Bold = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 18,
    color: AppColors.current.greyscale900,
  );

  static TextStyle textLabel = _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.grey[500],
    letterSpacing: 0.5,
  );

  static TextStyle bodyXLargeBold = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 18,
    color: AppColors.current.greyscale900,
  );
  static TextStyle bodyXLargeSemiBold = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w600,
    fontSize: 18,
    color: AppColors.current.greyscale900,
  );
  static TextStyle bodyXLargeMedium = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: AppColors.current.greyscale900,
  );
  static TextStyle bodyXLargeRegular = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 18,
    color: AppColors.current.greyscale900,
  );

  static TextStyle bodyLargeBold = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: AppColors.current.greyscale900,
  );
  static TextStyle bodyLargeSemiBold = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppColors.current.greyscale900,
  );
  static TextStyle bodyLargeMedium = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.current.greyscale900,
  );
  static TextStyle bodyLargeRegular = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppColors.current.greyscale900,
  );

  static TextStyle bodyMediumBold = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 14,
    color: AppColors.current.greyscale900,
  );
  static TextStyle bodyMediumSemiBold = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: AppColors.current.greyscale900,
  );
  static TextStyle bodyMedium = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: AppColors.current.greyscale900,
  );
  static TextStyle bodyMediumRegular = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.current.greyscale900,
  );

  static TextStyle bodySmallBold = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 12,
    color: AppColors.current.greyscale900,
  );
  static TextStyle bodySmallSemiBold = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w600,
    fontSize: 12,
    color: AppColors.current.greyscale900,
  );
  static TextStyle bodySmallMedium = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: AppColors.current.greyscale900,
  );
  static TextStyle bodySmallRegular = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColors.current.greyscale900,
  );

  static TextStyle bodyXSmallBold = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 10,
    color: AppColors.current.greyscale900,
  );
  static TextStyle bodyXSmallSemiBold = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w600,
    fontSize: 10,
    color: AppColors.current.greyscale900,
  );
  static TextStyle bodyXSmallMedium = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 10,
    color: AppColors.current.greyscale900,
  );
  static TextStyle bodyXSmallRegular = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 10,
    color: AppColors.current.greyscale900,
  );
}

extension CustomTextStyleExtension on TextStyle {
  TextStyle withPrimaryColor() {
    return copyWith(color: AppColors.current.primary500);
  }

  TextStyle withWhiteColor() {
    return copyWith(color: AppColors.current.otherWhite);
  }
}
