import "index.scss"

// Import all JavaScript files from src/_components
const componentsContext = require.context("bridgetownComponents", true, /\.(js)$/)
componentsContext.keys().forEach(componentsContext)


console.info("Bridgetown is loaded!")
