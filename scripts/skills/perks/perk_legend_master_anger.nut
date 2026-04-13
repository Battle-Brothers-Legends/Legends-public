this.perk_legend_master_anger <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMasterAnger);
	}

	function onTurnStart()
	{
		local validSkills = [
			["injury.legend_aperthropy", ::Legends.Active.LegendTransformIntoBoar],
			["injury.legend_arborthropy", ::Legends.Active.LegendTransformIntoTree],
			["injury.legend_lycanthropy", ::Legends.Active.LegendTransformIntoWolf],
			["injury.legend_ursathropy", ::Legends.Active.LegendTransformIntoBear],
			["injury.legend_vermesthropy", ::Legends.Active.LegendTransformIntoRat]
		];

		foreach (s in validSkills) {
			if (this.getContainer().hasSkill(s[0]) && !this.getContainer().hasActive(s[1]))
				::Legends.Actives.grant(this, s[1]);
		}
	}
});
