return {
	["n"] = { "NORMAL", "StLineNormalMode" },
	["no"] = { "NORMAL (no)", "StLineNormalMode" },
	["nov"] = { "NORMAL (nov)", "StLineNormalMode" },
	["noV"] = { "NORMAL (noV)", "StLineNormalMode" },
	["noCTRL-V"] = { "NORMAL", "StLineNormalMode" },
	["niI"] = { "NORMAL i", "StLineNormalMode" },
	["niR"] = { "NORMAL r", "StLineNormalMode" },
	["niV"] = { "NORMAL v", "StLineNormalMode" },
	["nt"] = { "NTERMINAL", "StLineNTerminalMode" },
	["ntT"] = { "NTERMINAL (ntT)", "StLineNTerminalMode" },

	["v"] = { "VISUAL", "StLineVisualMode" },
	["vs"] = { "V-CHAR (Ctrl O)", "StLineVisualMode" },
	["V"] = { "V-LINE", "StLineVisualMode" },
	["Vs"] = { "V-LINE", "StLineVisualMode" },
	[""] = { "V-BLOCK", "StLineVisualMode" },

	["i"] = { "INSERT", "StLineInsertMode" },
	["ic"] = { "INSERT (completion)", "StLineInsertMode" },
	["ix"] = { "INSERT completion", "StLineInsertMode" },

	["t"] = { "TERMINAL", "StLineTerminalMode" },

	["R"] = { "REPLACE", "StLineReplaceMode" },
	["Rc"] = { "REPLACE (Rc)", "StLineReplaceMode" },
	["Rx"] = { "REPLACEa (Rx)", "StLineReplaceMode" },
	["Rv"] = { "V-REPLACE", "StLineReplaceMode" },
	["Rvc"] = { "V-REPLACE (Rvc)", "StLineReplaceMode" },
	["Rvx"] = { "V-REPLACE (Rvx)", "StLineReplaceMode" },

	["s"] = { "SELECT", "StLineSelectMode" },
	["S"] = { "S-LINE", "StLineSelectMode" },
	[""] = { "S-BLOCK", "StLineSelectMode" },
	["c"] = { "COMMAND", "StLineCommandMode" },
	["cv"] = { "COMMAND", "StLineCommandMode" },
	["ce"] = { "COMMAND", "StLineCommandMode" },
	["r"] = { "PROMPT", "StLineConfirmMode" },
	["rm"] = { "MORE", "StLineConfirmMode" },
	["r?"] = { "CONFIRM", "StLineConfirmMode" },
	["x"] = { "CONFIRM", "StLineConfirmMode" },
	["!"] = { "SHELL", "StLineTerminalMode" },
}

