const fs = require("fs");
const path = require("path");

// define the source and destination directories
const sourceDir = path.join(__dirname, "res");
const destDir = path.join(
  __dirname,
  "..",
  "android",
  "app",
  "src",
  "main",
  "res"
);

// define the subdirectories inside the source directory
const subdirs = [
  "drawable-hdpi",
  "drawable-mdpi",
  "drawable-xhdpi",
  "drawable-xxhdpi",
  "drawable-xxxhdpi",
];
const destdirs = [
  "mipmap-hdpi",
  "mipmap-mdpi",
  "mipmap-xhdpi",
  "mipmap-xxhdpi",
  "mipmap-xxxhdpi",
];

// loop through each subdirectory and copy the files to the destination directory
subdirs.forEach((subdir, index) => {
  const subdirPath = path.join(sourceDir, subdir);
  const destDirPath = path.join(destDir, destdirs[index]);
  const files = fs.readdirSync(subdirPath);
  files.forEach((file) => {
    if (file === "ic_stat_onesignal_default.png") {
      const sourceFilePath = path.join(subdirPath, file);
      const destFilePath = path.join(destDirPath, file);
      fs.copyFileSync(sourceFilePath, destFilePath);
    }
  });
});
console.log("All Files has been copied successfully 🥰");
