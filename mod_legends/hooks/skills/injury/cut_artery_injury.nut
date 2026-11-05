::mods_hookExactClass("skills/injury/cut_artery_injury", function (o) {
	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%negative%]3[/color] " + ::Legends.Text.inlineIcons("damage_received") + " every turn";
	}
});
