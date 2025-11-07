local json_schemas = require("schemastore").json.schemas()
local yaml_schemas = {}
vim.tbl_map(function(schema)
  yaml_schemas[schema.url] = schema.fileMatch
end, json_schemas)

return {
  settings = {
    yamlls = {
      schemas = yaml_schemas,
      kubernetes = "/*.yaml",
      -- Add the schema for gitlab piplines
      -- ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*.gitlab-ci.yml",
    },
  },
  install = true,
}
