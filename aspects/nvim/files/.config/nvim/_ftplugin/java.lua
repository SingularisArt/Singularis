local handlers = require("plugins.lsp.handlers")
local jdtls = require("jdtls")

local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_nvim_lsp.default_capabilities()

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- Determine OS
local home = os.getenv("HOME")
WORKSPACE_PATH = home .. "/.config/workspace/"
if vim.fn.has("mac") == 1 then
  CONFIG = "mac"
elseif vim.fn.has("unix") == 1 then
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

local HOME = os.getenv "HOME"
local XML_DIR_LOC = HOME .. "/.local/share/nvim"

-- Make sure to run the ./setup-java-development.sh file found in ~/.config/nvim
-- to install all the required files/folders and place them in the correct
-- location.
local config = {
  flags = {
    debounce_text_changes = 80,
  },
  on_attach = handlers.on_attach,
  root_dir = root_dir,
  settings = {
    java = {
      format = {
        settings = {
          url = XML_DIR_LOC .. "/eclipse-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
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
          "jdk.*", "sun.*",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999;
          staticStarThreshold = 9999;
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
        },
        hashCodeEquals = {
          useJava7Objects = true,
        },
        useBlocks = true,
      },
    }
  },
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
}

config["on_attach"] = function(client, bufnr)
  local _, _ = pcall(vim.lsp.codelens.refresh)
  require("jdtls.dap").setup_dap_main_class_configs()
  require("jdtls").setup_dap({ hotcodereplace = "auto" })
  handlers.on_attach(client, bufnr)
end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.java" },
  callback = function()
    local _, _ = pcall(vim.lsp.codelens.refresh)
  end,
})

jdtls.start_or_attach(config)

require("jdtls.setup").add_commands()

-- local dap = require("dap")
-- dap.configurations.java = {
--   {
--     type = "java";
--     request = "attach";
--     repl_lang = "java",
--     name = "Debug (Attach) - Remote";
--     hostName = "127.0.0.1";
--     port = 5005;
--   },
-- }

local which_key = require("which-key")
local options = require("config.global").which_key_vars.options
local voptions = require("config.global").which_key_vars.voptions

options = vim.tbl_deep_extend("force", {
  filetype = "java",
  buffer = vim.api.nvim_get_current_buf(),
}, options)
voptions = vim.tbl_deep_extend("force", {
  filetype = "java",
  buffer = vim.api.nvim_get_current_buf(),
}, voptions)

which_key.add({
  { "<Leader>L", group = "Language" },
  { "<Leader>Lo", "<cmd>lua require('jdtls').organize_imports()<cr>", desc = "Organize Imports" },
  { "<Leader>Lv", "<cmd>lua require('jdtls').extract_variable()<cr>", desc = "Extract Variable" },
  { "<Leader>Lc", "<cmd>lua require('jdtls').extract_constant()<cr>", desc = "Extract Constant" },
  { "<Leader>Lm", "<cmd>lua require('jdtls').extract_method()<cr>", desc = "Extract Method" },
  { "<Leader>Lt", "<cmd>lua require('jdtls').test_class()<cr>", desc = "Test Class" },
  { "<Leader>Ln", "<cmd>lua require('jdtls').test_nearest_method()<cr>", desc = "Test Nearest Method" },
  { "<Leader>Lu", "<CMD>JdtUpdateConfig<CR>", desc = "Update Config" },
  { "<Leader>Ld", "<CMD>JdtRefreshDebugConfigs<CR>", desc = "Refresh debug config" },
  { "<Leader>Le", "<CMD>Jaq<CR>", desc = "Execute Java" },
  { "<Leader>Lr", "<CMD>JdtWipeDataAndRestart<CR>", desc = "Wipe project data and Restart server" },
  { "<Leader>Lx", "<CMD>JdtRestart<CR>", desc = "Restart server" },
  { "<Leader>Ls", "<CMD>JdtSetRuntime<CR>", desc = "Set runtime" },
}, options)

which_key.add({
  { "<Leader>L", group = "Language" },
  { "<Leader>Lv", "<cmd>lua require('jdtls').extract_variable(true)<cr>", desc = "Extract Variable" },
  { "<Leader>Lc", "<cmd>lua require('jdtls').extract_constant(true)<cr>", desc = "Extract Constant" },
  { "<Leader>Lm", "<cmd>lua require('jdtls').extract_method(true)<cr>", desc = "Extract Method" },
}, voptions)
