this.perk_legend_specialist_shortbow_damage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_shortbow_damage";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecialistShortbowDamage;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecialistShortbowDamage;
		this.m.Icon = "ui/perks/shortbow_01.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (item.getID() == "weapon.short_bow")
		{
			_properties.DamageRegularMin += 10;
			_properties.DamageRegularMax += 20;
		}
	}

});
