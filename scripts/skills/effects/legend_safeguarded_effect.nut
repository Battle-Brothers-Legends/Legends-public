this.legend_safeguarded_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Block = 0,
		TurnsLeft = 1
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendSafeguarded);
		this.m.Description = "This character is covered by an ally's shield.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/block.png",
				text = "Gain [color=%positive%]%_block%[/color] Block",
				param = [
					["_block", this.m.Block]
				]
			}
		]);
		return tooltip;
	}

	function onUpdate(_properties) {
		_properties.Block += this.m.Block;
	}

	function onTurnStart() {
		this.removeSelf();
	}

	function onRemoved() {
		this.m.Block = 0;
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+" + this.m.Block + "%[/color] " + ::Legends.S.inlineIcon("block");
	}
});
