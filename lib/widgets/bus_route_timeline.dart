//========================================//
//                WARNING!                //
//       🍝 SPAGHETTI CODE AHEAD! 🍝      //
//========================================//

import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:busfinder/routes/bus_stop_timetable_route.dart';

enum NodeStyle {
  standard,
  branchSplit,
  branchDeadEnd,
  branchMerge,
  branchHeadStart,
  branchHeadSingle,
  branchSplitAndMerge,
  branchMiddle,
  branchTailEnd,
}

class TimelineNode {
  final String stopName;
  final String stopId;
  final NodeStyle style;
  final bool maintainStandardLine;

  TimelineNode({
    required this.stopName,
    required this.stopId,
    required this.style,
    this.maintainStandardLine = true,
  });
}

class BusRouteTimeline extends StatefulWidget {
  final List<RouteVariantResponseDto> variants;
  final List<RouteVariantResponseDto> allVariants;
  final List<BusStopResponseDto> busStops;
  final List<ScheduleResponseDto> schedules;
  final String busRouteId;

  const BusRouteTimeline({
    super.key,
    required this.variants,
    required this.allVariants,
    required this.busStops,
    required this.schedules,
    required this.busRouteId,
  });

  @override
  State<BusRouteTimeline> createState() => _BusRouteTimelineState();
}

class _BusRouteTimelineState extends State<BusRouteTimeline> {
  List<TimelineNode> _nodes = [];

  @override
  void initState() {
    super.initState();
    _processNodes();
  }

  @override
  void didUpdateWidget(covariant BusRouteTimeline oldWidget) {
    super.didUpdateWidget(oldWidget);
    _processNodes();
  }

