this.legend_peaceful_reassured_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendPeacefulReassured);
		this.m.Icon = "skills/peaceful_reassured.png";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "The presence of nearby peaceful people is increasing this characters Resolve and experience gain.";
	}

	function getTooltip()
	{
		local peacefuls = this.getPeacefuls();
		local peaceBravery = peacefuls * 3;
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%positive%]+" + peaceBravery + "[/color] Resolve"
			},
			{
				id = 7,
				type = "hint",
				icon = "ui/icons/xp_received.png",
				text = "[color=%positive%]+" + peacefuls + "%[/color] Experience Gain"
			}
		];
		return ret;
	}

	function getPeacefuls()
	{
		if (!("Entities" in ::Tactical) || ::Tactical.Entities == null || !::Tactical.isActive())
		{
			return 0;
		}

		local hippies = 0;
		local actors = ::Tactical.Entities.getAllInstancesAsArray();

		foreach( a in actors )
		{
			if (a.getFaction() == ::Const.Faction.Player && a.getSkills().hasPerk(::Legends.Perk.LegendPeaceful))
			{
				hippies += 1;
			}
		}
		return hippies;
	 }

	function onUpdate( _properties )
	{
		local peacefuls = this.getPeacefuls();
		local peaceBravery = peacefuls * 3;
		local peaceXP = (100 + peacefuls) * 0.01;
		_properties.Bravery += peaceBravery;
		_properties.XPGainMult *= peaceXP;
	}
});

