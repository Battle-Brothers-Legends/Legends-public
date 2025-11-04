::mods_hookExactClass("skills/effects/stunned_effect", function(o) {

	o.setTurns = function ( _t )
	{
		if (!::MSU.isNull(this.getContainer()) && !::MSU.isNull(this.getContainer().getActor()))
		{
			this.m.TurnsLeft = this.Math.max(1, _t + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		}
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
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color] Melee Defense"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color] Ranged Defense"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color] Initiative"
			}
		];
	}

	o.onAdded = function ()
	{
		// Legends Steel Brow Stun -> Daze logic here
		local skill = ::Legends.Perks.get(this, ::Legends.Perk.SteelBrow);
		local otherSkill = ::Legends.Perks.get(this, ::Legends.Perk.LegendImmovableObject);
		if (skill != null || (otherSkill != null && otherSkill.m.SteelBrow))
		{
			if (this.getContainer().getActor().getTile().IsVisibleForPlayer)
			{
				this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " resists the Stun with " + skill.getName() + " and is Dazed instead.");
			}
			this.removeSelf();
			::Legends.Effects.grant(this, ::Legends.Effect.Dazed);
			return;
		}
		// End of Legends Steel Brow logic
		local statusResisted = this.getContainer().getActor().getCurrentProperties().IsResistantToAnyStatuses ? this.Math.rand(1, 100) <= 50 : false;
		statusResisted = statusResisted || this.getContainer().getActor().getCurrentProperties().IsResistantToPhysicalStatuses ? this.Math.rand(1, 100) <= 33 : false;

		if (statusResisted)
		{
			if (!this.getContainer().getActor().isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " shook off being stunned thanks to his unnatural physiology");
			}

			this.removeSelf();
		}
		else if (!this.m.Container.getActor().getCurrentProperties().IsImmuneToStun)
		{
			::Legends.Effects.remove(this, ::Legends.Effect.Shieldwall);
			::Legends.Effects.remove(this, ::Legends.Effect.Spearwall);
			::Legends.Effects.remove(this, ::Legends.Effect.Riposte);
			::Legends.Effects.remove(this, ::Legends.Effect.LegendReturnFavor);
			::Legends.Effects.remove(this, ::Legends.Effect.PossessedUndead);

			::Legends.Effects.remove(this, ::Legends.Effect.LegendValaCurrentlyChanting);
			::Legends.Effects.remove(this, ::Legends.Effect.LegendValaInTrance);
		}
		else
		{
			this.m.IsGarbage = true; //yeah tell me about it.
		}
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		_properties.MeleeDefenseMult *= 0.75;
		_properties.RangedDefenseMult *= 0.75;
		_properties.InitiativeMult *= 0.75;
	}
});
