this.legend_rat_bite_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendRatBite);
		this.m.Description = "A vicious bite with a 15% increased chance to hit the head and 100% chance to infect.";
		this.m.KilledString = "Gnawed";
		this.m.Icon = "skills/rat_bite.png";
		this.m.IconDisabled = "skills/rat_bite_bw.png";
		this.m.Overlay = "rat_bite";
		this.m.SoundOnUse = [
			"sounds/enemies/zombie_bite_01.wav",
			"sounds/enemies/zombie_bite_02.wav",
			"sounds/enemies/zombie_bite_03.wav",
			"sounds/enemies/zombie_bite_04.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.1;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 10;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function onUpdate( _properties )
	{
		if (this.isUsable())
		{
			if ( _properties.DamageRegularMin < 15)
				{
					_properties.DamageRegularMin = 15;
				}
			if ( _properties.DamageRegularMin < 15)
				{
				_properties.DamageRegularMax = 35;
				}

		_properties.HitChance[this.Const.BodyPart.Head] += 15;
		}
	}

	function onUse( _user, _targetTile )
	{

		local target = _targetTile.getEntity();
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (success)
		{
			if (!target.getCurrentProperties().IsImmuneToPoison)
			{
				::Legends.Effects.grant(target, ::Legends.Effect.LegendRatPoison);
			}

		return success;
		}
	}

function onDamageDealt( _target, _skill, _hitInfo )
	{
		if (!target.getCurrentProperties().IsImmuneToPoison)
		{
			this.weapon.onDamageDealt(_target, _skill, _hitInfo);

			if (!this.isKindOf(_target, "player") && !this.isKindOf(_target, "human"))
			{
				return;
			}

			if (_target.getHitpoints() > 0)
			{
				return;
			}

			if (_hitInfo.Tile.IsCorpseSpawned && _hitInfo.Tile.Properties.get("Corpse").IsResurrectable)
			{
				local corpse = _hitInfo.Tile.Properties.get("Corpse");
				corpse.Faction = this.Const.Faction.PlayerAnimals;
				corpse.Hitpoints = 1.0;
				corpse.Items = _target.getItems();
				corpse.IsConsumable = false;
				corpse.IsResurrectable = false;
				this.Time.scheduleEvent(this.TimeUnit.Rounds, this.Math.rand(1, 1), this.Tactical.Entities.resurrect, corpse);
			}
		}
	}

});

