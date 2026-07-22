::mods_hookExactClass("skills/backgrounds/caravan_hand_southern_background", function(o)
{
	o.create = function ()
	{
		this.caravan_hand_background.create();
		this.m.Ethnicity = 1;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Superstitious),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Gluttonous),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Fat)
		];
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
	}
	
	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.SouthernFemaleSkinny, Faces = ::Const.Faces.SouthernFemale, Hairs = ::Const.Hair.SouthernFemale, HairColors =::Const.HairColors.Young}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.SouthernSkinny, Faces = ::Const.Faces.SouthernMale, Hairs = ::Const.Hair.SouthernMale, HairColors = ::Const.HairColors.Southern, Beards = ::Const.Beards.Southern}, 90);

		if (_gender != 1) return;
		this.m.GoodEnding = "%name% the once-caravan hand retired from fighting. She used her mercenary money to start a trade-guarding business that specializes in transporting goods through dangerous lands.";
		this.m.BadEnding = "%name% the caravan hand retired back into guarding trade wagons. She died when defending against an ambush by brigands. They took her clothes and left her body in a ditch.";
	}	

	o.onBuildDescription <- function ()	{
		return "{Always the adventurous type, %name% was easily drawn to the life of a caravan hand. | Orphaned by war and pestilence, %name% grew up under the wings of a traveling merchant. | A caravan hand\'s life is tough, but %name% could hardly stand staying in one place for too long. | Though the work is dangerous, being a caravan hand allowed %name% to see the world. | When %their% family and obligations were destroyed by fire, %name% saw no reason not to join a passing caravan. | Hardy and resolute, %name% was the first chosen by a merchant to protect his stock as a caravan hand. | Running away from home, it didn\'t take long for %name% to join and eventually work for a caravan.} {But the trader %they% worked for turned out to be abusive, nary a whip away from being a slave driver. After an intense argument with the man, %name% thought it better to leave before %they% did something awful. | One day, goods went missing and the hand was blamed for it, promptly ending %their% time with the caravan. | But a caravan needs protection for a reason, and an ambush by desert raiders proved why. %name% barely made it out alive. | Years on the road went without a hitch until a new caravan master refused to pay %name%. With just one hand the caravanner punched her boss and grabbed %their% wages. %They% used both legs to run, though. | Caravans are frequently tense places to be. One fateful evening, in a dispute over gambling debts, %they% stove in the head of another traveler. Fearing retribution, %name% was gone before morning. | Sadly, with the expanding war the caravan\'s profits were marginal. %name% was let go as the merchants retired their wagons. | After seeing the foul work of beasts on a fellow caravan, it didn\'t take long for %name% to figure out %their% wages didn\'t quite meet the level of threats around %them%. | But war deprived the caravan of stock and soon its driver took to selling slaves. Appalled, %name% freed as many as %they% could before leaving for good. | Sadly, %their% caravan began to sell human chattel. While the profits were enormous, it garnered the attention of a local militia - and their pitchforks. One ambush later and %name% was running for %their% life.} {Now uncertain of what to do, %they% seeks any opportunity that might come by. | A %person% like %name% is no stranger to danger, making %them% a good fit for any mercenary group. | With %their% caravan days behind %them%, working as a sellsword was just another avenue for adventure and profit. | In %name%\'s mind, being a mercenary is a lot like being a caravanner. Just better paid. | Well versed to traveling, %name% seems like a natural fit to the tasks already befit for a mercenary. | Years of road travel have molded %name% into quite the durable figure. Any group of mercenaries could use more %people% like her.}";
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/bludgeon"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/oriental/light_southern_mace"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/oriental/saif"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Southern.cloth_sash],
			[1, ::Legends.Armor.Southern.padded_vest],
			[1, ::Legends.Armor.Southern.nomad_robe],
			[1, ::Legends.Armor.Southern.thick_nomad_robe]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Southern.southern_head_wrap],
			[1, ::Legends.Helmet.Southern.nomad_head_wrap],
			[1, ::Legends.Helmet.Southern.nomad_leather_cap]
		]))
	}
});