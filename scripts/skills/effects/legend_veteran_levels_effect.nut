this.legend_veteran_levels_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.legend_veteran_levels";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Icon = "";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsHidden = true;
	}

	function onUpdateLevel()
	{
		local actor = this.getContainer().getActor();

		if (actor.getLevel() > this.Const.XP.MaxLevelWithPerkpoints && actor.getVeteranPerks() > 0)
		{
			local veteranlevels = actor.getLevel() - this.Const.XP.MaxLevelWithPerkpoints;
			if (veteranlevels % actor.getVeteranPerks() == 0)
			{
				++actor.m.PerkPoints;
			}
		}
	}
});
