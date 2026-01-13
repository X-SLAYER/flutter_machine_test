const fs = require("fs");
const path = require("path");

const savePath = path.join(__dirname, "../lib/constant/assets.dart");

function generateDartFile(assets) {
  let content = "class Assets {\n  Assets._();\n\n";
  for (const [assetName, assetPath] of Object.entries(assets)) {
    const propertyName = camalize(assetName); // Use camalize here
    content += `  static const ${propertyName} = '${assetPath}';\n`;
  }
  content += "}";

  fs.writeFileSync(savePath, content);
}

const camalize = function camalize(str) {
  return str
    .toLowerCase()
    .replace(/[^a-zA-Z0-9]+(.)/g, (m, chr) => chr.toUpperCase());
};

function scanAssetsFolder(folder, assetObject = {}) {
  const files = fs.readdirSync(folder);
  files.forEach((file) => {
    const filePath = path.join(folder, file);
    if (fs.statSync(filePath).isDirectory()) {
      scanAssetsFolder(filePath, assetObject);
    } else {
      const assetName = path.basename(file, path.extname(file)).trim();
      const assetPath = path
        .relative(__dirname, filePath)
        .replace(/\\/g, "/")
        .replace("../", ""); // Remove ../ part
      assetObject[assetName] = assetPath; // Keep original asset name here
    }
  });
  return assetObject;
}

const assets = scanAssetsFolder(path.join(__dirname, "../assets"));
generateDartFile(assets);
console.log(`assets.dart generated successfully 🥰\nSaved to: ${savePath}`);
