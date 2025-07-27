function GetEnvsFromEnvFile(path)
	if path == nil or path == "" then
		return error("Could not open .env file")
	end

	local f = io.open(path, "r")
	if not f then return error("Could not open .env file") end

	local env = {}
	for line in f:lines() do
		if not line:match("^%s*[#;]") and not line:match("^%s*$") then
			local key, val = line:match("^%s*([^=]+)%s*=%s*(.-)%s*$")

			if key and val then
				key = key:gsub("^%s+", ""):gsub("%s+$", "")
				val = val:gsub('^"(.*)"$', '%1'):gsub("^'(.*)'$", '%1')
				val = val:gsub("\\n", "\n"):gsub("\\r", "\r"):gsub("\\t", "\t")
				val = val:gsub("\\\\", "\\")
				val = val:gsub("\\\"", "\""):gsub("\\\'", "\'")
				env[key] = val
			end
		end
	end
	f:close()

	return env
end

return {}
