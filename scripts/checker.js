const fs = require("fs");
const path = require("path");

// Read the en.json file
const enJsonPath = path.join(__dirname, "../languages", "fr.json");
const enJsonContent = fs.readFileSync(enJsonPath, "utf8");
const enJson = JSON.parse(enJsonContent);

// Collect all keys used in .dart files
const dartKeys = new Set();
const traverseDartFiles = (dir) => {
  const files = fs.readdirSync(dir);
  for (const file of files) {
    const filePath = path.join(dir, file);
    const stats = fs.statSync(filePath);
    if (stats.isDirectory() && filePath !== path.join(__dirname, "lib")) {
      traverseDartFiles(filePath);
    } else if (stats.isFile() && path.extname(file) === ".dart") {
      const fileContent = fs.readFileSync(filePath, "utf8");
      const keyRegex = /['"]([\w-]+)['"]/g;
      let match;
      while ((match = keyRegex.exec(fileContent))) {
        dartKeys.add(match[1]);
      }
    }
  }
};
traverseDartFiles(path.join(__dirname, "../lib"));

// Find unused keys in en.json
const unusedKeys = [];
for (const key of Object.keys(enJson)) {
  if (!dartKeys.has(key)) {
    unusedKeys.push(key);
  }
}

// Print the unused keys
console.log("Unused keys in en.json:");
console.log(unusedKeys.join("\n"));
