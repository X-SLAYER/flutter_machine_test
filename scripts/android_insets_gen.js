const fs = require("fs");
const path = require("path");
const readline = require("readline");

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

rl.question("Enter the inset percentage (e.g., 24%): ", (percentage) => {
  const xmlContent = `<?xml version="1.0" encoding="utf-8"?>
  <adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@color/ic_launcher_background"/>
    <foreground>
      <inset android:drawable="@drawable/ic_launcher_foreground" android:inset="${percentage}%" />
    </foreground>
  </adaptive-icon>`;

  const filePath = path.resolve(
    __dirname,
    "..",
    "android/app/src/main/res/mipmap-anydpi-v26/launcher_icon.xml"
  );

  fs.writeFile(filePath, xmlContent, (err) => {
    if (err) {
      console.error("Error writing file:", err);
    } else {
      console.log("File written successfully:", filePath);
    }
    rl.close();
  });
});