module.exports = {
  content: [
    './app/components/**/*.{erb,html}',
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
  extend: {
    keyframes: {
      fade: { 
        '0%, 100%': { opacity: 0 },
        '5%, 60%': { opacity: 1},
    },
  },
    animation: {
      fade: 'fade 4s ease-in-out both'
    },
  },
},
plugins: [

],
}