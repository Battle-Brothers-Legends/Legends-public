this.legend_holyflame_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.legend_holyflame";
		this.m.Name = "Holy Flame";
		this.m.Description = "Bless an area, the holy shall be sanctified when entering, the damned shall be consecrated.";
		this.m.Icon = "skills/holybluefire_square.png";
		this.m.IconDisabled = "skills/holyfire_square_bw.png";
		this.m.Overlay = "bluefire_circle";
		this.m.SoundOnUse = [
			"sounds/combat/fire_01.wav",
			"sounds/combat/fire_02.wav",
			"sounds/combat/fire_03.wav",
			"sounds/combat/fire_04.wav",
			"sounds/combat/fire_05.wav",
			"sounds/combat/fire_06.wav"
		];
		this.m.SoundOnHitHitpoints = [
			"sounds/humans/0/human_light_01.wav",
			"sounds/humans/0/human_light_02.wav",
			"sounds/humans/0/human_light_03.wav",
			"sounds/humans/0/human_light_04.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted +10;
		this.m.Delay = 0;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 30;
		this.m.MinRange = 1;
		this.m.MaxRange = 3;
		this.m.MaxLevelDifference = 3;
	}

		function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Applied hallowed ground, the holy shall be sanctified when entering, the damned shall be consecrated."
			}
		]);
		return ret;
	}

	function isViableTarget( _user, _target )
	{

		if (_target.getTile().Properties.Effect != null)
		{
			return false;
		}

		return true;
	}

	function isUsable()
	{

		return !this.Tactical.isActive() || this.skill.isUsable() && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	function onUse( _user, _targetTile )
	{
		local targets = [];
		targets.push(_targetTile);

		local p = {
			Type = "legend_holyflame",
			Tooltip = "This is hallowed ground, the holy shall be sanctified here, the damned shall be consecrated.",
			IsAppliedAtRoundStart = false,
			IsAppliedAtTurnEnd = true,
			IsAppliedOnMovement = false,
			Timeout = this.Time.getRound() + 2,
			Callback = this.Const.Tactical.Common.onApplyHolyFlame
		};

		foreach( tile in targets )
		{
			if (tile.Properties.Effect != null && tile.Properties.Effect.Type == "legend_holyflame")
			{
				tile.Properties.Effect.Timeout = this.Time.getRound() + 2;
			}
			else
			{
				tile.Properties.Effect = clone p;
				local particles = [];

				for( local i = 0; i < this.Const.Tactical.HolyFlameParticles.len(); i = ++i )
				{
					particles.push(this.Tactical.spawnParticleEffect(true, this.Const.Tactical.HolyFlameParticles[i].Brushes, tile, this.Const.Tactical.HolyFlameParticles[i].Delay, this.Const.Tactical.HolyFlameParticles[i].Quantity, this.Const.Tactical.HolyFlameParticles[i].LifeTimeQuantity, this.Const.Tactical.HolyFlameParticles[i].SpawnRate, this.Const.Tactical.HolyFlameParticles[i].Stages));
				}

				this.Tactical.Entities.addTileEffect(tile, tile.Properties.Effect, particles);
			}
		}

		return true;
	}

});
