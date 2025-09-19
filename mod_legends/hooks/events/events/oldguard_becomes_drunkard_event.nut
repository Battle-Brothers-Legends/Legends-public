::mods_hookExactClass("events/events/oldguard_becomes_drunkard_event", function(o) {
	o.onUpdateScore = function ()
	{
		if (this.World.getTime().IsDaytime)
			return;

		local fallen = this.World.Statistics.getFallen();

		if (fallen.len() < 7)
			return;

		local numFallen = 0;

		foreach( f in fallen )
			if (!f.Expendable)
				numFallen = ++numFallen;

		if (numFallen < 7)
			return;

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
			return;

		local candidates = [];

		foreach( bro in brothers ) {
			if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist) || bro.getBackground().isBackgroundType(this.Const.BackgroundType.Cultist) || bro.getBackground().getID() == "background.slave")
				continue;

			if (bro.getLevel() >= 8 && !bro.getSkills().hasTrait(::Legends.Trait.Drunkard) && this.World.getTime().Days - bro.getDaysWithCompany() < fallen[0].Time && this.World.getTime().Days - bro.getDaysWithCompany() < fallen[1].Time && !bro.getSkills().hasTrait(::Legends.Trait.Player) && !bro.getFlags().get("IsPlayerCharacter"))
				candidates.push(bro);
		}

		if (candidates.len() == 0)
			return;

		this.m.Oldguard = candidates[this.Math.rand(0, candidates.len() - 1)];

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
