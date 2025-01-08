this.legend_unleash_bear_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Entity = null,
		EntityName = "Bear",
		Script = "scripts/entity/tactical/legend_warbear",
		Sounds0 = [
			"sounds/enemies/bear_hit1.wav",
			"sounds/enemies/bear_hit2.wav"
		],
		Sounds1 = [
			"sounds/enemies/bear_dead.wav"
		],
		Sounds2 = [
			"sounds/enemies/unhold_flee_01.wav",
			"sounds/enemies/unhold_flee_02.wav",
			"sounds/enemies/unhold_flee_03.wav",
			"sounds/enemies/unhold_flee_04.wav"
		],
		Sounds3 = [
			"sounds/enemies/bear_idle1.wav",
			"sounds/enemies/bear_idle2.wav"
		],
		Sounds4 = [
			"sounds/enemies/bear_attack1.wav",
			"sounds/enemies/bear_attack2.wav"
		],
		Sounds5 = [
			"sounds/enemies/bear_attack1.wav",
			"sounds/enemies/bear_attack2.wav"
		]
	},
	function setItem( _i )
	{
		this.m.Item = this.WeakTableRef(_i);
	}

	function create()
	{
		this.m.ID = "actives.legend_unleash_bear";
		this.m.Name = "Summon Bear";
		this.m.Description = "Summon a faithful bear. Needs a free tile adjacent. Only one per battle";
		this.m.Icon = "skills/bear_square.png";
		this.m.IconDisabled = "skills/bear_square_bw.png";
		this.m.Overlay = "active_165";
		this.m.SoundOnUse = [
			"sounds/enemies/bear_idle1.wav",
			"sounds/enemies/bear_idle2.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Last + 5;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsTargetingActor = false;
		this.m.ActionPointCost = 8;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function addResources()
	{
		this.skill.addResources();

		foreach( r in this.m.Sounds0 )
		{
			this.Tactical.addResource(r);
		}

		foreach( r in this.m.Sounds1 )
		{
			this.Tactical.addResource(r);
		}

		foreach( r in this.m.Sounds2 )
		{
			this.Tactical.addResource(r);
		}

		foreach( r in this.m.Sounds3 )
		{
			this.Tactical.addResource(r);
		}

		foreach( r in this.m.Sounds4 )
		{
			this.Tactical.addResource(r);
		}

		foreach( r in this.m.Sounds5 )
		{
			this.Tactical.addResource(r);
		}
	}

	function getTooltip()
	{
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
				id = 3,
				type = "text",
				text = this.getCostString()
			}
		];
		return ret;
	}

	function isUsable()
	{
		if (this.getContainer().hasSkill("effects.legend_summoned_bear_effect"))
		{
			return false;
		}

		if (this.m.Entity != null || !this.skill.isUsable())
		{
			return false;
		}

		return true;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		local actor = this.getContainer().getActor();
		return this.skill.onVerifyTarget(_originTile, _targetTile) && _targetTile.IsEmpty;
	}

	function onUse( _user, _targetTile )
	{
		_user.getSkills().add(this.new("scripts/skills/effects/legend_summoned_bear_effect"));
		local entity = this.Tactical.spawnEntity(this.m.Script, _targetTile.Coords.X, _targetTile.Coords.Y);
		entity.setFaction(this.Const.Faction.PlayerAnimals);
		entity.setName(this.m.EntityName);
		if (this.getContainer().getActor().getSkills().hasPerk(::Const.Perks.PerkDefs.LegendDogWhisperer))
		{
			::Legends.Perks.grant(entity, ::Const.Perks.PerkDefs.FortifiedMind);
			::Legends.Perks.grant(entity, ::Const.Perks.PerkDefs.Colossus);
			::Legends.Perks.grant(entity, ::Const.Perks.PerkDefs.Underdog);
		}
		return true;
	}

	function onCombatFinished()
	{
		this.m.Entity = null;
	}

});
