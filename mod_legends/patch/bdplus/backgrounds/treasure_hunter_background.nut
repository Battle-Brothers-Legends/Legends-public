::mods_hookExactClass("skills/backgrounds/treasure_hunter_background", function(o) {
	o.getTooltip = @() this.character_background.getTooltip();

	o.onBuildDescription = @() "{In %their% youth, %name% distracted %themselves% from ever-present hunger with wonderous tales the nomads weaved of great treasures lost in the desert sands. As an adult, %they% distracts %themselves% by chasing those treasures. | A treasure hunter, %name% has never stayed in one place for too long, always chasing after the next rumor or folktale in search of riches. | Legends speak of a great many artifacts and relics lost to the wilderness. To some these are mere fanciful myths, but to treasure hunters like %name% they\'re a clue to the next payday. | As a %child%, %name% was warned of the many dangers within lost vaults and ancient crypts. As a %person%, %they%\'s far more afraid of starvation, and so %they% ventures off in search of unclaimed treasures. | %name% is a treasure hunter, one of the many adventurous spirits that raom the sands in search of treasure and lost riches.} {%They% was always a self-assured loner, taking both danger and reward solely upon %their% own shoulders. %Their% most recent tomb expedition changed %their% mind, though %they% won\'t elaborate on what %they% saw down there. | %They% was not alone in these pursuits, however, and developed a particularly bitter rivalry with a nomad tribe. After barely escaping an ambush they set for %them%, %they%\'s started to consider other careers. | One day %they% discovered a tomb and full of untold riches. The next day, %they% discovered it was that of the vizier\'s ancestor. The day after that, %they% discovered wealth means little if you can\'t carry it with you on the road. | %Their% bronze skin, silver tongue, and golden jewelry made %them% popular with the ladies. A little too popular, perhaps, as attention from a concubine in the vizier\'s harem now has %them% on the run. | One day %they% discovered what seemed to be a whole city-state lost in the sands. Exploring the place, %they% learned a terrible truth and decided it was time to leave the South. %They% refuses to share more.} {While unaccustomed to wielding a blade, %name% has faced plenty of danger before and can hold %their% ground in a shieldline. Probably. | Seeking protection in the company of hardened warriors, %name% now hopes to join a mercenary company. | Deciding that the ruins of yore hold too many dangers for one %person% alone to face, %name% now seeks %their% fortune as a crownling. | Though adorned in golden baubles and jeweled accessories, %name%\'s dusty boots and tattered cloak show %their% true nature. Perhaps the life of a sellsword would suit %them%? | Wondering if %they% shouldn\'t seek the gold of the living rather than the dead, %name% now finds %themselves% considering life as a crownling.}";

	o.setGender <- function (_gender = -1) {
		if (_gender == -1)
			_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);
		if (_gender != 1)
			return;

		this.m.GoodEnding = "You weren\'t sure how a woman like %name% would fare as a mercenary, with her head more full of fantasies about lost riches than aptitude for combat. The treasure hunter surprised you, though, seeming to have found a different sort of wealth in claiming glory alongside the %companyname%. From what you hear she\'s decided to forge a name for herself such that her own equipment will be regarded the sort of legendary treasure she once sought.";
		this.m.BadEnding = "For all the romanticism of delving into the ruins of old and coming out with ancient riches, the fact of the matter is that most expeditions for lost wealth turn up nothing at all, and most treasure hunters are one bad haul away from becoming brigands. Unfortunately, %name% was no exception. With the %companyname% falling on hard times and the treasure hunter having failed to secure riches now in two professions, the wpman left the company and turned to raiding merchants on the road. Last you heard, she\'s on the run after a caravan guard cut off her hand.";

		this.m.Faces = ::Const.Faces.SouthernFemale;
		this.m.Hairs = ::Const.Hair.SouthernFemale;
		this.m.HairColors = ::Const.HairColors.SouthernYoung;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = ::Const.Bodies.SouthernFemale;
		this.m.Names = ::Const.Strings.SouthernFemaleNames;
		this.addBackgroundType(::Const.BackgroundType.Female);
	}

	local onAddEquipment = o.onAddEquipment;
	o.onAddEquipment = function () {
		onAddEquipment();
		local items = this.getContainer().getActor().getItems();

		local body = items.getItemAtSlot(::Const.ItemSlot.Body);
		if (body != null)
			items.unequip(body);
		items.equip(::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Southern.cloth_sash],
			[1, ::Legends.Armor.Southern.padded_vest],
			[1, ::Legends.Armor.Southern.linothorax]
		]));

		local head = items.getItemAtSlot(::Const.ItemSlot.Head);
		if (head != null)
			items.unequip(head);
		items.equip(::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Southern.southern_head_wrap],
			[1, ::Legends.Helmet.Southern.nomad_head_wrap],
			[1, ::Legends.Helmet.Southern.leather_head_wrap],
			[1, ::Legends.Helmet.None]
		]));
	}
});


