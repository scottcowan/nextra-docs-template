const { imageOptimizer } = require('next/dist/server/image-optimizer')

const withNextra = require('nextra')({
  theme: 'nextra-theme-docs',
  themeConfig: './theme.config.tsx'
})

module.exports = withNextra({
  images: {
    unoptimized: true
  },
  trailingSlash: false
})