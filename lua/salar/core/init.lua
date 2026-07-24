require("salar.core.options")
require("salar.core.keymaps")
require("salar.core.godot").setup()
require("salar.tools").setup()

vim.api.nvim_create_user_command("Helpp", function()
	local readme = vim.fn.stdpath("config") .. "/README.md"
	if vim.fn.filereadable(readme) == 1 then
		vim.cmd("view " .. vim.fn.fnameescape(readme))
	else
		vim.notify("README.md not found at " .. readme, vim.log.levels.ERROR)
	end
end, { desc = "Open config README" })
