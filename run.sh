#!/bin/bash

docker run --rm --name mjpeg-streamer --hostname mjpeg-streamer --tty --privileged  $@ rpavlyuk/mjpeg-streamer
