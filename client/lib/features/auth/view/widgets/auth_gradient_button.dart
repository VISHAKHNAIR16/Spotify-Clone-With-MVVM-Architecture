import 'package:flutter/material.dart';
import 'package:spotify_clone/core/theme/app_pallete.dart';
import 'package:spotify_clone/core/theme/size_config.dart';

class AuthGradientButton
    extends
        StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const AuthGradientButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context,){
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Pallete.gradient1,
            Pallete.gradient2,
          ],
          begin: AlignmentGeometry.bottomLeft,
          end: AlignmentGeometry.topRight,
        ),
        borderRadius: BorderRadius.circular(
          SizeConfig.screenWidth *
              0.03,
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(
            SizeConfig.screenHeight *
                0.42,
            SizeConfig.screenWidth *
                0.15,
          ),
          backgroundColor: Pallete.transparentColor,
          shadowColor: Pallete.transparentColor,
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
            fontSize:
                SizeConfig.screenWidth *
                0.05,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
