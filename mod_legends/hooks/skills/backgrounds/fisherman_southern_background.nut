::mods_hookExactClass("skills/backgrounds/fisherman_southern_background", function(o)
{
	o.create = function ()
	{
		this.fisherman_background.create();
		this.m.Ethnicity = 1;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Superstitious),
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.Paranoid),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Fat)
		];
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		if (this.m.Ethnicity == 1) {
			_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.SouthernFemaleMuscular, Faces = ::Const.Faces.SouthernFemale, Hairs = ::Const.Hair.SouthernFemale, HairColors =::Const.HairColors.Young}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.SouthernSkinny, Faces = ::Const.Faces.SouthernMale, Hairs = ::Const.Hair.SouthernMale, HairColors = ::Const.HairColors.Southern, Beards = ::Const.Beards.Southern}, 90);
		}
		else if (this.m.Ethnicity == 2) {	
			_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.AfricanFemaleMuscular, Faces = ::Const.Faces.AfricanFemale, Hairs = ::Const.Hair.SouthernFemale, HairColors =::Const.HairColors.African}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.AfricanMale, Faces = ::Const.Faces.AfricanMale, Hairs = ::Const.Hair.SouthernMale, HairColors = ::Const.HairColors.African, Beards = ::Const.Beards.Southern}, 90);
		}
	}

	o.onBuildDescription <- function () {
		return "{%name% loved the sea and the serenity of fishing alone on the water | Ironically, %name% always hated the water, but became a fisher after %their% father and %their% father\'s father | %name% was a strong and able fisher | %name% was content with being a fisher | %name% always had a lucky hand in finding the best fishing grounds and catching the fattest fish}. As long as there was no storm, %they% was out there, fishing, day in and out. {Sadly, %their% fishing cabin burned to the ground while %they% was out at sea. | But disaster struck as %they% lost %their% best friend at sea when a storm suddenly came up, leaving %them% with a badly damaged boat and no one to sail out with. | But disaster struck when %their% %partner% died during in an accident, shattering all what %they% held dear. | After being unable pay %their% debts for some time, however, %their% boat was taken from %them% by a merciless loan shark. | It was after %they% strangled %their% %partner% in a fit of rage that %they% lost all interest in the fishing trade. | Much to %their% dismay, for almost a whole summer most of the fish %they% caught was already dead and rotten inside. | It was after a priest of the gods told %name% that the life of a fisher was not what they desired of %them%, but that they wished for %them% to spill blood in their name, that %they% would set %their% eyes on another trade.} Visiting the tavern one evening, a new opportunity presented itself with the promise of coin for dangerous work.";
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}

		items.equip(this.new("scripts/items/tools/throwing_net"));
		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.sackcloth],
			[1, ::Legends.Armor.Southern.cloth_sash]
		]));

		local helm =this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Southern.southern_head_wrap]
		]);
		items.equip(helm);
	}
});