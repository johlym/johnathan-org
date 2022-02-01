import "index.css"

// Import all JavaScript & CSS files from src/_components
const componentsContext = require.context("bridgetownComponents", true, /\.(js|css)$/)
componentsContext.keys().forEach(componentsContext)

// Import Flowbite

import '@themesberg/flowbite';

console.info("Bridgetown is loaded!")
