this.perk_legend_barrage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_barrage";
		this.m.Name = this.Const.Strings.PerkName.LegendBarrage;
		this.m.Description = this.Const.Strings.PerkDescription.LegendBarrage;
		this.m.Icon = "ui/perks/catapult_circle.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate(_properties)
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (item != null && item.isWeaponType(this.Const.Items.WeaponType.Sling))
		{
			_properties.HitChanceAdditionalWithEachTile += 2;
		}
	}
});
