vim.snippet.add(
	"img",
	[[
![${1:title}](${2:image})$0
	]],
	{ buffer = 0 }
)
