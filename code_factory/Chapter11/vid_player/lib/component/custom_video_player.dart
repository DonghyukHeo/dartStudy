import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vid_player/component/custom_icon_button.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class CustomVideoPlayer extends StatefulWidget {
  // 선택한 동영상을 저장할 변수
  // XFile은 ImagePicker로 영상/이미지를 선택했을 때 반환하는 타입
  final XFile video;

  // 새파일 선택 시
  final GestureTapCallback onNewVideoPressed;

  const CustomVideoPlayer(
      {super.key, required this.video, required this.onNewVideoPressed});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? videoPlayerController; // 동영상 컨트롤러
  bool showControls = false; // 컨트롤러 아이콘을 보여줄지 여부

  //covariant 키워드는 해당 클래스의 상속된 값도 허용을 해준다.
  // didUpdateWidget 함수를 오버라이드 하면 StatefulWidget의 매개변수가 변경되었을 경우 특정 함수를 실행하게 할 수 있다.
  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 새로 선택한 동영상 파일이 동일한 파일인지 체크
    if (oldWidget.video.path != widget.video.path) {
      initializeController();
    }
  }

  // 비디오 컨트롤러는 생성시 한번만 생성되어야 함므로 initState()에 처리
  @override
  void initState() {
    super.initState();

    //동영상 컨트롤러 초기화 처리
    initializeController();
  }

  // 동영상 컨트롤러 초기화
  initializeController() async {
    final videoController = VideoPlayerController.file(File(widget.video.path));

    await videoController.initialize();

    //컨트롤러 속성이 변경될 때마다 실행할 함수 등록
    videoController.addListener(videoControllerListener);

    setState(() {
      this.videoPlayerController = videoController;
    });
  }

  // 동영상의 재생 상태가 변경될 때 마다 setState를 실행해서 build 하도록 처리
  void videoControllerListener() {
    setState(() {});
  }

  @override
  void dispose() {
    videoPlayerController?.removeListener(videoControllerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (videoPlayerController == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // 동영상 비율에 따른 화면 랜더링
    return GestureDetector(
      // 화면 전체의 탭을 인식하기 위해서 사용
      onTap: () {
        setState(() {
          showControls = !showControls;
        });
      },
      child: AspectRatio(
        aspectRatio: videoPlayerController!.value.aspectRatio,
        child: Stack(
          // 비디오 위에 Slider 위젯을 위치 시키기 위해서 Stack을 이용
          children: [
            VideoPlayer(videoPlayerController!),
            if (showControls)
              Container(
                color: Colors.black.withOpacity(0.5),
              ), // 컨트롤러 아이콘이 보일때는 화면을 어둡게 설정
            Positioned(
              //Stack 위젯은 기본적으로 children들을 중앙에 위치 시키므로 Positioned 위젯을 사용하여 위치를 정한다.
              bottom: 0,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    renderTimeTextFromDuration(
                      videoPlayerController!.value.position,
                    ), //동영상 현재 위치 표시
                    Expanded(
                      child: Slider(
                        onChanged: (double val) {
                          videoPlayerController!.seekTo(
                            Duration(seconds: val.toInt()),
                          );
                        },
                        value: videoPlayerController!.value.position.inSeconds
                            .toDouble(), // 동영상 재생 위치를 초 단위로 표시
                        min: 0,
                        max: videoPlayerController!.value.duration.inSeconds
                            .toDouble(),
                      ),
                    ),
                    renderTimeTextFromDuration(
                      videoPlayerController!.value.duration, // 동영상 전체 길이 표시
                    ),
                  ],
                ),
              ),
            ),
            if (showControls)
              Align(
                alignment: Alignment.topRight,
                child: CustomIconButton(
                  onPressed: widget.onNewVideoPressed,
                  iconData: Icons.photo_camera_back,
                ),
              ),
            if (showControls)
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomIconButton(
                      onPressed: onReversePressed,
                      iconData: Icons.rotate_left,
                    ),
                    CustomIconButton(
                      onPressed: onpPlayPressed,
                      iconData: videoPlayerController!.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                    CustomIconButton(
                      onPressed: onForwardPressed,
                      iconData: Icons.rotate_right,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Duration 값을 분:초 형식으로 변환
  Widget renderTimeTextFromDuration(Duration duration) {
    return Text(
      '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  // 되감기 버튼
  void onReversePressed() {
    final currentPosition = videoPlayerController!.value.position; //현재 재생중인 위치

    Duration position = Duration();

    // 현재 재생 위치가 3초 이후 일 경우 3초 앞으로
    if (currentPosition.inSeconds > 3) {
      position = currentPosition - Duration(seconds: 3);
    }

    videoPlayerController!.seekTo(position);
  }

  // 앞으로 버튼
  void onForwardPressed() {
    final maxPosition = videoPlayerController!.value.duration; // 동영상 최대 길이
    final currentPosition = videoPlayerController!.value.position; //현재 재생중인 위치

    Duration position = maxPosition; // 동영상 길이로 실행 위치 초기화

    // 동영상 최대 길이에서 3초 이전 값이 현재 위치보다 큰때만 처리
    if ((maxPosition - Duration(seconds: 3)).inSeconds >
        currentPosition.inSeconds) {
      position = currentPosition + Duration(seconds: 3);
    }

    videoPlayerController!.seekTo(position);
  }

  // 플레이 버튼
  void onpPlayPressed() {
    if (videoPlayerController!.value.isPlaying) {
      videoPlayerController!.pause();
    } else {
      videoPlayerController!.play();
    }
  }
}
