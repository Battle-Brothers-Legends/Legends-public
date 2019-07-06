this.perk_legend_specialist_staff_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_staff_skill";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecStaffSkill;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecStaffSkill;
		this.m.Icon = "ui/perks/spear_02.png";
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
		if (item != null && item.getID() == "weapon.legend_staff")
		{
		_properties.MeleeDefense += 10;
		}

		if (item != null && item.getID() == "weapon.legend_tipstaff")
		{
		_properties.MeleeDefense += 10;
		}

		if (item != null && item.getID() == "weapon.legend_staff_gnarled")
		{
		_properties.MeleeDefense += 10;
		}

		if (item != null && item.getID() == "weapon.legend_mystic_staff")
		{
		_properties.MeleeDefense += 10;
		}

		if (item != null && item.getID() == "weapon.legend_staff_vala")
		{
		_properties.MeleeDefense += 10;
		}

	}

});
