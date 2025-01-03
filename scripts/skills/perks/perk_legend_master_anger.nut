this.perk_legend_master_anger <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendMasterAnger);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTurnStart()
	{
		local validSkills = [
			["injury.legend_aperthropy", "actives.legend_transform_into_boar", "actives/legend_transform_into_boar"],
			["injury.legend_arborthropy", "actives.legend_transform_into_tree", "actives/legend_transform_into_tree"],
			["injury.legend_lycanthropy", "actives.legend_transform_into_wolf", "actives/legend_transform_into_wolf"],
			["injury.legend_ursathropy", "actives.legend_transform_into_bear", "actives/legend_transform_into_bear"],
			["injury.legend_vermesthropy", "actives.legend_transform_into_rat", "actives/legend_transform_into_rat"]
		];

		local actor = this.getContainer().getActor();

		foreach (s in validSkills)
		{
			if (actor.getSkills().hasSkill(s[0]) && !actor.getSkills().hasSkill(s[1]))
			{
				actor.getSkills().add(this.new("scripts/skills/" + s[2]));
			}
		}
	}


});
