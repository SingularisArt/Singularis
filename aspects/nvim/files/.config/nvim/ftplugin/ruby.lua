local dap = require("dap")
dap.adapters.ruby = {
  type = "executable";
  command = "bundle";
  args = {"exec", "readapt", "stdio"};
}

dap.configurations.ruby = {
  {
    type = "ruby";
    request = "launch";
    name = "Rails";
    program = "bundle";
    programArgs = {"exec", "rails", "s"};
    useBundler = true;
  },
}
