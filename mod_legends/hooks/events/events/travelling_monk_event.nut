::mods_hookExactClass("events/events/travelling_monk_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		::Legends.Screens.hook(this, "E", function(_screen) {
			_screen.List.push({
				id = 10,
				icon = "ui/icons/asset_moral_reputation.png",
				text = "The company\'s moral reputation decreases"
			});
		});
	}
})
