import 'package:cached_network_image/cached_network_image.dart';
import 'package:uol_student/data/models/subject.dart';
import 'package:uol_student/ui/widgets/subjectFirstLetterContainer.dart';
import 'package:uol_student/utils/animationConfiguration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

class SubjectImageContainer extends StatelessWidget {
  final Subject subject;
  final double height;
  final double width;
  final double radius;
  final BoxBorder? border;
  final bool showShadow;
  final bool animate;
  const SubjectImageContainer({
    Key? key,
    this.border,
    required this.showShadow,
    required this.height,
    required this.radius,
    required this.subject,
    required this.width,
    this.animate = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: animate ? customItemFadeAppearanceEffects() : null,
      child: Container(
        decoration: BoxDecoration(
          border: border,
          image: (subject.image ?? "" ).isEmpty || subject.hasSvgImage()
              ? null
              : DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(subject.image ?? ""),
                ),
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(radius),
        ),
        height: height,
        width: width,
        child: (subject.image ?? "").isEmpty
            ? SubjectCodeContainer(
              subjectCode: subject.code ?? "",
              )
            : subject.hasSvgImage()
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * (0.25),
                      vertical: height * 0.25,
                    ),
                    child: SvgPicture.network(subject.image ??""),
                  )
                : const SizedBox(),
      ),
    );
  }
}
