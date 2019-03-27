this.legend_vala_trance_malevolent_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 3,
		Power = 0
	},
	function setPower(_p)
	{
		this.m.Power = _p;
	}


	function create()
	{
		this.m.ID = "effects.legend_vala_trance_malevolent_effect";
		this.m.Name = "Haunted";
		this.m.Icon = "skills/status_effect_52.png";
		this.m.IconMini = "status_effect_52_mini";
		this.m.Overlay = "status_effect_52";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}


	function isHidden()
	{
		return false;
	}


	function getName()
	{
//		return this.m.Name + " (" + this.m.TurnsLeft + " turns left)";
		return this.m.Name;
	}


	function getTooltip()
	{
		if (!this.isHidden())
		{
			return [
				{
					id = 1,
					type = "title",
					text = this.getName()
				}
			];
		}
		else
		{
			return;
		}
	}


	function addSprite( _n, _brush, _insert = false )
	{
		local actor = this.getContainer().getActor();
		local sprite;

		if (!_insert)
		{
			sprite = actor.addSprite("spirits_" + (_n < 10 ? "0" + _n : _n));
		}
		else
		{
			sprite = actor.insertSprite("spirits_" + (_n < 10 ? "0" + _n : _n));
		}

		sprite.setBrush(_brush);
		sprite.Rotation = this.Math.rand(0, 359);
		actor.setSpriteRenderToTexture("spirits_" + (_n < 10 ? "0" + _n : _n), false);
	}


	function onAdded()
	{
		local actor = this.getContainer().getActor();
		this.addSprite(1, "bust_ghost_fog_02");
		this.addSprite(2, "bust_ghost_fog_02", true);

		this.m.TurnsLeft = this.Math.max(1, 3 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
	}


	function onRemoved()
	{
		local actor = this.getContainer().getActor();
		actor.removeSprite("spirits_01");
		actor.removeSprite("spirits_02");
		actor.getFlags().set("IsSpiritVictim", false);
	}


	function onUpdate( _properties )
	{
		_properties.FatigueOnSkillUse += this.Math.ceil(this.m.Power / 30.0);
		_properties.StaminaMult *= 1.0 - (this.m.Power / 400.0);
		_properties.DamageTotalMult *= 1.0 - (this.m.Power / 800.0);
	}


	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		local everyone = this.Tactical.Entities.getAllInstances();

		foreach (ever in everyone)
		{
			foreach (e in ever)
			{
				local distance = e.getTile().getDistanceTo(actor.getTile());
				if (distance <= 1 && e.isAlliedWith(actor) && e.isAlive() && !e.isDying() && !e.getSkills().hasSkill("effects.legend_vala_trance_malevolent_effect"))
				{
					local chance = this.m.Power - e.getCurrentProperties().Bravery;

					if (chance > 100)
					{
						chance = 100;
					}
					if (chance < 1)
					{
						chance = 1;
					}

					if (this.Math.rand(1, 100) <= chance)
					{
						local effect = this.new("scripts/skills/effects/legend_vala_trance_malevolent_effect");
						effect.setPower(this.m.Power);
						e.getSkills().add(effect);
						this.Sound.play("sounds/combat/legend_vala_malevolent.wav");
					}

					this.logInfo("MALEVOLENT SPIRITS EFFECT :: onTurnStart spread chance = " + chance);
				}
			}
		}
	}


	function onResumeTurn()
	{
		local actor = this.getContainer().getActor();
		local everyone = this.Tactical.Entities.getAllInstances();

		foreach (ever in everyone)
		{
			foreach (e in ever)
			{
				local distance = e.getTile().getDistanceTo(actor.getTile());
				if (distance <= 1 && e.isAlliedWith(actor) && e.isAlive() && !e.isDying() && !e.getSkills().hasSkill("effects.legend_vala_trance_malevolent_effect"))
				{
					local chance = this.m.Power - e.getCurrentProperties().Bravery;

					if (chance > 100)
					{
						chance = 100;
					}
					if (chance < 1)
					{
						chance = 1;
					}

					if (this.Math.rand(1, 100) <= chance)
					{
						local effect = this.new("scripts/skills/effects/legend_vala_trance_malevolent_effect");
						effect.setPower(this.m.Power);
						e.getSkills().add(effect);
						this.Sound.play("sounds/combat/legend_vala_malevolent.wav");
					}

					this.logInfo("MALEVOLENT SPIRITS EFFECT :: onResumeTurn spread chance = " + chance);
				}
			}
		}
	}


	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.getContainer().getActor().getFlags().set("IsSpiritVictim", false);
			this.removeSelf();
		}
	}


	function onCombatFinished()
	{
		this.getContainer().getActor().getFlags().set("IsSpiritVictim", false);
		this.removeSelf();
	}
});
