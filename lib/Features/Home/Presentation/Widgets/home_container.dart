part of 'home_imports.dart';

class HomeContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final String title;
  final String icon;
  final String? logo;
  final Function? onTap;
  final bool isSquare;

  const HomeContainer._({
    Key? key,
    this.width,
    this.height,
    this.color,
    required this.title,
    required this.icon,
    this.logo,
    this.onTap,
    required this.isSquare,
  }) : super(key: key);

  const HomeContainer.square({
    Key? key,
    required double? width,
    required double? height,
    Color? color = Colors.lightBlue,
    required String title,
    required String icon,
    String? logo,
    Function? onTap,
  }) : this._(
            title: title,
            color: color,
            width: width,
            height: height,
            icon: icon,
            logo: logo,
            onTap: onTap,
            key: key,
            isSquare: true);

  const HomeContainer.rectangle({
    Key? key,
    required double? width,
    required double? height,
    Color? color = Colors.lightBlue,
    required String title,
    required String icon,
    String? logo,
    required Function onTap,
  }) : this._(
            title: title,
            color: color,
            width: width,
            height: height,
            icon: icon,
            logo: logo,
            onTap: onTap,
            key: key,
            isSquare: false);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap!(),
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      style: getBoldStyle(fontColor: Colors.white, size: 16),
                      maxLines: 2,
                    ),
                  ),
                  // Flexible(
                  //   child: CircleContainer(
                  //     padding: const EdgeInsets.all(8),
                  //     color: Colors.white,
                  //     size: 40,
                  //     icon: icon,
                  //   ),
                  // ),
                ],
              ),
            ),
            isSquare
                ? Flexible(flex: 3, child: Image.asset(logo!))
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
