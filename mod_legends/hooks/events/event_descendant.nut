::mods_hookDescendants("events/event", function (o) {
	local onUpdateScore = ::mods_getMember(o, "onUpdateScore");
	::mods_override(o, "onUpdateScore", function() {
		// patch roster method
		local roster = ::World.getPlayerRoster();
		local original_getAll = roster.getAll;
		roster.getAll = @() original_getAll().filter(@ (_, bro) ::Legends.S.humansOnly(bro));
		onUpdateScore();
		roster.getAll = original_getAll;
	});
});
