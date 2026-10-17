this.legend_safeguarding_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendSafeguarding);
		this.m.Description = "This character neglects their own defense while safeguarding an ally.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/block.png",
				text = "Block is reduced to [color=%negative%]0[/color]"
			}
		]);
		return tooltip;
	}

	function onUpdate(_properties) {
		_properties.Block = 0;
	}

	function onTurnStart() {
		this.removeSelf();
	}

	function onAdded() {
		local item = this.m.Container.getActor().getItems().getItemAtSlot(::Const.ItemSlot.Offhand);

		if (item != null && item.isItemType(::Const.Items.ItemType.Shield)) {
			item.onShieldUp();
		}
	}

	function onRemoved() {
		local item = this.m.Container.getActor().getItems().getItemAtSlot(::Const.ItemSlot.Offhand);

		if (item != null && item.isItemType(::Const.Items.ItemType.Shield)) {
			item.onShieldDown();
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%negative%]0[/color] " + ::Legends.S.inlineIcon("block");
	}
});
