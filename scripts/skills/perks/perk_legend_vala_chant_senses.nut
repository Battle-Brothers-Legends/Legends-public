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
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendValaChantSenses);
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

		if (actor.getSkills().hasSkill("effects.legend_vala_currently_chanting"))
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
			text = "Until the start of her next turn all allies within 3 tiles of the Vala receive a bonus to their melee and ranged defenses. Being closer to the Vala increases the bonus amount."
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

		if (actor.getSkills().hasSkill("effects.legend_vala_currently_chanting"))
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

		if (actor.getSkills().hasSkill("effects.legend_vala_currently_chanting"))
		{
			actor.getSkills().removeByID("effects.legend_vala_currently_chanting");
		}

		foreach( tar in targets )
		{
			foreach( t in tar )
			{
				if (t.getSkills().hasSkill("effects.legend_vala_chant_senses_effect"))
				{
					t.getSkills().removeByID("effects.legend_vala_chant_senses_effect");
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

		if (actor.getSkills().hasSkill("perk.legend_vala_chanting_mastery"))
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

		if (actor.getSkills().hasSkill("effects.legend_vala_currently_chanting") && this.m.ChantIsActive)
		{
			this.Sound.play("sounds/combat/legend_vala_senses.wav");
		}

		foreach( tar in targets )
		{
			foreach( t in tar )
			{
				if (t.getSkills().hasSkill("effects.legend_vala_chant_senses_effect"))
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

			if (!actor.getSkills().hasSkill("effects.legend_vala_currently_chanting"))
			{
				actor.getSkills().add(this.new("scripts/skills/effects/legend_vala_currently_chanting"));
			}

			foreach( tar in targets )
			{
				foreach( t in tar )
				{
					if (t.isAlliedWith(actor) && !t.getSkills().hasSkill("effects.legend_vala_chant_senses_effect"))
					{
						local senses = this.new("scripts/skills/effects/legend_vala_chant_senses_effect");
						senses.setVala(this.getContainer().getActor());
						t.getSkills().add(senses);

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

