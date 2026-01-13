const fs = require("fs");

const csvFilePath = "translations.csv";
const folderPath = "./translations";
const languages = ["en", "ar", "fr"];

// Helper function to unescape commas and quotes in values
function unescapeValue(value) {
  return value.replace(/""/g, '"');
}

// Read CSV file and create an object with all keys and their translations
const data = {};
const lines = fs
  .readFileSync(csvFilePath, "utf-8")
  .split("\n")
  .filter((line) => line.trim());
const headers = lines.shift().split(";");
lines.forEach((line) => {
  const values = line.split(";");
  console.log(values);
  const key = values.shift();
  data[key] = {};
  console.log(key);
  headers.slice(1).forEach((header, i) => {
    const value = values[i];
    if (value) {
      data[key][languages[i]] = unescapeValue(value);
    }
  });
  // console.log(data);
});

// Write data to JSON files
languages.forEach((lang) => {
  const filePath = `${folderPath}/${lang}.json`;
  const fileData = {};
  Object.entries(data).forEach(([key, translations]) => {
    const value = translations[lang];
    if (value) {
      fileData[key] = value;
    }
  });
  fs.writeFileSync(filePath, JSON.stringify(fileData, null, 2));
});

console.log("JSON files written successfully!");
