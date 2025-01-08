this.legend_hidden_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Duration = 4,
		DurationUntouchable = 6
	},
	function create()
	{
		this.m.ID = "actives.legend_hidden";
		this.m.Name = "Hide";
		this.m.Icon = "skills/hide_square.png";
		this.m.IconDisabled = "skills/hide_square_bw.png";
		this.m.Overlay = "active_23";
		this.m.SoundOnUse = [
			"sounds/combat/spearwall_01.wav",
			"sounds/combat/spearwall_02.wav",
			"sounds/combat/spearwall_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsWeaponSkill = false;
		this.m.ActionPointCost = 8;
		this.m.FatigueCost = 40;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function getDescription()
	{
		return "Blend into the terrain and remain unseen until attacking or moving adjacent to an enemy.";
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

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can not be used because this character is engaged in melee[/color]"
			});
		}

		if (this.m.Container.hasPerk(::Const.Perks.PerkDefs.LegendUntouchable))
		{
			ret.push({
				id = 8,
				type = "text",
				text = "Will last for " + this.m.DurationUntouchable + " end of rounds"
			})
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				text = "Will last for " + this.m.Duration + " end of rounds"
			})
		}

		return ret;
	}

	function isUsable()
	{
		if (!this.Tactical.isActive())
		{
			return false;
		}

		if (!this.skill.isUsable())
		{
			return false;
		}

		if (this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			return false;
		}

		if (this.getContainer().hasSkill("terrain.hidden"))
		{
			return false;
		}

		if (this.getContainer().hasSkill("effect.legend_hidden"))
		{
			return false;
		}
		return true;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return true;
	}

	function onUse( _user, _targetTile )
	{

		_user.setHidden(true);
		local effect = this.new("scripts/skills/effects/legend_hidden_effect");
		effect.m.TurnsLeft = (this.m.Container.hasPerk(::Const.Perks.PerkDefs.LegendUntouchable)) ? this.m.DurationUntouchable : this.m.Duration;
		this.m.Container.add(effect);


		if (_user.getTile().IsVisibleForPlayer)
		{
			if (this.Const.Tactical.HideParticles.len() != 0)
			{
				for( local i = 0; i < this.Const.Tactical.HideParticles.len(); i = ++i )
				{
					this.Tactical.spawnParticleEffect(false, this.Const.Tactical.HideParticles[i].Brushes, _user.getTile(), this.Const.Tactical.HideParticles[i].Delay, this.Const.Tactical.HideParticles[i].Quantity, this.Const.Tactical.HideParticles[i].LifeTimeQuantity, this.Const.Tactical.HideParticles[i].SpawnRate, this.Const.Tactical.HideParticles[i].Stages);
				}
			}
		}

		if (!_user.isHiddenToPlayer())
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " uses Hide");
		}

		return true;
	}

	function onRemoved()
	{
		this.m.Container.removeByID("effect.legend_hidden");
	}

});

