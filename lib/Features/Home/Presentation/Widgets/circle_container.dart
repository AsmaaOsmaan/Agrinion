part of 'home_imports.dart';

class CircleContainer extends StatelessWidget {
  final double size;
  final String icon;
  final Color color;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const CircleContainer({
    Key? key,
    this.size = 55,
    required this.icon,
    this.color = Colors.blueAccent,
    this.margin = const EdgeInsets.only(left: 8),
    this.padding = const EdgeInsets.all(0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      height: size,
      width: size,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        icon,
        height: 27,
        width: 27,
        fit: BoxFit.cover,
        color: color != ColorManager.white ? Colors.white : Colors.black,
      ),
    );
  }
}

class StoryContainer extends StatelessWidget {
  final double size;
  final Widget? widget;
  final Color color;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const StoryContainer({
    Key? key,
    this.size = 55,
    this.widget,
    this.color = Colors.blueAccent,
    this.margin = const EdgeInsets.only(left: 8),
    this.padding = const EdgeInsets.all(0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      height: size,
      width: size,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: widget,
    );
  }
}
