const fs = require("fs");
const path = require("path");

const folderPath = "../languages";
const csvFilePath = "output.csv";
const languages = ["en", "ar", "fr"];
const headers = ["key", "description EN", "description AR", "description FR"];

// Helper function to escape commas and quotes in values
function escapeValue(value) {
  return `"${value.replace(/"/g, '""')}"`;
}

// Read all JSON files in the folder
const data = languages.reduce((acc, lang) => {
  const filePath = path.join(folderPath, `${lang}.json`);
  const fileData = JSON.parse(fs.readFileSync(filePath));
  Object.entries(fileData).forEach(([key, value]) => {
    if (!acc[key]) {
      acc[key] = { key };
    }
    acc[key][`description ${lang.toUpperCase()}`] = escapeValue(value);
  });
  return acc;
}, {});

// Write to CSV file
const rows = Object.values(data);
const csvData = [
  headers,
  ...rows.map((row) => headers.map((header) => row[header])),
]
  .map((row) => row.join(";"))
  .join("\n");

fs.writeFileSync(csvFilePath, csvData);

console.log("CSV file written successfully!");
