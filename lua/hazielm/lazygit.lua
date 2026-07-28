local M = {}

function M.setup()
	vim.keymap.set("n", "<leader>gg", function()
		M.open()
	end, { desc = "Open LazyGit" })
end

function M.open()
	local cwd = vim.fn.getcwd()

	local git_root = vim.fs.root(cwd, ".git")
	if git_root then
		Snacks.lazygit({ cwd = git_root })
		return
	end

	local repos = {}
	local handle = vim.loop.fs_scandir(cwd)
	if handle then
		while true do
			local name, t = vim.loop.fs_scandir_next(handle)
			if not name then
				break
			end
			if t == "directory" then
				local git_path = cwd .. "/" .. name .. "/.git"
				if vim.loop.fs_stat(git_path) then
					table.insert(repos, { name = name, path = cwd .. "/" .. name })
				end
			end
		end
	end

	if #repos == 0 then
		Snacks.lazygit({ cwd = cwd })
	elseif #repos == 1 then
		Snacks.lazygit({ cwd = repos[1].path })
	else
		vim.ui.select(repos, {
			prompt = "Select git repository:",
			format_item = function(repo)
				return repo.name
			end,
		}, function(choice)
			if choice then
				Snacks.lazygit({ cwd = choice.path })
			end
		end)
	end
end

return M
