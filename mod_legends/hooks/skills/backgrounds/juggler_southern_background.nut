::mods_hookExactClass("skills/backgrounds/juggler_southern_background", function(o)
{
	o.create = function ()
	{
		this.juggler_background.create();
		this.m.Bodies = this.Const.Bodies.SouthernSkinny;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.Southern;
		this.m.Ethnicity = 1;
		this.m.BeardChance = 60;
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		if (_gender != 1) return;

		this.m.Bodies = this.Const.Bodies.SouthernFemaleSkinny;
		this.m.Faces = this.Const.Faces.SouthernFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	o.onBuildDescription <- function () {
		return "{Natural talent is rare, and %name% had it in ample supply. A quick and easy career awaited %them% as a street performer beneath the gilded domes of the city-states. Eventually catching the eye of a wealthy Vizier, %they% enjoyed courtly luxuries until a vicious mockery of a steward\'s nose ended badly for %them%. Given the choice between being thrown into the arena and a self-imposed exile, %they% quickly chose the merciless deserts over the spectacle arena offered. | %name% is a mercurial character, very different from the usual performers of the South. Other jugglers swear they have never seen %them% before, yet a single look at %their% craft speaks louder than any reputation. When asked about %their% routine or history, %name% casually waves off the questions with a wry smile and a joke. %Their% startling obsession with perfectly balanced daggers and exotic throwing blades makes you wonder if \'juggling\' is merely a convenient cover for something much more shady. | In the sweltering southern bazaars, crowds quickly bore of the everyday sight of simple balls and clubs. To keep the coins flowing, %name% escalated to juggling flaming torches, then curved shamshirs, and finally, vials of volatile alchemical fire. A tragic miscalculation left a merchant\'s silk stall in ashes and several onlookers horribly burned. Fleeing a furious Qadi and a hefty blood-debt, %name% decided a mercenary company offered the safest refuge %they% could think of in the limited time available. | Even for a performer, %name% is bizarre and often erratic, going on at length about the ideas %they% has for new stage plays, sometimes for hours. Such novel ideas found %them% recently in fresh trouble concerning some knives, a target and a young street girl. When pushed for answers all %they% can grumble is \'I did not hit her\' and \'It\'s not true\', yet there has to be a reason why %they% has chosen to abandon %their% previous life for that of a mercenary. | Jaded by a life of performance, %name% retired from physical acts and instead devoted %their% time to writing plays for others. %They% had dreamt about this moment for years, but when push came to shove, %their% audience informed %them% that %their% works were, quite frankly, terrible. Unimpeded by the opinions of the \'uninitiated\', %they% doubled down on writing some of %their% more radical ideas, which culminated with %them% being cast out of %their% home by a mob. | Slathered in the cheap musk of bazaar perfumes, %name% strides around as though %they% was still performing for the Vizier himself and everyone should know %their% name. Once a celebrated entertainer for a southern merchant prince, %their% arrogance grew faster than %their% talent. Overly critical and thin-skinned %themselves%, %name% managed to get on the bad side of almost everyone %they% met, somehow without realising %they% was doing so at all. After throwing %their% bile at the wrong guest, %name% was stripped of %their% silks, beaten and thrown into the streets. In just a few moments %they% destroyed all %their% life\'s work and, still considering %themselves% above it all, without thinking twice set out to find work in a mercenary band, much to the relief of %their% fellow performers. | While the juggling arts are rarely considered lethal, there isn\'t much difference between throwing knives with cruel intent and for the sake of providing joy. Recently, while performing in a sun-baked southern alley, %they% witnessed a violent mugging. Acting on instinct, %name% applied %their% uncanny hand-eye coordination, burying three knives into the juvenile assailants\' throats before they even realized what was coming. This alone wouldn\'t force the street-raised urchin, %name% was to uproot %their% cosy life, but with news naming one of the youngsters as a son of an influential merchant and the local Muhtasib seeking a juggler named as a culprit for the unexplained carnage, %name% wisely decided it was due time for a change of profession.}";
	};

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Southern.cloth_sash]
		]));
	}
});
