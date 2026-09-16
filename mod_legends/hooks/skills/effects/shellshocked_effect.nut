::mods_hookExactClass("skills/effects/shellshocked_effect", function(o) {
	
	o.onAdded = function()
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap() || ("State" in ::Tactical) && ::Tactical.State.isBattleEnded())
		{
			this.removeSelf();
			return;
		}
		if (actor.getCurrentProperties().IsResistantToAnyStatuses && ::Math.rand(1, 100) <= 50)
		{
			if (!actor.isHiddenToPlayer())
			{
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " resists being shellshocked thanks to their unnatural physiology");
			}

			this.removeSelf();
		}
		else
		{
			this.m.TurnsLeft = ::Math.max(1, 3 + actor.getCurrentProperties().NegativeStatusEffectDuration);

			if (this.m.SoundOnUse.len() != 0)
			{
				::Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect * 0.8, actor.getPos());
			}

			actor.checkMorale(-1, 0);
		}
	}
});