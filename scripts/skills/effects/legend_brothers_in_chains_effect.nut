// left as is to credit sato properly
// actually renamed to disrespect sato
this.legend_brothers_in_chains_effect <- this.inherit("scripts/skills/skill", {
	m = {
		AttackBonus = 0,
		DefenseBonus = 0,
		ResolveBonus = 0,
		AttackMagnitude = 1,
		DefenseMagnitude = 1,
		ResolveMagnitude = 1
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendBrothersInChains);
		this.m.Description = "Fighting with other escaped slaves drives this character to succeed.";
		this.m.Icon = "ui/settlement_status/settlement_effect_40.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		return [
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
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%positive%]+" + this.m.ResolveBonus + "[/color] Resolve"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%positive%]+" + this.m.AttackBonus + "[/color] Melee Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%positive%]+" + this.m.AttackBonus + "[/color] Ranged Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%positive%]+" + this.m.DefenseBonus + "[/color] Melee Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%positive%]+" + this.m.DefenseBonus + "[/color] Ranged Defense"
			}
		];
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();

		if (!actor.isPlacedOnMap() || actor.getFaction() != this.Const.Faction.Player)
		{
			this.m.IsHidden = true;
			return;
		}

		local myTile = actor.getTile();
		local allies = this.Tactical.Entities.getInstancesOfFaction(this.Const.Faction.Player);
		local numSlaves = 0;

		foreach( ally in allies )
		{
			if (ally.getID() == actor.getID() || !ally.isPlacedOnMap())
			{
				continue;
			}

			if (ally.getBackground() != null && ally.getBackground().getID() == "background.slave")
			{
				numSlaves += 1;
			}
		}

		if (numSlaves < 1)
		{
			this.m.IsHidden = true;
		}
		else
		{
			this.m.IsHidden = false;

			local numSlavesForBonus = numSlaves;
			this.m.AttackBonus = numSlavesForBonus * this.m.AttackMagnitude;
			this.m.DefenseBonus = numSlavesForBonus * this.m.DefenseMagnitude;
			this.m.ResolveBonus = numSlavesForBonus * this.m.ResolveMagnitude;

			_properties.MeleeSkill += this.m.AttackBonus;
			_properties.RangedSkill += this.m.AttackBonus;
			_properties.MeleeDefense += this.m.DefenseBonus;
			_properties.RangedDefense += this.m.DefenseBonus;
			_properties.Bravery += this.m.ResolveBonus;
		}
	}

});

