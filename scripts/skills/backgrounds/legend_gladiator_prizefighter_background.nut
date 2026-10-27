this.legend_gladiator_prizefighter_background <- this.inherit("scripts/skills/backgrounds/gladiator_background", {
	m = {},
	function create() {
		this.gladiator_background.create();
		this.m.BackgroundDescription = "Gladiator Prizefighters cost a lot of coin, but their time exchanging punches in the arena has made them tough as nails and fit as a butcher\'s dog.";
	}

	function onChangeAttributes() {
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendGladiatorPrizefighter);
	}

	function getTooltip() {
		local ret = this.character_background.getTooltip();
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "[color=%positive%]5%[/color] bonus damage to [color=#400080]Hand to Hand[/color] and [color=#400080]Choke[/color]"
		});
		return ret;
	}

	function onAnySkillUsed(_skill, _targetEntity, _properties) {
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.LegendChoke) || _skill.getID() == ::Legends.Actives.getID(::Legends.Active.HandToHand)) {
			_properties.DamageTotalMult *= 1.05;
		}
	}

	function onAddEquipment() {
		local actor = this.getContainer().getActor();
		actor.setVeteranPerks(3);
		local items = actor.getItems();

		items.equip(::Legends.Items.pickItem([
			[2, "weapons/oriental/qatal_dagger"],
			[1, "weapons/legend_katar"],
			[3, null]
		], "scripts/items/"));

		items.equip(::Legends.Items.pickItem([
			[1, "accessory/gloves/legend_cestus_item"]
		], "scripts/items/"));

		items.equip(::Legends.Items.pickItem([
			[1, "tools/throwing_net"],
			[2, null]
		], "scripts/items/"));

		items.equip(::Legends.Items.pickHelmet([
			[1, ::Legends.Helmet.Southern.gladiator_helmet, ::Math.rand(13, 15)],
			[1, ::Legends.Helmet.None]
		]));

		local a = ::Legends.Items.pickArmor([
			[1, ::Legends.Armor.Southern.gladiator_harness]
		]);
		a.setUpgrade(::new("scripts/items/legend_armor/armor_upgrades/legend_light_gladiator_upgrade"));
		items.equip(a);


	}
});
