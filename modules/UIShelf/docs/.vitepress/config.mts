import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  head: [['link', { rel: 'icon', href: '/favicon.ico' }]],
  base: "/UIShelf/",
  title: "UIShelf",
  titleTemplate: "Canary Docs",
  description: "Create modern & intuitive topbar icons",
  lastUpdated: true,
  lang: 'en-us',
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      {
        text: 'Guides',
        items: [
          { text: 'Install', link: '/start/installation' },
          { text: 'Usage', link: '/tutorial/uishelf' },
        ]
      },

      { text: 'API', link: '/api/index' },
      { text: 'Changelog', link: '/changelog' }
    ],

    sidebar: {
      '/api': [
        { text: 'UIShelf', link: '/api/index' },
        { text: 'TopBarIconObject', link: '/api/topbarspacerobject' },
        { text: 'TopBarSpacerObject', link: '/api/topbariconobject' },
      ]
    },

    outline: [2, 3],

    search: {
      provider: 'local'
    },

    editLink: {
      pattern: 'https://github.com/canary-development/UIShelf/edit/main/docs/:path'
    },

    footer: {
      message: 'Built with VitePress',
      copyright: 'Copyright © 2021 - 2023 Canary Development'
    },

    socialLinks: [
      { icon: 'github', link: 'https://github.com/canary-development/UIShelf' },
      { icon: 'discord', link: 'https://discord.gg/cwwcZtqJAt' },
    ]
  }
})
