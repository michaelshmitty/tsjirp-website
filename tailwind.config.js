defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  content: [
    "./_drafts/**/*.html",
    "./_includes/**/*.html",
    "./_layouts/**/*.html",
    "./_posts/*.md",
    "./*.md",
    "./*.html",
  ],
  theme: {
    extend: {
      backgroundImage: {
        bollen: "url('/tsjirp-website/assets/img/bollen-achtergrond.svg')",
      },
      colors: {
        primary: "#504741",
        "light-brown": "#706760",
      },
      fontFamily: {
        dynapuff: ['"DynaPuff"', defaultTheme.fontFamily.sans],
        sans: ['"Roboto"', defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [],
};
