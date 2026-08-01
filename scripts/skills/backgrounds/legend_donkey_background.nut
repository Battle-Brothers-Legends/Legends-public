this.legend_donkey_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},

	function create() {
		this.character_background.create();
		this.m.ID = ::Legends.Backgrounds.getID(::Legends.Background.LegendDonkey);
		this.m.Name = "Donkey";
		this.m.Icon = "ui/backgrounds/donkey.png";
		this.m.BackgroundDescription = "Donkeys are generally patient and deliberate in their actions. Can\'t use weapons, shields, ammunition or armor. The donkey does not seem bothered by these limitations. %They% has a huge appetite and will eat anything. Better bring extra provisions and expect %them% to leave fast if you ever run out of provisions entirely.";
		this.m.GoodEnding = "%name% the donkey retired to a lovely green paddock. %They% spent their days loafing about and eating carrots fed to %them% by local children.";
		this.m.BadEnding = "%name% the donkey was sold to a foul-tempered trader who did not spare the rod. Their caravan was attacked by orcs and the remains of %name% were never found.";
		this.m.HiringCost = 5000;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Addict),
			::Legends.Traits.getID(::Legends.Trait.Drunkard),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.LegendAmbitious),
			::Legends.Traits.getID(::Legends.Trait.LegendSeductive),
			::Legends.Traits.getID(::Legends.Trait.LegendGiftOfPeople),
			::Legends.Traits.getID(::Legends.Trait.LegendDoubleTongued),
			::Legends.Traits.getID(::Legends.Trait.LegendDeathlySpectre),
			::Legends.Traits.getID(::Legends.Trait.LegendSureshot),
			::Legends.Traits.getID(::Legends.Trait.Superstitious),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.IronLungs),
			::Legends.Traits.getID(::Legends.Trait.Spartan),
			::Legends.Traits.getID(::Legends.Trait.Fragile)
		];
		this.m.Titles = [
			"the Ass",
			"the Donkey",
			"the Jackass"
		];
		this.m.Faces = this.Const.Faces.Donkey;
		this.m.Hairs = this.Const.Hair.None;
		this.m.HairColors = this.Const.HairColors.None;
		this.m.Bodies = this.Const.Bodies.Donkeys;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.BackgroundType = this.Const.BackgroundType.Untalented | this.Const.BackgroundType.Stabled;
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[4];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[5];
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[4];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[5];
		this.m.ExcludedTalents = [
			this.Const.Attributes.RangedSkill,
			this.Const.Attributes.RangedDefense,
			this.Const.Attributes.MeleeDefense
		];
		this.m.Modifiers.Terrain = [
			0.0, // ?
			0.0, //ocean
			0.025, //plains
			0.01, //swamp
			0.01, //hills
			0.01, //forest
			0.01, //forest
			0.01, //forest_leaves
			0.01, //autumn_forest
			0.01, //mountains
			0.0, // ?
			0.025, //farmland
			0.011, // snow
			0.015, // badlands
			0.015, //highlands
			0.025, //steppes
			0.0, //ocean
			0.01, //desert
			0.025 //oasis
		];
		this.m.CustomPerkTree = [
			[
				this.Legends.Perk.Colossus,
				this.Legends.Perk.NineLives,
				this.Legends.Perk.Pathfinder,
				this.Legends.Perk.Steadfast,
				this.Legends.Perk.BagsAndBelts,
				this.Legends.Perk.Recover
			],
			[
				this.Legends.Perk.Dodge,
				this.Legends.Perk.HoldOut,
				// this.Legends.Perk.LegendComposure,
				this.Legends.Perk.LegendAlert,
				this.Legends.Perk.LegendOnslaught,
				this.Legends.Perk.SteelBrow,
				this.Legends.Perk.LegendRecuperation
			],
			[
				this.Legends.Perk.Anticipation,
				this.Legends.Perk.Rotation,
				this.Legends.Perk.LegendPeaceful,
				this.Legends.Perk.Taunt,
				// this.Legends.Perk.LegendSprint
			],
			[
				this.Legends.Perk.LegendEfficientPacking,
				this.Legends.Perk.LegendAmmoBinding,
				this.Legends.Perk.LegendMedPackages,
				this.Legends.Perk.LegendToolsDrawers
			],
			[
				this.Legends.Perk.LoneWolf,
				this.Legends.Perk.Footwork,
				this.Legends.Perk.LegendLastStand,
				this.Legends.Perk.LegendBlendIn,
				this.Legends.Perk.Underdog
			],
			[
				this.Legends.Perk.Nimble,
				this.Legends.Perk.LegendRebound,
				this.Legends.Perk.LegendPacifist,
				this.Legends.Perk.LegendSkillfulStacking,
				this.Legends.Perk.LegendMuscularity,
			],
			[
				this.Legends.Perk.Fearsome,
				// this.Legends.Perk.Stalwart,
				this.Legends.Perk.LegendAmmoBundles,
				this.Legends.Perk.LegendMedIngredients,
				this.Legends.Perk.LegendToolsSpares,
			],
			[],
			[],
			[],
			[]
		];
	}

	//Default Male
	function setGender(_gender = -1) {
		if (_gender == -1) {
			_gender = this.randomizeHumanGender();
		}

		if (_gender != 1) {
			return;
		}

		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	function getTooltip() {
		local ret = this.character_background.getTooltip();
		local stashModifier = this.m.Modifiers.Stash + this.getModifier();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Cannot use any equipment"
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Eats more than a regular person"
		});
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Is content for with being in reserve"
		});
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Donkeys provide [color=%positive%]+" + stashModifier + "[/color] stash space, [color=%positive%]+" + this.m.Modifiers.Ammo + "[/color] maximum ammunition storage, [color=%positive%]+" + this.m.Modifiers.Meds + "[/color] maximum medicine capacity,  [color=%positive%]+" + this.m.Modifiers.ArmorParts + "[/color] maximum armor parts. These can be increased with perks (may take a moment for the increases to register). "
		});
		return ret;
	}

	function onBuildDescription() {
		return "{%name% was raised to pull plows on a farm. |  %name% was reared by a traveling merchant. | A donkey's life is tough %name% has been used for many things. | Though the work is dangerous, being a caravan donkey allowed %name% to see the world. | When her former owner died, %name% was put up for sale. | Hardy and resolute, %name% was the pick of the bunch. | Sold from owner to owner %name% has worked for more caravans than most traders.} {But the trader she worked for turned out to be abusive, nary a whip away from being a slave driver. A farmer bought %name% to free her, but eventually the cost got too great and she was sold again. | One day, goods went missing and she was blamed for it, promptly ending her time with the caravan. | But a caravan needs protection for a reason, and an ambush by brigands proved why. %name% barely made it out alive. | Years on the road went without a hitch until a new caravan master died on the road and %name% was left tied to a wagon without food until rescued. | Caravans are frequently attacked, and in one battle as the caravan hands fell %name% ran into the night. | Sadly, with the expanding war the caravan\'s profits were marginal. %name% was let go as the merchants retired their wagons. | After seeing the foul work of beasts on a their caravan, it didn\'t take long for %name% to find a new owner. | But war deprived the caravan of stock and soon its driver took to selling the donkeys.  %name% was among the last to be sold. | Sadly, her caravan began to sell human chattel. While the profits were enormous, it garnered the attention of a local militia - and their pitchforks. One ambush later and %name% was running for her life.} {Now %name% is being sold by a farmer for being too stubborn  | A donkey like %name% is no stranger to danger, making her a good fit for any mercenary group. | With her caravan days behind her, working for a sellsword was just another avenue for oats. | In %name%\'s mind, being a mercenary is a lot like being a caravanner. Just more carrots. | Well versed to traveling, %name% seems like a natural fit to the tasks already befit for a mercenary. | Years of road travel have molded %name% into quite the durable figure. Any group of mercenaries could use more donkeys like her.}";
	}

	function onChangeAttributes() {
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendDonkey);
	}

	function onUpdate(_properties) {
		_properties.HitpointsMult *= (1 + ::World.Assets.m.ProfessionEffect.LegendHippology);
		_properties.DailyFood += 4.0;
		_properties.IsContentWithBeingInReserve = true;
	}

	function getModifier() {
		return ::Math.round((1 + ::World.Assets.m.ProfessionEffect.LegendHippology) * 10);
	}

	function onAdded() {
		local actor = this.getContainer().getActor();
		if (this.m.IsNew) {
			actor.getFlags().set("donkey", true);
		}
		if (!this.m.Container.hasActive(::Legends.Active.LegendDonkeyKick)) {
			::Legends.Actives.grant(this, ::Legends.Active.LegendDonkeyKick);
		}
		local items = actor.getItems();
			//ineloquent solution for forcing the item assigned to any of these slots via hotkey to be unassigned and returned to ground or stash. We squish this code later.
			//Note that 'item.unequip();' does not work.
		if (items.getItemAtSlot(this.Const.ItemSlot.Offhand))
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
			item.drop();
		}

		if (items.getItemAtSlot(this.Const.ItemSlot.Mainhand))
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
			item.drop();
		}

		if (items.getItemAtSlot(this.Const.ItemSlot.Head))
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Head);
			item.drop();
		}

		if (items.getItemAtSlot(this.Const.ItemSlot.Body))
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Body);
			item.drop();
		}

		if (items.getItemAtSlot(this.Const.ItemSlot.Ammo))
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Ammo);
			item.drop();
		}

		if (items.getItemAtSlot(this.Const.ItemSlot.Accessory))
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Accessory);
			item.drop();
		}

		items.getData()[this.Const.ItemSlot.Offhand][0] = -1;
		items.getData()[this.Const.ItemSlot.Mainhand][0] = -1;
		items.getData()[this.Const.ItemSlot.Head][0] = -1;
		items.getData()[this.Const.ItemSlot.Body][0] = -1;
		items.getData()[this.Const.ItemSlot.Ammo][0] = -1;
		items.getData()[this.Const.ItemSlot.Accessory][0] = -1;
		actor.getItems().setUnlockedBagSlots(0);

		this.character_background.onAdded();
	}

	function onAddEquipment() {
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Hitpoints] = 3;
		talents[this.Const.Attributes.Fatigue] = 3;
		this.getContainer().getActor().fillTalentValues(1, true);
	}
});
