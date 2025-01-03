this.perk_legend_specialist_ninetails_damage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendSpecialistNinetailsDamage);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAfterUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local resolve = actor.getCurrentProperties().Bravery;

		if (item != null && item.isItemType(this.Const.Items.ItemType.Cultist))
		{
		  if (item.getID() == "weapon.legend_cat_o_nine_tails")
		  {
			_properties.DamageRegularMin += this.Math.floor(resolve * 0.05);
			_properties.DamageRegularMax += this.Math.floor(resolve * 0.1);
		  }
		  else
		  {
			_properties.DamageRegularMin += this.Math.floor(resolve * 0.025);
			_properties.DamageRegularMax += this.Math.floor(resolve * 0.05);
		  }
		}
	}
});
