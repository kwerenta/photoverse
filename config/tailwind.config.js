module.exports = {
  content: [
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.{erb,haml,html,slim}",
    "./app/assets/icons/*.svg",
  ],
  daisyui: {
    themes: [
      {
        dark: {
          primary: "#E2336B",
          secondary: "#FCAC46",
          accent: "#4193EF",
          neutral: "#646464",
          "base-100": "#3C3F51",
          "base-300": "#282A34",
          "base-content": "#FFFFFF",
          info: "#3ABFF8",
          success: "#36D399",
          warning: "#FBBD23",
          error: "#F87272",
        },
      },
    ],
  },
  plugins: [
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/typography"),
    require("daisyui"),
  ],
};
