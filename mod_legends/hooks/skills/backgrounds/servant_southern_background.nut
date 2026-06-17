::mods_hookExactClass("skills/backgrounds/servant_southern_background", function (o) {
	o.create = function () {
		this.servant_background.create();
		this.m.Bodies = this.Const.Bodies.SouthernThick;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.Southern;
		this.m.Ethnicity = 1;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Superstitious),
			::Legends.Traits.getID(::Legends.Trait.Huge),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.HateGreenskins),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.Impatient),
			::Legends.Traits.getID(::Legends.Trait.IronJaw),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Brave),
			::Legends.Traits.getID(::Legends.Trait.Fearless),
			::Legends.Traits.getID(::Legends.Trait.Optimist),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Determined),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.SureFooting),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.LegendAggressive)
		];
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
	}

	o.setGender <- function (_gender = -1)	{
		if (_gender == -1) _gender = this.randomizeHumanGender();
		if (_gender != 1) return;

		this.m.Bodies = this.Const.Bodies.SouthernFemaleThick;
		this.m.Faces = this.Const.Faces.SouthernFemale;
		this.m.Hairs = this.Const.Hair.SouthernFemale;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	o.onBuildDescription <- function () {
			return "{Life is difficult. Moreso for some than others. | Some %people% can fall from grace. Other %people% have nowhere to fall to, having been born already on the ground. | If life is a throw of dice, maybe some are fools to be %people% rather than mice.} %name% {was a servant to a decadent vizier. | served an abusive family where the kids played with fire. | was kidnapped by nomads and forced to serve their every. Last. Need. | worked feverishly for mad men who looked far too long at the stars.}  %They% rarely made a mistake about %their% place in the world. One day, though, %their% masters {beat %their% unconscious. When %they% awoke, %they% did so in the bed of a benevolent doctor who refused to return %their% to %their% \'employers\'. Instead, %name% was free to go and %their% masters were told %they% had died. | set %them% free, no questions asked. Not one to dally on ceremony, %name% left in earnest. | invited %them% to a party. Believing %they% was a guest, %they% showed up in %their% finest attire - a shirt with hemmed sleeves and a billowy dress that hid her skeletal frame well. Unfortunately, %they% was but a show for the party - they gave %them% a wooden shield and sword, threw %them% into an arena with a wild hyena, and took bets as they watched the horrific spectacle. %They% barely escaped the \'festivities\'.} {%name% has since sworn to never \'serve\' someone again. | The %person%, though now free of %their% duties, still bears a great deal of humiliation and pain from her long, hard life.}";
	}

	o.onAddEquipment = function () {
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.sackcloth],
			[1, ::Legends.Armor.Southern.cloth_sash]
		]))
	}

});
