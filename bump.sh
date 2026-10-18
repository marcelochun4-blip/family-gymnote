#!/bin/sh
# 배포 전 실행: 앱 버전과 version.json, 서비스워커 캐시 이름을 함께 올림
set -e
V="$(date +%Y.%m.%d-%H%M)"
sed -i "s/const APP_VER='[^']*'/const APP_VER='$V'/" index.html
printf '{"v":"%s"}\n' "$V" > version.json
sed -i "s/const V='[^']*'/const V='gn-$V'/" sw.js
echo "$V"
