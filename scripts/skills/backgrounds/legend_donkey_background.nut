this.legend_donkey_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},

	function create() {
		this.character_background.create();
		this.m.ID = ::Legends.Backgrounds.getID(::Legends.Background.LegendDonkey);
		this.m.Name = "Donkey";
		this.m.Icon = "ui/backgrounds/background_donkey.png";
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
		this.m.ExcludedTalents = [
			this.Const.Attributes.RangedSkill,
			this.Const.Attributes.RangedDefense,
			this.Const.Attributes.MeleeDefense
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
		return "{%name% was raised to pull plows on a farm, but was eventually sold to a wandering trader. |  %name% was reared from young days by a traveling merchant. | A donkey's life is tough and %name% has been used for hauling many wares. | Though the work is dangerous, being a caravan donkey allowed %name% to see the world. | When her former owner died, %name% was put up for sale and bought for caravan work. | Hardy and resolute, %name% was the pick of the bunch when local merchants needed new beasts of burden. | Sold from owner to owner, %name% has worked for more caravans than most traders.} {Unfortunately, her most recent owner turned out to be abusive, nary a whip away from being a slave driver. A kindly farmer bought %name% to free her, but when feed became too costly, she was sold once again. | One day, valuable goods went missing. Unfairly blamed for ruining the cargo her her time with the caravan has come to an abrupt end. | The caravans need protection, as an ambush by the hill brigands proved. Amidst the chaos of the attack, %name% barely made it out alive. | Years on the road went without a hitch until a new caravan master died on the road and %name% was left tied to a wagon without food until rescued by a passerby. | Trading caravans are frequent targets for brigands, and in one such raid, as the caravan hands fell, %name% fled into the night. | Sadly, an expanding destroyed local trade routes. With profits drying up, %name% was sold off as the merchants retired their wagons. | After witnessing a terrifying attack of direwolves on their caravan, %name% bolted on her way to in search of a new owner. | When war deprived the merchants of stock, the caravan drivers took to selling the pack animals.  %name% was among the last to be auctioned off. | Tragically, her handlers turned to selling human chattel. While the profits were enormous, it drew the ire of a local militia - and their pitchforks soon followed. After a successful ambush, %name% was running for her life.} {A donkey like %name% is no stranger to danger, making her a good fit for any mercenary group. | With her caravan days behind her, working for a sellsword is just another avenue for oats. | In %name%\'s mind, accompanying mercenaries is a lot like hauling goods a for caravanners with more carrots as a kicker. | Well versed in long-distance traveling, %name% is a natural fit for the hardships of mercenary life. | Years of road travel have molded %name% into a durable pack animal, which any company would be lucky to have.}";
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
		items.setUnlockedBagSlots(0);

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
