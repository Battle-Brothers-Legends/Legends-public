this.perk_legend_vala_chant_senses <- this.inherit("scripts/skills/skill", {
	m = {
		ChantIsActive = false
	},
	function resetChant()
	{
		this.m.ChantIsActive = false;
	}

	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendValaChantSenses);
		this.m.Icon = "ui/perks/legend_vala_chant_senses_active.png";
		this.m.IconDisabled = "ui/perks/legend_vala_chant_senses_active_sw.png";
		this.m.Type = this.Const.SkillType.Active | this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.NonTargeted + 1;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 30;
	}

	function isUsable()
	{
		local actor = this.getContainer().getActor();

		if (!this.skill.isUsable())
		{
			return false;
		}

		if (this.m.ChantIsActive)
		{
			return false;
		}

		if (actor.getSkills().hasEffect(::Legends.Effect.LegendValaCurrentlyChanting))
		{
			return false;
		}

		if (actor.getMainhandItem() == null)
		{
			return false;
		}

		if (actor.getMainhandItem().getID() != "weapon.legend_staff_vala")
		{
			return false;
		}

		return true;
	}

	function getTooltip()
	{
		local actor = this.getContainer().getActor();
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Until the start of her next turn all allies within 3 tiles of the Vala receive a bonus to their melee and ranged defenses. Being closer to the Vala increases the bonus amount"
		});

		if (actor.getMainhandItem() == null || actor.getMainhandItem() != "weapon.legend_staff_vala")
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Requires the Vala\'s staff.[/color]"
			});
		}

		if (actor.getSkills().hasEffect(::Legends.Effect.LegendValaCurrentlyChanting))
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Already chanting.[/color]"
			});
		}

		return ret;
	}

	function endChant()
	{
		local actor = this.getContainer().getActor();
		local targets = this.Tactical.Entities.getAllInstances();

		if (actor.getSkills().hasEffect(::Legends.Effect.LegendValaCurrentlyChanting))
		{
			::Legends.Effects.remove(actor, ::Legends.Effect.LegendValaCurrentlyChanting);
		}

		foreach( tar in targets )
		{
			foreach( t in tar )
			{
				if (t.getSkills().hasEffect(::Legends.Effect.LegendValaChantSensesEffect))
				{
					::Legends.Effects.remove(t, ::Legends.Effect.LegendValaChantSensesEffect);
				}
			}
		}

		this.resetChant();
	}

	function onTurnStart()
	{
		this.endChant();
	}

	function onCombatFinished()
	{
		this.endChant();
	}

	function onDeath( _fatalityType )
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap() || ("State" in this.Tactical) && this.Tactical.State.isBattleEnded())
			return;

		this.endChant();
	}

	function onAfterUpdate( _properties )
	{
		local actor = this.getContainer().getActor();

		if (actor.getSkills().hasPerk(::Legends.Perk.LegendValaChantMastery))
		{
			this.m.FatigueCostMult = 0.75;
		}
		else
		{
			this.m.FatigueCostMult = 1.0;
		}
	}

	function onMovementCompleted( _tile )
	{
		local actor = this.getContainer().getActor();
		local targets = this.Tactical.Entities.getAllInstances();

		if (actor.getSkills().hasEffect(::Legends.Effect.LegendValaCurrentlyChanting) && this.m.ChantIsActive)
		{
			this.Sound.play("sounds/combat/legend_vala_senses.wav");
		}

		foreach( tar in targets )
		{
			foreach( t in tar )
			{
				if (t.getSkills().hasEffect(::Legends.Effect.LegendValaChantSensesEffect))
				{
					if (actor.getTile().getDistanceTo(t.getTile()) <= 3 && actor.getID() != t.getID())
					{
						this.spawnIcon("status_effect_73", t.getTile());
					}

					t.getSkills().update();
				}
			}
		}
	}

	function onUpdate( _properties )
	{
	}

	function onUse( _user, _targetTile )
	{
		if (this.isUsable())
		{
			local actor = this.getContainer().getActor();
			local targets = this.Tactical.Entities.getAllInstances();

			if (!actor.getSkills().hasEffect(::Legends.Effect.LegendValaCurrentlyChanting))
			{
				::Legends.Effects.grant(actor, ::Legends.Effect.LegendValaCurrentlyChanting);
			}

			foreach( tar in targets )
			{
				foreach( t in tar )
				{
					if (t.isAlliedWith(actor) && !t.getSkills().hasEffect(::Legends.Effect.LegendValaChantSensesEffect))
					{
						::Legends.Effects.grant(t, ::Legends.Effect.LegendValaChantSensesEffect, function(_effect) {
							_effect.setVala(this.getContainer().getActor());
						}.bindenv(this));

						if (actor.getTile().getDistanceTo(t.getTile()) <= 3 && actor.getID() != t.getID())
						{
							this.spawnIcon("status_effect_73", t.getTile());
						}
					}
				}
			}

			this.Sound.play("sounds/combat/legend_vala_senses.wav");
			this.m.ChantIsActive = true;
		}
	}

});

