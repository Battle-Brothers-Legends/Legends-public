this.legend_specialist_hammer_damage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_hammer_damage";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecialistHammerDamage;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecialistHammerDamage;
		this.m.Icon = "ui/perks/pickaxe_01.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() = "weapon.legend_hammer")
		{
			_properties.DamageRegularMin += 5;
			_properties.DamageRegularMax += 15;
		}
	}

});
