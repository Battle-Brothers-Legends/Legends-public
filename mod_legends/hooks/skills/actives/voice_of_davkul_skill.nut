::mods_hookExactClass("skills/actives/voice_of_davkul_skill", function(o)
{
	o.onUse = function ( _user, _targetTile )
	{
		local actors = this.Tactical.Entities.getAllInstancesAsArray();

		foreach( a in actors )
		{
			if (a.getID() == _user.getID())
				continue;

			if (a.getFatigue() == 0)
				continue;

			if (a.getType() == this.Const.EntityType.Cultist || (::MSU.isKindOf(a, "player") && !::MSU.isNull(a.getBackground()) && (a.getBackground().isBackgroundType(this.Const.BackgroundType.Cultist) || a.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist))))
				::Legends.Effects.grant(a, ::Legends.Effect.VoiceOfDavkul);
		}

		return true;
	}
});
