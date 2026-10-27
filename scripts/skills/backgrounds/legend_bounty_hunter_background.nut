this.legend_bounty_hunter_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},

	function create() {
		this.character_background.create(); //—
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.LegendBountyHunter); //only for solo assassin origin
		this.m.BackgroundDescription = "Bounty Hunters are solitary in nature who prefer more direct means to that of assassins. Anyone who is brave enough to walk the roads and take coin alone is either a fool or has more than meets the eye to them";
		this.m.GoodEnding = "%name% stayed with the company a while longer after you left, eventually retiring to a quieter life. %They% settled in the mountains and discovered a hidden talent for raising wolves. %They% lived a long life separated from those %they% once hunted, surrounded by a new family of %their% own.";
		this.m.BadEnding = "Like the shifting sands, %name% quickly moved elsewhere after the company collapsed. %They% found it difficult to return to %their% craft after making so many enemies in both the north and the south. Standing alone once again, one too many killers sent in the night eventually wore %them% down. Like %their% past, %they% simply vanished into the background.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Irrational),
			::Legends.Traits.getID(::Legends.Trait.LegendNyctophobia),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Hesitant),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.LegendSeductive),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Optimist),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.LegendCharming),
		];
		this.m.Titles = [
			"the Mancatcher",
			"the Hunter",
			"the Ruthless",
			"the Bounty Hunter",
			"the Brutal",
			"the Cruel",
			"the Unforgiving",
			"the Merciless",
			"the Tracker",
			"the Catcher",
			"the Heartless",
			"the Swine"
		];
		this.m.Ethnicity = 1;
		this.m.Names = ::Const.Strings.SouthernNames;
		this.m.LastNames = ::Const.Strings.SouthernNamesLast;
		this.m.BackgroundType = ::Const.BackgroundType.Outlaw;

		this.m.Level = ::Math.rand(3, 6);
	}

	function setGender(_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		this.setBodyCharacteristics(_gender, _gender ? {
			Bodies = ::Const.Bodies.SouthernFemale,
			Faces = ::Const.Faces.SouthernFemale,
			Hairs = ::Const.Hair.SouthernFemale,
			HairColors = ::Const.HairColors.Young
		} : {
			Bodies = ::Const.Bodies.SouthernThick,
			Faces = ::Const.Faces.SouthernMale,
			Hairs = ::Const.Hair.SouthernMale,
			HairColors = ::Const.HairColors.Southern,
			Beards = ::Const.Beards.Southern
		}, 90);
	}

	function getTooltip() {
		local ret = this.character_background.getTooltip();
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/chance_to_hit_head.png",
			text = "[color=%positive%]+10%[/color] Chance To Hit Head"
		});
		return ret;
	}

	function onBuildDescription() {
		return "{The growing number of thieves, outlaws and miscreants creates steady work for those who wish to put their lives on the line. | From the noble houses to the gilded southern states, everyone wants someone else dead or missing at the end of the day. | A profession attempted by many but mastered by few — bounty hunters have made a living on catching dangerous people. | The steady growth of cities always makes way for new work, and the work involved in catching those who do not wish to be found has been perfected into an art form by %name%.} {Their profession transcends that of the manhunters, who have become weak catching those who cannot fight back. | Ever curious, %name% is more of a walking toolkit than a person — %their% knives, vials, ropes and other assorted implements mark that of a character who veers between paranoid and well prepared. | %They% bears scars of past contracts but assures you that nobody has escaped %them% yet. | Surprisingly educated, %name% is adept at identifying what direction the wind is blowing, when the next rain will fall and how many steps it would take before an average man collapses from exhaustion.} {Mercenary work for %them% is what %they% do normally, but perhaps with more distractions and shorter marches. | While tough, %name% is calm and reserved enough to make anyone feel uneasy. | While %their% past is a mystery, %their% skill set is impossible to ignore. Having %them% on the payroll is a small price to pay to avoid meeting %them% as an adversary down the line. | %name% treads a fine line between upholding a contract at all costs and hunting down even the lowliest nomad or beggar for coin. | Many see bounty hunters as no better than manhunters. The difference being that nobody would admit it openly to a bounty hunter.}";
	}

	function updateAppearance() {
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush) {
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
		}
	}

	function onChangeAttributes() {
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendBountyHunter);
	}

	function onAddEquipment() {
		local items = this.getContainer().getActor().getItems();

		items.equip(::Legends.Items.pickItem([
			[1, "weapons/battle_whip"],
			[1, "weapons/oriental/heavy_southern_mace"],
			[1, "weapons/oriental/saif"],
			[1, "weapons/oriental/swordlance"],
			[1, "weapons/oriental/two_handed_saif"]
		], "scripts/items/"));

		if (items.hasEmptySlot(::Const.ItemSlot.Offhand)) {
			items.equip(::Legends.Items.pickItem([
				[1, "shields/buckler_shield"],
				[1, "tools/throwing_net"],
				[1, "tools/daze_bomb_item"],
				[2, null]
			], "scripts/items/"));
		}

		items.addToBag(::Legends.Items.pickItem([
			[1, "tools/throwing_net"],
		], "scripts/items/"));

		items.equip(::Legends.Items.pickArmor([
			[1, ::Legends.Armor.Southern.assassin_robe],
			[1, ::Legends.Armor.Southern.cloth_sash],
			[1, ::Legends.Armor.Southern.blade_dancer_armor_00]
		]));

		items.equip(::Legends.Items.pickHelmet([
			[1, ::Legends.Helmet.Southern.assassin_face_mask],
			[1, ::Legends.Helmet.Standard.theamson_barbute_helmet],
			[1, ::Legends.Helmet.Southern.blade_dancer_helmet_00]
		]));
	}

	function onUpdate(_properties) {
		this.character_background.onUpdate(_properties);
		_properties.HitChance[::Const.BodyPart.Head] += 10;
	}
});
