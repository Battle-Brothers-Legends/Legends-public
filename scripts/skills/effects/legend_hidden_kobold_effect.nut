this.legend_hidden_kobold_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 5
	},
	function create()
	{
		this.m.ID = "effect.legend_hidden_kobold";
		this.m.Name = "Hidden";
		this.m.Description = "This character is hidden in terrain and can not be seen by opponents. Removed upon attacking opponents or directly adjacent to them.";
		this.m.Icon = "skills/status_effect_08.png";
		this.m.IconMini = "status_effect_08_mini";
		this.m.Type = this.Const.SkillType.Terrain | this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsSerialized = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		local actor = this.getContainer().getActor();
		if (actor.getSkills().hasPerk(::Legends.Perk.LegendAssassinate))
		{
			ret.extend([
				{
					id = 11,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = "[color=%positive%]+50%[/color] Minimum Damage from the Assassinate perk"
				},
				{
					id = 12,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = "[color=%positive%]+50%[/color] Maximum Damage from the Assassinate perk"
				}
			]);

			if (actor.getSkills().hasSkill("background.assassin") || actor.getSkills().hasSkill("background.assassin_southern"))
			{
					{
						id = 13,
						type = "text",
						icon = "ui/icons/regular_damage.png",
						text = "[color=%positive%]+50%[/color] Maximum Damage from being an assassin"
					}
			}

			if (actor.getSkills().hasSkill("background.legend_commander_assassin"))
			{
					{
						id = 13,
						type = "text",
						icon = "ui/icons/regular_damage.png",
						text = "[color=%positive%]+100%[/color] Maximum Damage from being an assassin"
					}
			}
		}

		ret.push({
			id = 13,
			type = "text",
			text = "Will last for " + this.m.TurnsLeft + " more end of rounds"
		});

		return ret;

	}

	function onMovementFinished()
	{
		local actor = this.getContainer().getActor();
		local tile = actor.getTile();
		if (tile.hasZoneOfControlOtherThan(actor.getAlliedFactions()))
		{
			actor.setHidden(false);
			this.removeSelf();
			return;
		}
		actor.setHidden(true);
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.getContainer().getActor().setHidden(false);
		this.removeSelf();
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.getContainer().getActor().setHidden(false);
		this.removeSelf();
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.getTile().IsVisibleForPlayer)
		{
			if (this.Const.Tactical.HideParticles.len() != 0)
			{
				for( local i = 0; i < this.Const.Tactical.HideParticles.len(); i = ++i )
				{
					this.Tactical.spawnParticleEffect(false, this.Const.Tactical.HideParticles[i].Brushes, actor.getTile(), this.Const.Tactical.HideParticles[i].Delay, this.Const.Tactical.HideParticles[i].Quantity, this.Const.Tactical.HideParticles[i].LifeTimeQuantity, this.Const.Tactical.HideParticles[i].SpawnRate, this.Const.Tactical.HideParticles[i].Stages);
				}
			}
		}

		actor.setBrushAlpha(10);
		actor.getSprite("body").Visible = false;
		actor.getSprite("head").Visible = false;
		actor.getSprite("socket").Visible = false;
		actor.getSprite("arms_icon").Visible = false;
		actor.getSprite("shield_icon").Visible = false;
		actor.getSprite("injury_body").Visible = false;
		actor.getSprite("morale").Visible = false;
		actor.setHidden(true);
		actor.setDirty(true);
	}

	function onRemoved()
	{
		this.getContainer().getActor().setHidden(false);
		local actor = this.getContainer().getActor();
		actor.setBrushAlpha(255);
		actor.getSprite("body").Visible = true;
		actor.getSprite("head").Visible = true;
		actor.getSprite("socket").Visible = true;
		actor.getSprite("arms_icon").Visible = true;
		actor.getSprite("shield_icon").Visible = true;
		actor.getSprite("injury_body").Visible = true;
		actor.getSprite("morale").Visible = true;
		actor.setDirty(true);
		foreach (i in actor.getItems().getAllItems())
			i.updateAppearance();
		if (actor.getTile().IsVisibleForPlayer)
		{
			if (this.Const.Tactical.HideParticles.len() != 0)
			{
				for( local i = 0; i < this.Const.Tactical.HideParticles.len(); i = ++i )
				{
					this.Tactical.spawnParticleEffect(false, this.Const.Tactical.HideParticles[i].Brushes, actor.getTile(), this.Const.Tactical.HideParticles[i].Delay, this.Const.Tactical.HideParticles[i].Quantity, this.Const.Tactical.HideParticles[i].LifeTimeQuantity, this.Const.Tactical.HideParticles[i].SpawnRate, this.Const.Tactical.HideParticles[i].Stages);
				}
			}
		}
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		if (actor.getSkills().hasPerk(::Legends.Perk.LegendAssassinate))
		{
			_properties.DamageRegularMin *= 1.5;
			_properties.DamageRegularMax *= 1.5;

			if (actor.getSkills().hasSkill("background.assassin") || actor.getSkills().hasSkill("background.assassin_southern"))
			{
			_properties.DamageRegularMax *= 1.5;
			}
			if (actor.getSkills().hasSkill("background.legend_commander_assassin"))
			{
			_properties.DamageRegularMax *= 2.0;
			}
		}

		_properties.TargetAttractionMult *= 0.5;
		actor.setBrushAlpha(10);
		actor.getSprite("body").Visible = false;
		actor.getSprite("head").Visible = false;
		actor.getSprite("socket").Visible = false;
		actor.getSprite("arms_icon").Visible = false;
		actor.getSprite("shield_icon").Visible = false;
		actor.getSprite("injury_body").Visible = false;
		actor.setHidden(true);
		actor.setDirty(true);
	}

	function resetTime()
	{
		this.m.TurnsLeft = 5;
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.getContainer().getActor().setHidden(false);
			this.removeSelf();
		}
	}
});

