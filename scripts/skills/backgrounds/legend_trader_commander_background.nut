this.legend_trader_commander_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_commander_trader";
		this.m.Name = "Trader";
		this.m.Icon = "ui/backgrounds/background_19.png";
		//descriptions gender neutral - no need variants
		this.m.BackgroundDescription = "Traders are not used to hard physical labor or warfare, but they do excel at haggling for good prices.";
		this.m.GoodEnding = "A lover of the sale, %name% the trader couldn\'t stay fighting for long. They eventually left the %companyname% to go out and start their own business. Recently, you got word that they were selling trinkets with the company\'s sigil on them. You specifically told them to do whatever they wanted except just this one thing, but apparently your warning merely fostered the idea. When you went to tell them to stop, they slammed a crown-bulging satchel on a rather ornate table, saying it was your \'cut.\' They sell those trinkets to this day.";
		this.m.BadEnding = "With hard times hitting the %companyname%, many brothers saw fit to return to their old lives. %name% the peddler was no different. Last you heard they got the tar beaten out of them trying to sell stolen wares that \'fell off the wagon\' to the very merchant which they originally belonged.";
		this.m.HiringCost = 60000;
		this.m.DailyCost = 1;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Huge),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.IronJaw),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.IronLungs),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Tough),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Dexterous),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Deathwish),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.LegendMartial),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Loyal)
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;

		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Chivalrous;
		this.m.Level = 2;
		this.m.BackgroundType = this.Const.BackgroundType.Educated;
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[4];
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[4];
		this.m.CustomPerkTree = [
			[
				::Legends.Perk.FastAdaption,
				::Legends.Perk.BagsAndBelts,
				::Legends.Perk.NineLives,
				::Legends.Perk.Pathfinder,
				::Legends.Perk.Student,
				::Legends.Perk.Recover,
				::Legends.Perk.LegendLookout
			],
			[
				::Legends.Perk.CoupDeGrace,
				::Legends.Perk.Dodge,
				::Legends.Perk.FortifiedMind,
				::Legends.Perk.HoldOut,
				::Legends.Perk.QuickHands,
				::Legends.Perk.RallyTheTroops,
				::Legends.Perk.SteelBrow
				// ::Legends.Perk.LegendComposure

			],
			[
				::Legends.Perk.Backstabber,
				::Legends.Perk.Anticipation,
				::Legends.Perk.LegendTacticalManeuvers,
				::Legends.Perk.Taunt,
				::Legends.Perk.LegendAthlete,
				::Legends.Perk.LegendBarterConvincing
			],
			[
				::Legends.Perk.SpecCrossbow,
				::Legends.Perk.SpecPolearm,
				::Legends.Perk.SpecThrowing,
				::Legends.Perk.SpecDagger,
				::Legends.Perk.LegendEfficientPacking,
				::Legends.Perk.LegendAmmoBinding,
				::Legends.Perk.LegendMedPackages,
				::Legends.Perk.LegendToolsDrawers,

			],
			[
				::Legends.Perk.Overwhelm,
				::Legends.Perk.ReachAdvantage,
				::Legends.Perk.LoneWolf,
				::Legends.Perk.Underdog,
				::Legends.Perk.LegendBarterTrustworthy,
			],
			[
				::Legends.Perk.HeadHunter,
				::Legends.Perk.Nimble,
				::Legends.Perk.BattleForged,
				::Legends.Perk.LegendRebound,
				::Legends.Perk.LegendDangerPay,
				::Legends.Perk.LegendPaymaster,
			],
			[
				::Legends.Perk.Fearsome,
				::Legends.Perk.Duelist,
				::Legends.Perk.Indomitable,
				::Legends.Perk.LegendSkillfulStacking,
				::Legends.Perk.LegendBribe,
				::Legends.Perk.LegendBarterGreed
			],
			[],
			[],
			[],
			[]
		];
	}

	//Default Male
	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}



	function onBuildDescription()
	{
		return "This is your commander, when they die it is game over. {House to house, | Once a proud merchant, now | An annoyance to most, | In tough times, everyone has to scrape by somehow, hence why | Not of the trades, but instead of trade itself,} %name% is a mere peddler. {Dancing, singing, boasting or acting a king, anything to make that sale. | Pushy and unrelenting, their tenacity is admirable. | %name% will try to sell off a rusty bucket for a helm once worn by kings. This trader will sell anything. | %name% will make you crave things you never knew you wanted. No refunds, though. | %name% used to make a decent living selling {used carts | pots, pans and jars }, until fierce competition ended the business - with a broken arm.} {Self marketing is what this frail merchant does best, though few believe the pitch about having \'Great swordsmanship and resolute bravery\'. | Supposedly handed out \'coupons\' for \'services\', whatever those are. %name% is chippy, though, and any outfit these days could use a warm body no matter its real value. | If hired, %name% promises, you\'ll get a special discount on a virility enhancing potion. | %name% lowers their voice and tells you they\'ve got a great deal on rusted arrow tips, just for you. The merchant looks disappointed at your lack of interest. | This merchant knows a man who knows a man who knows a man. All three strangers potentially better at fighting than %name%. | A shame a war can\'t be fought with words these days. %name% would be unstoppable.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				30,
				30
			],
			MeleeSkill = [
				-10,
				-9
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				2,
				7
			],
			RangedDefense = [
				2,
				7
			],
			Initiative = [
				30,
				30
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();
		actor.setTitle(this.Const.Strings.PeddlerTitles[this.Math.rand(0, this.Const.Strings.PeddlerTitles.len() - 1)]);
		::Legends.Traits.grant(this, ::Legends.Trait.Fat);
		//this.m.Container.add(this.new("scripts/skills/traits/loyal_trait"));
		//this.m.Container.add(this.new("scripts/skills/perks/perk_legend_bribe"));
		//this.m.Container.add(this.new("scripts/skills/perks/perk_legend_roster_2"));
		//this.m.Container.add(this.new("scripts/skills/perks/perk_legend_roster_4"));

	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/legend_tipstaff"));
		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.linen_tunic]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.feathered_hat]
		]));
	}
});
