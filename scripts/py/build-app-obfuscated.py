#!/usr/bin/python
import os

build_type = input("Please choose the build type [dev, staging, prod]: ")

if build_type == "dev":
    main_file = "lib/main_dev.dart"
    flavor = "dev"
elif build_type == "staging":
    main_file = "lib/main_staging.dart"
    flavor = "staging"
elif build_type == "prod":
    main_file = "lib/main_prod.dart"
    flavor = "prod"
else:
    print("Invalid build type selected. Please choose either 'dev', 'staging', or 'prod'.")
    exit(1)

cmd = f"flutter clean && flutter pub get && flutter build apk --target {main_file} --flavor {flavor} --release --obfuscate --split-debug-info=build/app/outputs/symbol"
os.system(cmd)
