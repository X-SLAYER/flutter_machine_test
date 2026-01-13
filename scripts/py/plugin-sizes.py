import os
cmd = 'flutter build apk --target lib/main_dev.dart --flavor dev --analyze-size --target-platform=android-arm'
os.system(cmd)