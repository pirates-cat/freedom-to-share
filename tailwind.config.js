module.exports = {
  future: {
    purgeLayersByDefault: true,
  },
  theme: {
    container: {
      center: true,
    },
    extend: {
      colors: {
        primary: '#ef4347',
        secondary: '#3cb551',
        tertiary: '#4c75ba',
      },
      width: {
        '128': '32rem',
      }
    },
    fontFamily: {
      'body': ['Open Sans', '-apple-system', 'BlinkMacSystemFont', 'avenir next', 'avenir', 'helvetica neue', 'helvetica', 'Ubuntu', 'Oxygen', 'Cantarell', 'segoe ui', 'roboto', 'noto', 'arial', 'sans-serif']
    },
  },
  variants: {},
  plugins: [
    require('@tailwindcss/typography'),
  ],
}
