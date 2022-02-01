module.exports = {
  content: [
    './src/**/*.{html,md,liquid,erb,serb}',
    './frontend/javascript/**/*.js',
    './node_modules/@themesberg/flowbite/**/*.js'
  ],
  theme: {
    extend: {},
  },
  plugins: [
    require('@themesberg/flowbite/plugin')
  ],
  darkMode: 'media'
}
