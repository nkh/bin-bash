ffmpeg -i video_file -ab 56k -ar 22050 -r 15 -s 480x360 -strict experimental -vf "transpose=2"  result_file


