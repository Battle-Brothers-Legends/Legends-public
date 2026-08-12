this.legend_companion_melee_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.LegendCompanionMelee);
		this.m.Name = "Companion";
		this.m.Icon = "ui/traits/trait_icon_32.png";
		this.m.BackgroundDescription = "This one has lost all interest in glory and gold. With nothing else to prove but to %themselves%.";
		this.m.GoodEnding = "After {not much  more time | much more time later | a lifetime adrift | a short while | a few more months} after your retirement, %name% found {interest | %their% calling with | some hope with | work with} a {preacher | thief | vagabond | wildman | wise woman | crusader | odd trio of kids | haughty nobleman | ranger | people\'s militia | cultist band | northern raiding party | group of escaped slaves | hunting party of manhunters}, %their% time with you taught %them% {everything | most of what | all | a bit of what} %they% needed to survive in %their% new employment. %They% never spoke your name, but {%their% memory of you never faded | %they% go on to greater things in your memory}.";
		this.m.BadEnding = "Does it matter what happens to a single %person%? As skilled as %name% was, %they% never made %their% mark with your early departure from %companyname%.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.FearGreenskins),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.LegendSlack),
			::Legends.Traits.getID(::Legends.Trait.LegendDoubleTongued),
			::Legends.Traits.getID(::Legends.Trait.Clumsy)
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.RangedSkill
		];
		this.m.Ethnicity = this.Math.rand(0, 2);
	}

	function setGender(_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		if (this.m.Ethnicity == 0) {
			_gender ? this.setBodyCharacteristics(_gender) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Muscular, Hairs = ::Const.Hair.CommonMale}, 60);
		}
		else if (this.m.Ethnicity == 1) {
			_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.SouthernFemaleMuscular, Faces = ::Const.Faces.SouthernFemale, Hairs = ::Const.Hair.SouthernFemale, HairColors =::Const.HairColors.Young}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Gladiator, Faces = ::Const.Faces.SouthernMale, Hairs = ::Const.Hair.SouthernMale, HairColors = ::Const.HairColors.Southern, Beards = ::Const.Beards.Southern}, 60);
			this.m.Names = this.Const.Strings.SouthernNames;
			this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		}
		else if (this.m.Ethnicity == 2) {	
			_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.AfricanFemaleMuscular, Faces = ::Const.Faces.AfricanFemale, Hairs = ::Const.Hair.SouthernFemale, HairColors =::Const.HairColors.African}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.AfricanGladiator, Faces = ::Const.Faces.AfricanMale, Hairs = ::Const.Hair.SouthernMale, HairColors = ::Const.HairColors.African, Beards = ::Const.Beards.Southern}, 60);
			this.m.Names = this.Const.Strings.SouthernNames;
			this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		}
	}

	function onBuildDescription()
	{
		return "{Unnaturally skilled, | Born almost a master already, | Skilled enough to be considered supernatural,} {%name% has worked hard to refine their natural talent. | %name% has managed to stay above ground by honing their natural skill. | %name% claims their skill is as natural as yours.} {Eitherway, %they% demonstrates a honed mind and body to match. | They twirl a blade with an ease that would take years for you to learn yourself. | Hailing from %randomtown%, they have gone far and wide to test their skills. | Urged by %their% parents to stay away from knights and mercenaries, they took time to travel and see the world. | One thing has led to another, %they% can barely recall what led them here in the first place.} {With no interest in work for crowns, %name% has found it fitting to join you on your journey. | Likely to be used as fodder, bait or a shield made of flesh by any mercenary company, %name% decided to stick with you instead. | %name% has much more to learn still, and your journey through the lands is the best way to test their skills.}";
	}

	function onChangeAttributes()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendCompanionMelee);
	}

	function onAdded() // enables relationships
	{
		if (this.m.IsNew)
			::Legends.Traits.grant(this, ::Legends.Trait.LegendLWRelationship);
		this.character_background.onAdded();
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");

		if (this.Math.rand(1, 100) <= 75)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 75)
		{
			tattoo_head.setBrush("scar_02_head");
			tattoo_head.Visible = true;
		}
	}

	function onAddEquipment()
	{
		//---
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 1;
		talents[this.Const.Attributes.MeleeDefense] = 1;
		this.getContainer().getActor().fillTalentValues(2, true);
		//---
		local items = this.getContainer().getActor().getItems();
		local r;

		r = this.Math.rand(0, 16);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/legend_infantry_axe"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/boar_spear"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/legend_zweihander"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/oriental/polemace"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/oriental/saif"));
		}
		else if (r == 5)
		{
			items.equip(this.new("scripts/items/weapons/bardiche"));
		}
		else if (r == 6)
		{
			items.equip(this.new("scripts/items/weapons/falchion"));
			items.equip(this.new("scripts/items/shields/heater_shield"));
		}
		else if (r == 7)
		{
			items.equip(this.new("scripts/items/weapons/hand_axe"));
			items.equip(this.new("scripts/items/tools/throwing_net"));
		}
		else if (r == 8)
		{
			items.equip(this.new("scripts/items/weapons/bardiche"));
		}
		else if (r == 9)
		{
			items.equip(this.new("scripts/items/weapons/legend_ranged_flail"));
		}
		else if (r == 10)
		{
			items.equip(this.new("scripts/items/weapons/legend_swordstaff"));
		}
		else if (r == 11)
		{
			items.equip(this.new("scripts/items/weapons/longaxe"));
		}
		else if (r == 12)
		{
			items.equip(this.new("scripts/items/weapons/morning_star"));
			items.equip(this.new("scripts/items/shields/kite_shield"));
		}
		else if (r == 13)
		{
			items.equip(this.new("scripts/items/weapons/scramasax"));
		}
		else if (r == 14)
		{
			items.equip(this.new("scripts/items/weapons/pike"));
		}
		else if (r == 15)
		{
			items.equip(this.new("scripts/items/weapons/warfork"));
		}
		else if (r == 16)
		{
			items.equip(this.new("scripts/items/weapons/shortsword"));
			items.equip(this.new("scripts/items/shields/legend_tower_shield"));
		}

		local outfits = [
			[1, ::Legends.Outfit.traze_northern_mercenary_outfit_00],
			[1, ::Legends.Outfit.mercenary_infantry_outfit_00],
			[1, ::Legends.Outfit.mercenary_infantry_outfit_01],
			[1, ::Legends.Outfit.mercenary_spearman_outfit_00],
			[1, ::Legends.Outfit.mercenary_spearman_outfit_01],
			[1, ::Legends.Outfit.mercenary_leader_outfit_uncommon_00],
			[1, ::Legends.Outfit.mercenary_leader_outfit_00],
			[1, ::Legends.Outfit.southern_knight_outfit_00],
			[1, ::Legends.Outfit.brown_hedgeknight_outfit_00],
			[1, ::Legends.Outfit.red_bandit_leader_outfit_00],
			[1, ::Legends.Outfit.mercenary_billman_outfit_00]
		];

		foreach (item in this.Const.World.Common.pickOutfit(outfits)) {
			items.equip(item)
		}
	}
});
