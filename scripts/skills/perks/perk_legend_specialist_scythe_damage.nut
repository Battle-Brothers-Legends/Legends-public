this.perk_legend_specialist_scythe_damage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_scythe_damage";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecialistScytheDamage;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecialistScytheDamage;
		this.m.Icon = "ui/perks/scythe_02.png";
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
		if (item != null && item.getID() == "weapon.legend_grisly_scythe")
		{
			_properties.DamageRegularMin += 10;
			_properties.DamageRegularMax += 15;
		}
		if (item != null && item.getID() == "weapon.legend_scythe")
		{
			_properties.DamageRegularMin += 10;
			_properties.DamageRegularMax += 15;
		}
	}

});
