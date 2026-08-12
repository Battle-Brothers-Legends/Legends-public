this.legend_legion_centurion_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.LegendLegionCenturion);
		this.m.Name = "Centurion";
		this.m.Icon = "ui/backgrounds/background_legion_centurion.png";
		this.m.BackgroundDescription = "A leader of many, a slave to a few.";
		this.m.GoodEnding = "";
		this.m.BadEnding = "";
		this.m.Excluded = ::Legends.Legion.excludedTraits();

		this.m.ExcludedTalents = [
			// this.Const.Attributes.RangedSkill,
			//this.Const.Attributes.Hitpoints,
			// this.Const.Attributes.Bravery,
			this.Const.Attributes.Fatigue
		];
		// this.m.BackgroundType = this.Const.BackgroundType.Untalented;
		this.m.LastNames = this.Const.Strings.AncientDeadTitles;
		this.m.Level = this.Math.rand(3, 5);
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
	}

	function setGender(_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Muscular}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Muscular, Hairs = ::Const.Hair.CommonMale});
		this.m.Names = _gender ? ::Const.Strings.AncientDeadNamesFemale : ::Const.Strings.AncientDeadNames;
	}

	function onBuildDescription() {
		return "{%name% had once given a lifetime of service to the Empire. In this new life, and new Legion, they pledge their undying loyalty to the Emperor as one of the finest military leaders of their time. | Hailing from the finest noble stock, %name% rose through the Legion's leadership and achieved senior command. Back from beyond, the mission has changed, but their zeal to serve persists. | Few would suspect %name%'s humble roots given their status as one of the finest commanders in the Empire. What life they had before however is long gone, and now, only the Legion remains. | Few would suspect %name%'s humble roots given their status as one of the finest commanders in the Empire. What life they had before however is long gone, and now, only the Legion remains. | Death could not stop %name%. As one of the Empire's most decorated commanders, in ages past their reputation would precede them. Now, they seek to restore their fearsome title as both a leader and killer of men. | To plan, execute, adapt, and triumph in the face of great adversity is %name%'s specialty. Having whet their teeth against some of the Empire's toughest foes, they answer the call for one final mission.} {Even in undeath, %name% wears numerous scars down to the bone. | %name% wears their armour as if it were a second skin. | %name% has an aura of authority about them. | %name% has a commanding presence, even when not on the battlefield. | %name% has witnessed many battles with the scars to prove it.} {Leading from the front, this centurion stands as an inspiring beacon to the Legion, and a terrible demon to its foes. Leading groups of soldiers in extended combats, they can be trusted to fight to the end, and beyond. | Centurions are responsible for commanding troops in battle. Seasoned, grizzled, and beyond loyal, they represent the best of the Empire's fighting troops. Death has little chance of stopping them. | The life of a centurion is one of mixed administration and combat leadership. From directing work around camp, to launching a raid on the enemy's, a centurion's work is dynamic and vital to the Legion's success. | Few men have the mettle for what being a Legion centurion entails. An artist on the battlefield, they paint with troop movements and battle tactics, creating masterpieces of imperial ingenuity, signed with a swathe of enemy dead. | Soldiers need orders. The centurion provides direction and determination to the ranks, leading battles and facing the enemy head-on. | They keep a keen view on who exists and enters camp, even in death where spies would be obvious, they still act as if any newcomer could be an infiltrator. | They always keep several legionaries perpetually building fortifications. Many of which are pointless given the situation — from latrines to irrigation wells.} {They are always pacing around camp, ordering legionaries in charge of logistics to buy more grain. The legionaries pile the grain in the tent, but none touch it thereafter. | Upbeat even in spite of their skeletal form, %name% clearly relishes the opportunity to lead their troops once more. When moods sour and times get tough, they're the first to rally the men into a beaming fervour. | One can tell that %name% worked their way through the Legion's ranks, even if a lifetime ago. They aren't afraid to help with the donkey's work around camp or reminisce with old brothers in arms, sharing tales of their lives and deaths. | A mean streak to boot, and a taste for order that would give the Emperor pause, %name% manifests the rugged discipline of the Legion's finest. They strive for absolute excellence, and expect nothing less from their men. | %name%'s death was a mercy for both their men and the enemy. %name%\'s cruel genius exacted a heavy toll from all who dared to stand against them. Now, with a new life and mission, all will find death's mercy was but a temporary reprieve. | Fear is as alien a concept to %name% as defeat is. Their unsettlingly calm demeanour against seemingly insurmountable odds betrays them as one of the Legion's most dauntless leaders.}";
	}

	function onChangeAttributes() //uses Character_background.nut template (Skeleton)
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendLegionCenturion);
	}

	function onAdded()
	{
		if (this.m.IsNew) {
			::Legends.Traits.grant(this, ::Legends.Trait.LegendFleshless);
		}
		this.character_background.onAdded();

		local actor = this.getContainer().getActor();
		actor.m.ExcludedInjuries = ::Legends.Legion.ExcludedInjures;
		actor.getFlags().add("legion_can_command");  //justifies if this background is subject to the legion command skill
	}

	function adjustHiringCostBasedOnEquipment() //reduces cost for equipment worn on skeletons to zero for recruiting purposes.
	{
		local actor = this.getContainer().getActor();
		actor.m.HiringCost = this.Math.floor(this.m.HiringCost + 500 * this.Math.pow(this.m.Level - 1, 1.5));
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();

		items.equip(::Const.World.Common.pickItem([
			[1, "weapons/ancient/bladed_pike"],
			[1, "weapons/ancient/warscythe"],
			[1, "weapons/ancient/legend_gladius"],
			[1, "weapons/ancient/legend_kopis"],
			[1, "weapons/ancient/crypt_cleaver"]
		], "scripts/items/"));

		items.equip(this.Const.World.Common.pickArmor([
			[2, ::Legends.Armor.Ancient.ancient_plated_scale_hauberk],
			[1, ::Legends.Armor.Ancient.ancient_scale_coat],
			[2, ::Legends.Armor.Ancient.ancient_plate_harness],
			[1, ::Legends.Armor.Ancient.ancient_plated_mail_hauberk]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[2, ::Legends.Helmet.Ancient.ancient_honorguard_helmet],
			[1, ::Legends.Helmet.None]
		]));
	}
});
