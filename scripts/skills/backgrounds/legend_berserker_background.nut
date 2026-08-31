this.legend_berserker_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {
		Tattoo = 0
	},
	function create()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.LegendBerserker);
		this.m.BackgroundDescription = "Hailing from the north, berserkers are often feared even among the wildmen and the barbarians. Incredibly hardy and often maddened from the overuse of mushrooms, they almost rival orcs in raw strength.";
		this.m.GoodEnding = "While the %companyname% visited a town for rest and recuperation, a local princess took a shine to %name% the berserker. %They% was \'purchased\' for a large sum of gold and given to the noblewoman. You went and visited the %person% recently. For dinner, %they% sat at a kingly table, grinning goofily and mimicking the nobles around %them% as best %they% could. %Their% new and inexplicable %partner% adored %them%, and %them% her. When you said your goodbyes, %they% offered you a heavy golden crown off the top of %their% head. It weighed heavy with traditions and ancient histories. You said it\'d be best if %they% kept it. The wildman shrugged and walked off, spinning the circlet around a finger.";
		this.m.BadEnding = "%name% the wildman stayed with the fragmenting %companyname% for a time and then, just like that, %they% was gone. The company went out looking for %them% in a forest, eventually finding some sort of crude note: an enormous pile of crowns next to a dirt-drawing of the %companyname% and some of its members, all of them being hugged by a big, literal stick figure with a goofy smile on its face. There was also an offering of a dead, half-eaten rabbit.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.Paranoid),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Gluttonous),
			::Legends.Traits.getID(::Legends.Trait.Pessimist),
			::Legends.Traits.getID(::Legends.Trait.Optimist),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.Dexterous),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Hesitant),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Drunkard),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.LegendSureshot),
			::Legends.Traits.getID(::Legends.Trait.LegendSteadyHands),
			::Legends.Traits.getID(::Legends.Trait.LegendPredictable),
		];
		this.m.Titles = [
			"the Berserker",
			"Ulfhednar",
			"the Crazed",
			"the Uncontrollable",
			"the Frenzied"
		];
		this.m.Ethnicity = 0;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Cruel;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.NeutralMax;
		this.m.Level = this.Math.rand(2, 4);
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Lowborn | this.Const.BackgroundType.Outlaw | this.Const.BackgroundType.Untalented;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Cruel;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
	}

	function getTooltip ()
	{
		local ret = this.character_background.getTooltip();
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "[color=%positive%]5%[/color] bonus damage to [color=#400080]Hand to Hand[/color] and [color=#400080]Choke[/color]"
		});
		return ret;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.LegendChoke) || _skill.getID() == ::Legends.Actives.getID(::Legends.Active.HandToHand))
		{
			_properties.DamageTotalMult *= 1.05;
		}
	}

	function setGender(_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {HairColors = ::Const.HairColors.Young}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.LegendTattoos, Hairs = ::Const.Hair.WildMale, HairColors = ::Const.HairColors.Young, Beards = ::Const.Beards.Wild}, 100);
		if(_gender){
			this.m.GoodEnding = "While the %companyname% visited a town for rest and recuperation, a local prince took a shine to %name% the wildwoman. She was \'purchased\' for a large sum of gold and given to the nobleman. You went and visited the woman recently. For dinner, she sat at a kingly table, grinning goofily and mimicking the nobles around her as best she could. Her new and inexplicable husband adored her, and her him. When you said your goodbyes, she offered you a heavy golden crown off the top of her head. It weighed heavy with traditions and ancient histories. You said it\'d be best if she kept it. The wildwoman shrugged and walked off, spinning the circlet around a finger.";
		}
	}

	function onBuildDescription ()
	{
		return "{For some, the wild is a refuge. | It is said that %person% is born with the wilderness in %them%, and that %they% does wrong by turning %their% back on it. | Civilization is a stain, one prolonged arming of every next-generation to better battle the ultimate enemy: Mother Nature herself. | In a time of war, it\'s not surprising that many once again seek refuge in the wild. | Some people flee from town to town. Others stop in between, disappearing into the tranquil forests.} {%name% once found a safe register amongst the trees, but that time is over. | Once a mysterious figure to hunters - the famed masskewatsthat - %name% now returns to civilization for reasons unknown. | %name%\'s got the hands of a blacksmith, but the hygiene of a pigsty. | Maybe it was spurned love, or maybe just war, but %name% has spent the last decade far from the rest of mankind. | Possibly a poacher who settled where %they% hunted, %name%\'s lived amongst the trees for untold years. | With cleverly stitched garb, %name%\'s atavistic appearance perhaps belies a past as a tailor or tanner.} {There is an obvious language barrier with the wildman, but for some reason %they% seems very willing to fight. Let\'s hope his newfound \'calling\' doesn\'t have a darker purpose behind it. | Colorful and permanent ritual rites circle about %their% body. When asked why %they% wishes to join a band of mercenaries, %they% hoots and, with a crooked finger, replicates one of %them% fleshen arts across the sky. | Wounds, old and fresh, dot %their% already mottled body. And they are not superficial - this woman had been fighting something fierce in the wild. | One has to wonder if the calamities which chased %them% into the forests have come to chase %them% back out. | Judging by %their% wild grunting, it\'s doubtful %they%\'s here to rejoin civilization. | Years as a recluse haven\'t made the woman forget what a few crowns can get you. The question is, why did %they% come back? | She has the strength to wrestle a boar - and %their% many scars makes you wonder if perhaps %they% did.}";
	}

	function onChangeAttributes()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendBerserker);
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local dirt = actor.getSprite("dirt");
		dirt.Visible = true;
		this.m.Tattoo = this.Math.rand(0, 1);
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");
		local body = actor.getSprite("body");
		tattoo_body.setBrush((this.m.Tattoo == 0 ? "warpaint_01_" : "scar_02_") +  body.getBrush().Name);
		tattoo_body.Visible = true;
		tattoo_head.setBrush(this.m.Tattoo == 0 ? "warpaint_01_head" : "scar_02_head");
		tattoo_head.Visible = true;
	}

	function updateAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush((this.m.Tattoo == 0 ? "warpaint_01_" : "scar_02_") + body.getBrush().Name);
		}
	}

	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Hitpoints] = 3;
		 this.getContainer().getActor().fillTalentValues(2, true);

		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Barbarian.hide_and_bone_armor],
			[1, ::Legends.Armor.Barbarian.rugged_scale_armor],
			[1, ::Legends.Armor.Barbarian.scrap_metal_armor],
			[1, ::Legends.Armor.Barbarian.reinforced_animal_hide_armor],
			[1, ::Legends.Armor.Barbarian.heavy_iron_armor],
			[1, ::Legends.Armor.Barbarian.reinforced_heavy_iron_armor],
			[1, ::Legends.Armor.Barbarian.thick_plated_barbarian_armor]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Barbarian.closed_scrap_metal_helmet],
			[1, ::Legends.Helmet.Barbarian.crude_faceguard_helmet],
			[1, ::Legends.Helmet.Barbarian.crude_metal_helmet],
			[1, ::Legends.Helmet.Barbarian.leather_helmet]
		]));
		local weapons = [
			"weapons/barbarians/skull_hammer",
			"weapons/barbarians/two_handed_spiked_mace",
			"weapons/barbarians/rusty_warblade",
			"weapons/barbarians/heavy_rusty_axe"
		];

		items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
	}

	function onSerialize( _out )
	{
		this.character_background.onSerialize(_out);
		_out.writeU8(this.m.Tattoo);
	}

	function onDeserialize( _in )
	{
		this.character_background.onDeserialize(_in);
		this.m.Tattoo = _in.readU8();
	}

});
