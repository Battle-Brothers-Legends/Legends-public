::mods_hookExactClass("skills/effects/stunned_effect", function(o) {

	o.setTurns = function ( _t )
	{
		if (!::MSU.isNull(this.getContainer()) && !::MSU.isNull(this.getContainer().getActor()))
		{
			this.m.TurnsLeft = this.Math.max(1, _t + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		}
	}

	o.onAdded = function ()
	{
		// Legends Steel Brow Stun -> Daze logic here
		local skill = ::Legends.Perks.get(this, ::Legends.Perk.SteelBrow);

		if (skill != null)
		{
			if (this.getContainer().getActor().getTile().IsVisibleForPlayer)
			{
				this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " resists the Stun with " + skill.getName() + " and is Dazed instead.");
			}
			this.removeSelf();
			this.getContainer().add(this.new("scripts/skills/effects/dazed_effect"));
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
			this.m.IsGarbage = true;
		}
	}
});
