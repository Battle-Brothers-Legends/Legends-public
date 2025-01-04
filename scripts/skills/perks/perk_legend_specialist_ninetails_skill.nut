this.perk_legend_specialist_ninetails_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendSpecialistNinetailsSkill);
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
			_properties.MeleeSkill += this.Math.floor(resolve * 0.2);
		  }
		  else
		  {
			_properties.MeleeSkill += this.Math.floor(resolve * 0.10);
		  }
		}
	}
});
