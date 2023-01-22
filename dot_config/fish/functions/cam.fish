function cam
  mpv --demuxer-lavf-o=video_size=1280x720,input_format=mjpeg av://v4l2:$argv --profile=low-latency
end
