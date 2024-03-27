local workspace_dir = '/home/aron/projects/ifd'
local root_files = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

capabilities.workspace = {
  configuration = true,
  didChangeWatchedFiles = {
    dynamicRegistration = true
  },
  didChangeConfiguration = {
    dynamicRegistration = true
  }
}

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', "v:lua.vim.lsp.omnifunc")
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  local opts = { noremap = true, silent = true }
  vim.keymap.set('n', '<leader>gh', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<leader>K', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>F', vim.lsp.buf.format, bufopts)
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
end

local jdtls = require('jdtls')

local cmd = {
  'java',
  '-Declipse.application=org.eclipse.jdt.ls.core.id1',
  '-Dosgi.bundles.defaultStartLevel=4',
  '-Declipse.product=org.eclipse.jdt.ls.core.product',
  '-Dlog.protocol=true',
  '-Dlog.level=ALL',
  '-Xms1g',
  '--add-modules=ALL-SYSTEM',
  '--add-opens',
  'java.base/java.util=ALL-UNNAMED',
  '--add-opens',
  'java.base/java.lang=ALL-UNNAMED',
  '-javaagent:/home/aron/.local/share/nvim/lsp_servers/jdtls/lombok.jar',
  '-Xbootclasspath/a:/home/aron/.local/share/nvim/lsp_servers/jdtls/',
  '-jar', '/home/aron/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_1.6.500.v20230622-2056.jar',
  '-configuration', '/home/aron/.local/share/nvim/lsp_servers/jdtls/config_linux',
  '-data', workspace_dir,
}

local settings = {
  java = {
    signatureHelp = { enabled = true },
    contentProvider = { preferred = 'fernflower' },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*"
      },
      filteredTypes = {
        "com.sun.*",
        "io.micrometer.shaded.*",
        "java.awt.*",
        "jdk.*",
        "sun.*",
      },
    },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    configuration = {
      runtimes = {
        {
          name = "JavaSE-11",
          path = "/usr/lib/jvm/java-11-openjdk-amd64/",
        },
        -- {
        --   name = "JavaSE-17",
        --   path = "/usr/lib/jvm/java-17-openjdk-amd64/",
        -- },
        -- {
        --   name = "JavaSE-20",
        --   path = "/home/aron/.sdkman/candidates/java/20.0.1-zulu",
        -- },
      }
    },
    eclipse = {
      downloadSources = true,
    },
    maven = {
      downloadSources = true,
    },
  },
  sources = {
    organizeImports = {
      starThreshold = 9999,
      staticStarThreshold = 9999,
    }
  }
}

jdtls.start_or_attach({
  flags = {
    allow_incremental_sync = true
  },
  cmd = cmd,
  settings = settings,
  on_attach = on_attach,
  root_dir = jdtls.setup.find_root(root_files),
})

