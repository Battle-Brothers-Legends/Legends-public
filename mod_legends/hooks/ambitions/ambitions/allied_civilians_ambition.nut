::mods_hookExactClass("ambitions/ambitions/allied_civilians_ambition", function(o)
{
	o.onPrepareVariables = function ( _vars )
	{
		local allies = ::World.FactionManager.getAlliedFactions(::Const.Faction.Player);

		foreach( a in allies )
		{
			local f = ::World.FactionManager.getFaction(a);

			if (f != null && (f.getType() == ::Const.FactionType.Settlement || f.getType() == ::Const.FactionType.OrientalCityState) && f.getPlayerRelation() >= 70.0)
			{
				_vars.push([
					"friendlytown",
					f.getName()
				]);
				break;
			}
		}

		local brothers = ::World.getPlayerRoster().getAll();

		if (brothers.len() > 1)
		{
			for( local i = 0; i < brothers.len(); i = ++i )
			{
				if (brothers[i].getSkills().hasTrait(::Legends.Trait.Player))
				{
					brothers.remove(i);
					break;
				}
			}
		}

		foreach( bro in brothers )
		{
			if (::Legends.Backgrounds.has(bro, ::Legends.Background.Brawler))
			{
				_vars.push([
					"brawler",
					bro.getName()
				]);
				return;
			}
		}

		foreach( bro in brothers )
		{
			if (bro.getBackground().isBackgroundType(::Const.BackgroundType.Combat))
			{
				_vars.push([
					"brawler",
					bro.getName()
				]);
				return;
			}
		}

		_vars.push([
			"brawler",
			brothers[::Math.rand(0, brothers.len() - 1)].getName()
		]);
	}
});
