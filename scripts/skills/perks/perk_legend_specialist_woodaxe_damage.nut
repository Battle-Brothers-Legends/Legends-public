this.legend_specialist_woodaxe_damage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_woodaxe_damage";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecialistWoodaxeDamage;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecialistWoodaxeDamage;
		this.m.Icon = "ui/perks/woodaxe_01.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() = "weapon.woodcutters_axe")
		{
			_properties.DamageRegularMin += 10;
			_properties.DamageRegularMax += 20;
		}
	}

});
