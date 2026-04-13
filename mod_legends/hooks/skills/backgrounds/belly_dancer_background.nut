::mods_hookExactClass("skills/backgrounds/belly_dancer_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.belly_dancer";
		this.m.Name = "Belly Dancer";
		this.m.Icon = "ui/backgrounds/background_64.png";
		this.m.BackgroundDescription = "";
		this.m.GoodEnding = "%name% the southern belly dancer left the company in good time. While their... particularities made her an excellent soldier, it was not her life\'s passion. To entertain, through rhythmic, confusingly erotic motions, that is what she wanted. The last you heard, they were in the court of a Vizier serving not only as an entertainer, but, thanks to time with the %companyname%, also as an adviser on martial matters.";
		this.m.BadEnding = "As the company failed to achieve the success you had hoped for, many departed its ranks. The southern belly dancer joined them. Unfortunately, %name% sought to ply her trade in the north, thinking she might be able to spread culture there. The indigenous population was quick to accuse her of \'unregulated body sorcery\' and burn %name% at the stake.";
		this.m.HiringCost = 500;
		this.m.DailyCost = 20;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Huge),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.Deathwish),
			::Legends.Traits.getID(::Legends.Trait.LegendPredictable),
			::Legends.Traits.getID(::Legends.Trait.Dumb)
		];
		// this.m.ExcludedTalents = [
		// 	this.Const.Attributes.Hitpoints,
		// 	this.Const.Attributes.Fatigue,
		// 	this.Const.Attributes.Bravery
		// ];
		this.m.Bodies = this.Const.Bodies.SouthernFemale;
		this.m.Faces = this.Const.Faces.SouthernFemale;
		this.m.Hairs = this.Const.Hair.SouthernFemale;
		this.m.HairColors = this.Const.HairColors.SouthernYoung;
		this.m.BeardChance = 0;
		this.m.Ethnicity = 1;
		this.m.BackgroundType = this.Const.BackgroundType.Female | this.Const.BackgroundType.Performing;
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[1];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[3];
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.SwordTree,
				::Const.Perks.PolearmTree,
				::Const.Perks.DaggerTree,
				::Const.Perks.ThrowingTree
			],
			Defense = [
				::Const.Perks.ClothArmorTree,
				::Const.Perks.LightArmorTree
			],
			Traits = [
				::Const.Perks.TrainedTree,
				::Const.Perks.FitTree,
				::Const.Perks.FastTree,
				::Const.Perks.AgileTree,
				::Const.Perks.DeviousTree,
				::Const.Perks.IntelligentTree
			],
			Enemy = [
				::Const.Perks.SwordmastersTree
			],
			Class = [
				::Const.Perks.JugglerClassTree
			],
			Profession = [],
			Magic = [
				::Const.Perks.AssassinMagicTree
			]
		}
	}

	o.getTooltip = function ()
	{
		local ret = this.character_background.getTooltip();
		ret.push(
			{
				id = 11,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "[color=%positive%]+10%[/color] Chance To Hit Head"
			}
		);
		return ret;
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				-5,
				-5
			],
			Bravery = [
				-5,
				-5
			],
			Stamina = [
				-5,
				-5
			],
			MeleeSkill = [
				7,
				14
			],
			RangedSkill = [
				5,
				10
			],
			MeleeDefense = [
				0,
				0
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				10,
				20
			]
		};
		return c;
	}

	o.onUpdate <- function ( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.HitChance[this.Const.BodyPart.Head] += 10;
	}

	o.onAdded <- function ()
	{
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();
		actor.setTitle("the Belly Dancer");
	}

	o.onAddEquipment = function ()
	{
		local actor = this.getContainer().getActor();
		actor.setVeteranPerks(3);
		local items = actor.getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[3, ::Legends.Armor.Southern.cloth_sash],
			[1, ::Legends.Armor.None]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.None],
			[4, ::Legends.Helmet.Southern.legend_jewelry]
		]));
	}
});
