::mods_hookExactClass("events/events/oldguard_becomes_drunkard_event", function(o) {
	o.onUpdateScore = function ()
	{
		if (::World.getTime().IsDaytime)
			return;

		local fallen = ::World.Statistics.getFallen();

		if (fallen.len() < 7)
			return;

		local numFallen = 0;

		foreach( f in fallen )
			if (!f.Expendable)
				numFallen = ++numFallen;

		if (numFallen < 7)
			return;

		local brothers = ::World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
			return;

		local candidates = [];

		foreach( bro in brothers ) {
			if (bro.getBackground().isBackgroundType(::Const.BackgroundType.ConvertedCultist) || bro.getBackground().isBackgroundType(::Const.BackgroundType.Cultist) || ::Legends.Backgrounds.has(bro, ::Legends.Background.Slave))
				continue;

			if (bro.getLevel() >= 8 && !bro.getSkills().hasTrait(::Legends.Trait.Drunkard) && ::World.getTime().Days - bro.getDaysWithCompany() < fallen[0].Time && ::World.getTime().Days - bro.getDaysWithCompany() < fallen[1].Time && !bro.getSkills().hasTrait(::Legends.Trait.Player) && !bro.getFlags().get("IsPlayerCharacter"))
				candidates.push(bro);
		}

		if (candidates.len() == 0)
			return;

		this.m.Oldguard = candidates[::Math.rand(0, candidates.len() - 1)];

		for( local i = 0; i < fallen.len(); i = ++i ) {
			if (fallen[i].Expendable)
			{}
			else if (this.m.OtherCasualty == null)
				this.m.OtherCasualty = fallen[i].Name;
			else if (this.m.Casualty == null)
				this.m.Casualty = fallen[i].Name;
			else
				break;
		}

		this.m.Score = numFallen - 2;
	}
})
