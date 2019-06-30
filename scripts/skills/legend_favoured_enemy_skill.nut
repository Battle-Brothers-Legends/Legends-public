this.legend_favoured_enemy_skill <- this.inherit("scripts/skills/skill", {
	m = {
		ValidTypes = [],
		BraveryMult = 1.0
	},
	function create()
	{
		//this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Icon = "skills/status_effect_57.png";
		this.m.IconMini = "status_effect_57_mini";
		this.m.Overlay = "status_effect_57";

		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getTooltip()
	{
		local stats = this.getTotalKillStats()
		local resp =  [
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
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + stats.HitChance + "%[/color] Melee Skill due to being a favored enemy"
			},			
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + stats.HitChance + "%[/color] Range Skill due to being a favored enemy"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.Math.floor(stats.HitMult - 1.0) * 100.0 + "%[/color] Max Damage due to being a favored enemy"
			}
		];
		if (this.m.BraveryMult > 1)
		{
			resp.push({
				id = 15,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.Math.floor(this.m.BraveryMult - 1.0) * 100.0 + "%[/color] Resolve due to being a favored enemy"
			})
		}
		resp.push({
			id = 15,
			type = "hint",
			icon = "ui/icons/special.png",
			text = stats.Kills + " favored enemy kills"
		})

		return resp;
	}

	function validTarget( _targetID)
	{
		foreach (t in this.m.ValidTypes)
		{
			if (_targetID == t)
			{
				return true;
			}
		}
		return false;
	}

	function getTotalKillStats()
	{
		return this.Const.LegendMod.GetFavoriteEnemyStats(this.getContainer().getActor(), this.m.ValidTypes);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
		{
			return;
		}
		
		if (this.validTarget(_targetEntity.getType()))
		{
			local stats = this.getTotalKillStats();
			_properties.MeleeSkill += stats.HitChance;
			_properties.RangedSkill += stats.HitChance;
			_properties.DamageRegularMax *= stats.HitMult;
		}
		
		else
		{
		 return;
		}
	}

	function onUpdate( _properties )
	{
		if (this.m.BraveryMult == 1.0)
		{
			return;
		}

		if (!("Entities" in this.Tactical))
		{
			return;
		}

		if (this.Tactical.Entities == null)
		{
			return;
		}

		local actors = this.Tactical.Entities.getAllInstancesAsArray();
		foreach( a in actors )
		{
			foreach (vt in this.m.ValidTypes)
			{
				if (a.getType() == vt)
				{
					_properties.BraveryMult *= this.m.BraveryMult;
					return;
				}
			}
		}
	}
	
});

