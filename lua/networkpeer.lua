Hooks:PostHook(NetworkPeer, "mark_cheater", "eclipse_mark_cheater_debug", function()
	Eclipse:log_chat("[DEBUG] You were marked as cheater!\nSend the stacktrace from your log file to a developer and see if you can reproduce this so we can patch this out.")
	log("[ECLIPSE ANTI-CHEAT DEBUG]:\n", debug.traceback(), "\nEND STACKTRACE\n\n")
end)
