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
		local skill = this.getContainer().getSkillByID("perk.steel_brow");

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
			this.m.Container.removeByID("effects.shieldwall");
			this.m.Container.removeByID("effects.spearwall");
			this.m.Container.removeByID("effects.riposte");
			this.m.Container.removeByID("effects.return_favor");
			this.m.Container.removeByID("effects.possessed_undead");

			this.m.Container.removeByID("effects.legend_vala_currently_chanting");
			this.m.Container.removeByID("effects.legend_vala_in_trance");
		}
		else
		{
			this.m.IsGarbage = true;
		}
	}
});