local home_dir = os.getenv("HOME")

return {
	cmd = {
		"jdtls",
		"-data",
		home_dir .. "/Development/Mines/SoftwareEngineering-CSCI306/",
	},
	settings = {
		signatureHelp = { enabled = true },
		import = { enabled = true },
		rename = { enabled = true },
	},
}
