local capabilities = require("SingularisArt.lsp.handlers").capabilities()
local jdtls = require("jdtls")

-- Determine OS
local home = os.getenv("HOME")
if vim.fn.has("mac") == 1 then
  WORKSPACE_PATH = home .. "/.config/workspace/"
  CONFIG = "mac"
elseif vim.fn.has("unix") == 1 then
  WORKSPACE_PATH = home .. "/.config/workspace/"
  CONFIG = "linux"
else
  print("Unsupported system")
end

-- Find root of project
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
  return
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local workspace_dir = WORKSPACE_PATH .. project_name

local bundles = {}
local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. "packages/java-test/extension/server/*.jar"), "\n"))
vim.list_extend(
  bundles,
  vim.split(
    vim.fn.glob(mason_path .. "packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"),
    "\n"
  )
)

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration",
    home .. "/.local/share/nvim/mason/packages/jdtls/config_" .. CONFIG,
    "-data",
    workspace_dir,
  },

  on_attach = require("SingularisArt.lsp.handlers").on_attach,
  capabilities = capabilities,
  root_dir = root_dir,
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = "all",
        },
      },
      format = {
        enabled = false,
      },
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
    },
    contentProvider = { preferred = "fernflower" },
    extendedClientCapabilities = extendedClientCapabilities,
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
  },

  flags = {
    allow_incremental_sync = true,
  },

  init_options = {
    bundles = bundles,
  },
}

config["on_attach"] = function(client, bufnr)
  local _, _ = pcall(vim.lsp.codelens.refresh)
  require("jdtls.dap").setup_dap_main_class_configs()
  require("jdtls").setup_dap({ hotcodereplace = "auto" })
  require("lvim.lsp").on_attach(client, bufnr)
end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.java" },
  callback = function()
    local _, _ = pcall(vim.lsp.codelens.refresh)
  end,
})

jdtls.start_or_attach(config)

vim.cmd(
  [[command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)]]
)

local which_key = require("which-key")
local options = _G.which_key.opts
local voptions = _G.which_key.vopts

options = vim.tbl_deep_extend("force", {
  filetype = "java",
  buffer = vim.api.nvim_get_current_buf(),
}, options)
voptions = vim.tbl_deep_extend("force", {
  filetype = "java",
  buffer = vim.api.nvim_get_current_buf(),
}, voptions)

which_key.register({
  ["L"] = {
    name = "Language",
    o = { "<cmd>lua require('jdtls').organize_imports()<cr>", "Organize Imports" },
    v = { "<cmd>lua require('jdtls').extract_variable()<cr>", "Extract Variable" },
    c = { "<cmd>lua require('jdtls').extract_constant()<cr>", "Extract Constant" },
    t = { "<cmd>lua require('jdtls').test_nearest_method()<cr>", "Test Method" },
    T = { "<cmd>lua require('jdtls').test_class()<cr>", "Test Class" },
    u = { "<cmd>JdtUpdateConfig<cr>", "Update Config" },
  },
}, options)

which_key.register({
  ["L"] = {
    name = "Language",
    v = { "<esc><cmd>lua require('jdtls').extract_variable(true)<cr>", "Extract Variable" },
    c = { "<esc><cmd>lua require('jdtls').extract_constant(true)<cr>", "Extract Constant" },
    m = { "<esc><cmd>lua require('jdtls').extract_method(true)<cr>", "Extract Method" },
  },
}, voptions)
