this.perk_legend_staff_block <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_staff_block";
		this.m.Name = this.Const.Strings.PerkName.LegendStaffBlock;
		this.m.Description = this.Const.Strings.PerkDescription.LegendStaffBlock;
		this.m.Icon = "ui/perks/staff_skill_circle.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		if (actor.getMainhandItem() == null || !actor.getMainhandItem().isWeaponType(this.Const.Items.WeaponType.Staff))
			return;
		if (_properties.IsImmuneToSurrounding == true || actor.getSkills().hasSkill("perk.underdog"))
		{
			_properties.MeleeDefense += 5;
			_properties.RangedDefense += 5;
		}
		else
		{
			_properties.SurroundedDefense += 5;
		}
	}

});
