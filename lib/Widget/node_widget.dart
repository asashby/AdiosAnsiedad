import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Const/const_string.dart';
import '../Const/primary_theme.dart';
import 'circular_percent_indicator.dart';

class NodeWidget extends StatelessWidget {
  final double percent;

  const NodeWidget({
    super.key,
    this.percent = 0.0
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(astIcBgRoundBtnSvg,width: 60,height: 60),
        SizedBox(
          height: 62,
          width: 62,
          child: CircularPercentIndicator(
            radius: 24,
            lineWidth: 2,
            percent: percent != -1 ? percent/100 : 0,
            progressColor: PrimaryTheme.primaryColor,
            backgroundColor: Colors.transparent,
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ),
        getStatusWidget
      ],
    );
  }


  Widget get getStatusWidget{
    switch(percent){
      case -1:
        return SvgPicture.asset(astIcLockSvg,width: 19,height: 19);
      case 100:
        return SvgPicture.asset(astIcCompleteSvg,width: 19,height: 19);
      default:
        return Text("${percent.toInt()}%",style: const TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w600),);
    }
  }
}

//
// class GradientCircularProgressIndicator extends StatelessWidget {
//   final double radius;
//   final List<Color> gradientColors;
//   final double strokeWidth;
//
//   const GradientCircularProgressIndicator({
//     super.key,
//     required this.radius,
//     required this.gradientColors,
//     this.strokeWidth = 10.0,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       size: Size.fromRadius(radius),
//       painter: GradientCircularProgressPainter(
//         radius: radius,
//         gradientColors: gradientColors,
//         strokeWidth: strokeWidth,
//       ),
//     );
//   }
// }
//
// class GradientCircularProgressPainter extends CustomPainter {
//   GradientCircularProgressPainter({
//     required this.radius,
//     required this.gradientColors,
//     required this.strokeWidth,
//   });
//   final double radius;
//   final List<Color> gradientColors;
//   final double strokeWidth;
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     size = Size.fromRadius(radius);
//     double offset = strokeWidth / 2;
//     Rect rect = Offset(offset, offset) &
//     Size(size.width - strokeWidth, size.height - strokeWidth);
//     var paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = strokeWidth;
//     paint.shader =
//         SweepGradient(colors: gradientColors, startAngle: 0.0, endAngle: 1.8 * pi)
//             .createShader(rect);
//     canvas.drawArc(rect, 0.0, (2 * pi), false, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
