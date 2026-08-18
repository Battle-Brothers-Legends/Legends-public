this.legend_safeguarding_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create() {
		this.m.ID = "effects.legend_safeguarding";
		this.m.Name = "Safeguarding";
		this.m.Description = "This character neglects their own defense while safeguarding someone else";
		this.m.Icon = "ui/perks/safegaurd_circle.png";
		this.m.IconMini = "mini_safegaurd_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}
	
	function getTooltip() {
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/block.png",
				text = "Block is reduced to [color=%negative%]0[/color]"
			}
		];
	}

	function onUpdate( _properties ) {
		_properties.Block = 0;
	}


	function onTurnStart() {
		this.removeSelf();
	}

	function onAdded() {
		local item = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (item != null && item.isItemType(this.Const.Items.ItemType.Shield)) {
			item.onShieldUp();
		}
	}

	function onRemoved() {
		local item = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (item != null && item.isItemType(this.Const.Items.ItemType.Shield)) {
			item.onShieldDown();
		}
	}

});