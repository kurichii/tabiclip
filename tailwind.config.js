module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [require("daisyui")],
  daisyui: {
    themes: [
      {
        cupcake: {
          ...require("daisyui/src/theming/themes")["cupcake"],
          "base-content": "#555555",
          "primary-content": "#555555",
          "secondary-content": "#ffffff",
          "accent-content": "#ffffff",
        },
      },
    ],
  }
}
