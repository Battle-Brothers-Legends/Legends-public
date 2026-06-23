::mods_hookExactClass("skills/backgrounds/executioner_southern_background", function (o) {
	o.create = function () {
		this.executioner_background.create();
		this.m.Bodies = ::Const.Bodies.SouthernBig;
		this.m.Faces = ::Const.Faces.SouthernMale;
		this.m.Hairs = ::Const.Hair.SouthernMale;
		this.m.HairColors = ::Const.HairColors.Southern;
		this.m.Beards = ::Const.Beards.Southern;
		this.m.BeardChance = 60;
		this.m.Ethnicity = 1;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Superstitious)
		];
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
	}

	o.onBuildDescription <- function () {
		return "{Once an executioner in the many nomad tribes of the South, %name% was banished {for a beheading gone horribly wrong | when it was discovered %they%\'d slain the wrong man | after %they% faked the death of a friend}. Aimless, %they% drifted into %randomcitystate% and resumed %their% trade in service of the viziers. | An executioner, %name% was tasked with beheading, hanging, quartering, and all the other punishments conveyed upon those criminals deemed unworthy of repaying their debts to the Gilder in life, and those who had been given the chance and failed. | %name% worked for %randomvizier% as an executioner, meting out grisly justice to the criminals of the South. | From %their% distinctive hood, it\'s clear %name% is an executioner. From %their% grim affect, it\'s clear %they're% been in the trade for some time.} {In the city states, however, even criminals are more valuable alive than dead, and soon %they% found %themselves% running out of work and out of crowns. | One day %they% was charged with severing the neck of another headsman who had \'ruined\' an execution by allowing the condemned to predict the killing blow and scream. %name% carried out %their% own task in silence, then decided it was time to find a new line of work. | For many years %they% was content with %their% work, but one day %they% was tasked with {hanging a young boy who had stolen food from the market | beheading a beautiful concubine who had displeased her master | drowning an old man too feeble even to stand}. %They% performed %their% duty, but found %they% no longer had a taste for the profession after that. | Though happy enough in %their% role, %they% learned that all of %their% predecessors had eventually been indebted or executed themselves after displeasing %their% employer. Seeing the writing on the wall, %they% began looking for a new line of work.} {Unsure what else to do, %name% decided mercenary work was a good fit for %their% skillset. | Figuring %they%\'d be no less respected as a Crownling, but better paid, %name% now pursues a sellsword\'s career. | Accustomed to blood and blades alike, mercenary work is an obvious next step for %name%. | %name% tried %their% hand at a few occupations before deciding that %their% particular talents were best suited for the bloody, and well-paid, work of a sellsword.}";
	}

	o.onAddEquipment = function () {
		local items = this.getContainer().getActor().getItems();
		local weapons = [
			"weapons/hatchet",
			"weapons/hand_axe",
			"weapons/exesword",
			"weapons/woodcutters_axe",
			"weapons/oriental/two_handed_scimitar",
			"weapons/oriental/two_handed_saif"
		];
		if (::Const.DLC.Wildmen) {
			weapons.extend([
				"weapons/bardiche"
			]);
		}
		items.equip(::new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		items.equip(::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.leather_wraps]
		]));

		items.equip(::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.executioner_hood]
		]));
	}
});
