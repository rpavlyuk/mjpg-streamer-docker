#!/bin/bash

# Clean up stale PID files
rm -f /run/systemd/* /run/dbus/*

exec /sbin/init
