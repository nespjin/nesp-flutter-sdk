/*
 * Copyright (c) 2019  NESP Technology Corporation. All rights reserved.
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms and conditions of the GNU General Public License,
 * version 2, as published by the Free Software Foundation.
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License.See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * If you have any questions or if you find a bug,
 * please contact the author by email or ask for Issues.
 *
 * Author:JinZhaolu <1756404649@qq.com>
 */
part of views;

///
///
/// @team NESP Technology
/// @author <a href="mailto:1756404649@qq.com">靳兆鲁 Email:1756404649@qq.com</a>
/// @time: Created 19-4-4 下午4:41
/// @project fish_movie
///*/
///

class _LinePainter extends CustomPainter {
  final Direction direction;
  final Color color;
  final double strokeWidth;
  final double length;
  final bool isFullLength;

  Size screenSize;

  _LinePainter(
    BuildContext context,
    this.direction,
    this.color,
    this.strokeWidth,
    this.length,
    this.isFullLength,
  );

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
//    Paint _paint = Paint()
//      ..color = Colors.blueAccent //画笔颜色
//      ..strokeCap = StrokeCap.round //画笔笔触类型
//      ..isAntiAlias = true //是否启动抗锯齿
//      ..blendMode = BlendMode.exclusion //颜色混合模式
//      ..style = PaintingStyle.fill //绘画风格，默认为填充
//      ..colorFilter = ColorFilter.mode(Colors.blueAccent,
//          BlendMode.exclusion) //颜色渲染模式，一般是矩阵效果来改变的,但是flutter中只能使用颜色混合模式
//      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 3.0) //模糊遮罩效果，flutter中只有这个
//      ..filterQuality = FilterQuality.high //颜色渲染模式的质量
//      ..strokeWidth = 15.0; //画笔的宽度
    Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.butt
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeJoin = StrokeJoin.bevel;

    if (direction == Direction.Horizontal) {
      canvas.drawLine(
          Offset(0, 0), Offset(isFullLength ? window.physicalSize.width : length, 0), paint);
    } else {
       canvas.drawLine(
          Offset(0, 0), Offset(0, isFullLength ? window.physicalSize.height : length), paint);
    }
  }

  @override
  bool shouldRepaint(_LinePainter oldDelegate) => oldDelegate != this;
}

enum Direction { Vertical, Horizontal }

class Line extends StatelessWidget {
  final double length;

  final double strokeWidth;

  final Direction direction;

  final Color color;
  final bool isFullLength;

  const Line(
      {Key key,
      this.length = 20,
      this.strokeWidth,
      this.direction,
      this.color,
      this.isFullLength = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LinePainter(
          context, direction, color, strokeWidth, length, isFullLength),
    );
  }
}
