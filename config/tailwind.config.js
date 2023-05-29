const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './app/helpers/**/*.rb',
    './app/controllers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim,rb}',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      textColor: {
        skin: {
          inverted: 'rgb(var(--color-inverted) / <alpha-value>)',
          accented: 'rgb(var(--color-accented) / <alpha-value>)',
          'accented-hover': 'rgb(var(--color-accented-hover) / <alpha-value>)',
          base: 'rgb(var(--color-base) / <alpha-value>)',
          muted: 'rgb(var(--color-muted) / <alpha-value>)',
          dimmed: 'rgb(var(--color-dimmed) / <alpha-value>)',
          error: 'rgb(var(--color-error) / <alpha-value>)',
          alternate: 'rgb(var(--color-alternate) / <alpha-value>)',
          'alternate-1': 'rgb(var(--color-alternate-1) / <alpha-value>)',
          'alternate-2': 'rgb(var(--color-alternate-2) / <alpha-value>)'
        }
      },
      textDecorationColor: {
        skin: {
          accented: 'rgb(var(--color-accented) / <alpha-value>)',
        }
      },
      backgroundColor: {
        skin: {
          'button-accented': 'rgb(var(--color-accented) / <alpha-value>)',
          'button-accented-hover': 'rgb(var(--color-accented-hover) / <alpha-value>)',
          'button-inverted': 'rgb(var(--color-inverted) / <alpha-value>)',
          'button-inverted-hover': 'rgb(var(--color-inverted-hover) / <alpha-value>)',
          'button-caution': 'rgb(var(--color-error) / <alpha-value>)',
          'button-caution-hover': 'rgb(var(--color-error-hover) / <alpha-value>)',
          muted: 'rgb(var(--color-muted) / <alpha-value>)',
          dimmed: 'rgb(var(--color-dimmed) / <alpha-value>)',
          error: 'rgb(var(--color-error) / <alpha-value>)',
          accented: 'rgb(var(--color-accented) / <alpha-value>)',
          'accented-hover': 'rgb(var(--color-accented-hover) / <alpha-value>)',
          alternate: 'rgb(var(--color-alternate) / <alpha-value>)',
          'alternate-1': 'rgb(var(--color-alternate-1) / <alpha-value>)',
          'alternate-2': 'rgb(var(--color-alternate-2) / <alpha-value>)'
        }
      },
      ringColor: {
        skin: {
          accented: 'rgb(var(--color-border-accented) / <alpha-value>)',
          inverted: 'rgb(var(--color-inverted) / <alpha-value>)',
          error: 'rgb(var(--color-error) / <alpha-value>)',
        }
      },
      borderColor: {
        skin: {
          base: 'rgb(var(--color-border-base) / <alpha-value>)',
          error: 'rgb(var(--color-error) / <alpha-value>)',
          accented: 'rgb(var(--color-border-accented) / <alpha-value>)',
          alternate: 'rgb(var(--color-alternate) / <alpha-value>)',
          'alternate-1': 'rgb(var(--color-alternate-1) / <alpha-value>)',
          'alternate-2': 'rgb(var(--color-alternate-2) / <alpha-value>)'
        }
      },
      textDecorationColor: {
        skin: {
          accented: 'rgb(var(--color-border-accented) / <alpha-value>)',
          error: 'rgb(var(--color-error) / <alpha-value>)',
        }
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}