  void _processNodes() {
    setState(() {
      _nodes = TimelineBuilder.buildViewNodes(widget.variants, widget.busStops);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.surface,
      child: ListView.builder(
        itemCount: _nodes.length,
        itemBuilder: (context, index) {
          final node = _nodes[index];
          final isLast = index == _nodes.length - 1;

          return InkWell(
            onTap: () => context.push(
              '/timetable',
              extra: BusStopTimetableArguments(
                schedules: widget.schedules,
                busStopName: node.stopName,
                busStopId: node.stopId,
                busRouteId: widget.busRouteId,
                variants: widget.allVariants,
              ),
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: 60,
                    child: CustomPaint(
                      painter: RouteLinePainter(
                        style: node.style,
                        isLast: isLast,
                        maintainStandardLine: node.maintainStandardLine,
                        nodeColor: theme.colorScheme.onSurface,
                        backgroundColor: theme.colorScheme.surface,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          node.stopName,
                          style: TextStyle(
                            color: theme.colorScheme.onSurface,
                            fontSize: 14,
                            fontWeight: node.style == NodeStyle.standard
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class RouteLinePainter extends CustomPainter {
  final NodeStyle style;
  final bool isLast;
  final bool maintainStandardLine;
  final Color nodeColor;
  final Color backgroundColor;

  static const double mainX = 24.0;
  static const double branchX = 48.0;
  static const double dotRadius = 5.0;

  RouteLinePainter({
    required this.style,
    required this.isLast,
    required this.maintainStandardLine,
    required this.nodeColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerY = size.height / 2;

    final paintMain = Paint()
      ..color = nodeColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final paintBranch = Paint()
      ..color = nodeColor.withAlpha(97)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    if (maintainStandardLine) {
      double bottomY = size.height;
      if (isLast) bottomY = centerY;
      canvas.drawLine(Offset(mainX, 0), Offset(mainX, bottomY), paintMain);
    }

    if (style != NodeStyle.standard) {
      double topY = 0;
      double bottomY = size.height;

      if (style == NodeStyle.branchMerge ||
          style == NodeStyle.branchMiddle ||
          style == NodeStyle.branchTailEnd) {
      } else {
        topY = centerY;
      }

      if (style == NodeStyle.branchMerge ||
          style == NodeStyle.branchSplitAndMerge ||
          style == NodeStyle.branchDeadEnd ||
          style == NodeStyle.branchTailEnd ||
          style == NodeStyle.branchHeadSingle) {
        bottomY = centerY;
      }

      if (bottomY > topY) {
        canvas.drawLine(
          Offset(branchX, topY),
          Offset(branchX, bottomY),
          paintBranch,
        );
      }
    }

    if (style == NodeStyle.branchSplit ||
        style == NodeStyle.branchSplitAndMerge ||
        style == NodeStyle.branchDeadEnd) {
      final path = Path();
      path.moveTo(mainX, 0);
      path.cubicTo(
        mainX,
        centerY * 0.5,
        branchX,
        centerY * 0.5,
        branchX,
        centerY,
      );
      canvas.drawPath(path, paintBranch);
    }

    if (style == NodeStyle.branchMerge ||
        style == NodeStyle.branchSplitAndMerge ||
        style == NodeStyle.branchHeadSingle) {
      final path = Path();
      path.moveTo(branchX, centerY);
      path.cubicTo(
        branchX,
        centerY + (size.height / 2) * 0.5,
        mainX,
        centerY + (size.height / 2) * 0.5,
        mainX,
        size.height,
      );
      canvas.drawPath(path, paintBranch);
    }

    double dotX = (style == NodeStyle.standard) ? mainX : branchX;

    Paint dotStrokeInfo = (style == NodeStyle.standard)
        ? (Paint()
            ..color = nodeColor
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.5)
        : (Paint()
            ..color = nodeColor.withAlpha(97)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.5);

    Paint maskPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(dotX, centerY), dotRadius, maskPaint);
    canvas.drawCircle(Offset(dotX, centerY), dotRadius, dotStrokeInfo);
  }

  @override
  bool shouldRepaint(RouteLinePainter oldDelegate) => true;
}

class TimelineBuilder {
  static List<TimelineNode> buildViewNodes(
    List<RouteVariantResponseDto> variants,
    List<BusStopResponseDto> busStops,
  ) {
    final stopMap = {for (var s in busStops) s.id: s.name};
    List<TimelineNode> result = [];

    final standardVariant = variants.firstWhere(
      (v) => v.standard,
      orElse: () => variants.first,
    );

    final otherVariants = variants.where((v) => !v.standard).toList();
    final standardIds = standardVariant.busStops;

    if (otherVariants.isEmpty) {
      return standardIds
          .map(
            (id) => TimelineNode(
              stopName: stopMap[id] ?? '',
              stopId: id,
              style: NodeStyle.standard,
            ),
          )
          .toList();
    }

    Set<String> processedStops = {};

    for (int i = 0; i < standardIds.length; i++) {
      final stdStopId = standardIds[i];

      for (final variant in otherVariants) {
        final branchIds = variant.busStops;
        int idxInBranch = branchIds.indexOf(stdStopId);

        if (idxInBranch != -1 && idxInBranch > 0) {
          String prevBranchStop = branchIds[idxInBranch - 1];
          String prevStdStop = (i > 0) ? standardIds[i - 1] : "";

          if (prevBranchStop != prevStdStop) {
            List<String> headStops = [];
            int k = idxInBranch - 1;
            while (k >= 0) {
              String candidate = branchIds[k];
              if (standardIds.contains(candidate)) break;
              headStops.insert(0, candidate);
              k--;
            }

            for (int h = 0; h < headStops.length; h++) {
              if (!processedStops.contains(headStops[h])) {
                NodeStyle style = NodeStyle.branchMiddle;
                if (headStops.length == 1) {
                  style = NodeStyle.branchHeadSingle;
                } else {
                  if (h == 0) {
                    style = NodeStyle.branchHeadStart;
                  } else if (h == headStops.length - 1) {
                    style = NodeStyle.branchMerge;
                  }
                }

                result.add(
                  TimelineNode(
                    stopName: stopMap[headStops[h]] ?? '',
                    stopId: headStops[h],
                    style: style,
                    maintainStandardLine: i > 0,
                  ),
                );
                processedStops.add(headStops[h]);
              }
            }
          }
        }
      }

      for (final variant in otherVariants) {
        final index = variant.busStops.indexOf(stdStopId);
        if (index == variant.busStops.length - 1 &&
            i != standardIds.length - 1) {
          result.add(
            TimelineNode(
              stopName: stopMap[stdStopId] ?? '',
              stopId: stdStopId,
              style: NodeStyle.branchDeadEnd,
            ),
          );
        }
      }

      result.add(
        TimelineNode(
          stopName: stopMap[stdStopId] ?? '',
          stopId: stdStopId,
          style: NodeStyle.standard,
        ),
      );
      processedStops.add(stdStopId);

      for (final variant in otherVariants) {
        final index = variant.busStops.indexOf(stdStopId);
        if (index == 0 && i != index) {
          result.add(
            TimelineNode(
              stopName: stopMap[stdStopId] ?? '',
              stopId: stdStopId,
              style: NodeStyle.branchHeadSingle,
            ),
          );
        }
      }

      for (final variant in otherVariants) {
        final branchIds = variant.busStops;
        int idxInBranch = branchIds.indexOf(stdStopId);

        if (idxInBranch != -1 && idxInBranch < branchIds.length - 1) {
          String nextBranchStop = branchIds[idxInBranch + 1];
          String nextStdStop = (i < standardIds.length - 1)
              ? standardIds[i + 1]
              : "";

          if (nextBranchStop != nextStdStop) {
            bool isTail = (i == standardIds.length - 1);
            List<String> detourStops = [];
            int k = idxInBranch + 1;
            bool remerged = false;

            while (k < branchIds.length) {
              String candidate = branchIds[k];
              if (standardIds.contains(candidate)) {
                remerged = true;
                break;
              }
              detourStops.add(candidate);
              k++;
            }

            for (int d = 0; d < detourStops.length; d++) {
              String stopId = detourStops[d];
              if (!processedStops.contains(stopId)) {
                NodeStyle style = NodeStyle.branchMiddle;

                if (remerged) {
                  if (detourStops.length == 1) {
                    style = NodeStyle.branchSplitAndMerge;
                  } else {
                    if (d == 0) {
                      style = NodeStyle.branchSplit;
                    } else if (d == detourStops.length - 1) {
                      style = NodeStyle.branchMerge;
                    }
                  }
                } else {
                  if (detourStops.length == 1) {
                    style = NodeStyle.branchDeadEnd;
                  } else {
                    if (d == 0) {
                      style = NodeStyle.branchSplit;
                    } else if (d == detourStops.length - 1) {
                      style = NodeStyle.branchTailEnd;
                    }
                  }
                }

                result.add(
                  TimelineNode(
                    stopName: stopMap[stopId] ?? '',
                    stopId: stopId,
                    style: style,
                    maintainStandardLine: !isTail,
                  ),
                );
                processedStops.add(stopId);
              }
            }
          }
        }
      }
    }

    return result;
  }
}
