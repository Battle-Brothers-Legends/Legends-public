::mods_hookExactClass("skills/backgrounds/hedge_knight_background", function(o)
{
	o.m.AlreadyUsed <- false;
	o.m.ExecutingAttack <- false;

	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.hedge_knight";
		this.m.Name = "Hedge Knight";
		this.m.Icon = "ui/backgrounds/background_33.png";
		this.m.BackgroundDescription = "Hedge Knights are competitive individuals that excel in fighting man against man with brute strength and heavy armor, but less so in cooperating with others or in swiftness. Hedge Knights strike with such strength that they might cleave a secondary enemy.";
		this.m.GoodEnding = "A %person% like %name% would always find a way. The hedge knight eventually, if not inevitably, left the company and set out on %their% own. Unlike many other mercenaries, %they% did not spend %their% crowns on land or ladders with which to climb the noble life. Instead, %they% bought %themselves% the finest war horses and the talents of armorers. The behemoth of a %person% rode from one jousting tournament to the next, winning them all with ease. %They%\'s still at it to this day, and you think %they% won\'t stop until %they%\'s dead. The hedge knight simply knows no other life.";
		this.m.BadEnding = "%name% the hedge knight eventually left the company. %They% traveled the lands, returning to %their% favorite past time of jousting, which was really a cover for %their% real favorite past time of lancing men off horses in a shower of splinters and glory. At some point, %they% was ordered to \'throw\' a match against a pitiful and gangly prince to earn the nobleman some prestige. Instead, the hedge knight drove %their% lance through the %person%\'s skull. Furious, the lord of the land ordered the hedge knight killed. They say over a hundred soldiers took to %their% home and only half returned alive.";
		this.m.HiringCost = 500;
		this.m.DailyCost = 50;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.FearGreenskins),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Swift),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Irrational),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.LegendLight),
			::Legends.Traits.getID(::Legends.Trait.LegendSeductive)
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Initiative,
			this.Const.Attributes.RangedSkill
		];
		this.m.Titles = [
			"the Lone Wolf",
			"the Wolf",
			"the Hound",
			"Steelwielder",
			"the Slayer",
			"the Jouster",
			"the Giant",
			"the Mountain",
			"Strongface",
			"the Defiler",
			"the Knightslayer",
			"the Hedge Knight"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.All;

		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Cruel;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Chivalrous;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Level = this.Math.rand(2, 5);
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Crusader;
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[1];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[2];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[1];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.SwordTree,
				::Const.Perks.AxeTree,
				::Const.Perks.MaceTree,
				::Const.Perks.FlailTree,
				::Const.Perks.HammerTree
			],
			Defense = [
				::Const.Perks.HeavyArmorTree
			],
			Traits = [
				::Const.Perks.TrainedTree,
				::Const.Perks.ViciousTree,
				::Const.Perks.LargeTree,
				::Const.Perks.IndestructibleTree,
				::Const.Perks.MartyrTree,
				::Const.Perks.FitTree
			],
			Enemy = [
				::Const.Perks.SwordmastersTree
			],
			Class = [],
			Profession = [],
			Magic = []
		}
	}

	o.getTooltip = function ()
	{
		local ret = this.character_background.getTooltip();
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Once per turn upon killing an enemy execute an attack of opportunity on an enemy on an adjacent tile for [color=%negative%]50%[/color] damage"
		});
		return ret;
	}

	o.setGender <- function (_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;

		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.NorthernFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	o.onTargetKilled <- function( _targetEntity, _skill )
	{
		if (this.m.AlreadyUsed || _skill.isRanged())
			return;

		this.m.AlreadyUsed = true;
		this.m.ExecutingAttack = true;
		local tile = _targetEntity.getTile();
		local targetTiles = [];

		for( local i = 0; i != 6; i = ++i )
		{
			if (tile.hasNextTile(i))
			{
				local next = tile.getNextTile(i);

				if (next.IsOccupiedByActor && this.Math.abs(next.Level - tile.Level) <= 1 && !next.getEntity().isAlliedWithPlayer())
				{
					targetTiles.push(next);
				}
			}
		}
		if (targetTiles.len() == 0)
		{
			this.m.ExecutingAttack = false;
			return; 
		}

		this.getContainer().getAttackOfOpportunity().useForFree(targetTiles[this.Math.rand(0, targetTiles.len() - 1)]);
		this.m.ExecutingAttack = false;
	}

	o.onAnySkillUsed <- function ( _skill, _targetEntity, _properties )
	{
		if (this.m.ExecutingAttack)
		{
			_properties.DamageTotalMult *= 0.5;
		}
	}

	o.onTurnStart <- function()
	{
		this.m.AlreadyUsed = false;
	}

	o.onBuildDescription <- function ()
	{
		return "{Some people are born to be feared. Well over six feet tall, %name%\'s stature alone is a threatening one. | %name%\'s shadow casts over smaller men - and they seem to only further shrink when %they% walks by. | Standing amongst men like a bear in a suit of armor, %name% earns plenty of double-takes. | Years of brutal combat with %their% equally huge brothers left %name% a scarred and scary figure.} {The hedge knight has spent many seasons taking %their% prized horse to jousting tournaments. Unfortunately, a polearm crowned %their% mount, leaving %them% without a ride. | A mercenary in the company of %themselves%, the hedge knight wandered for years, doing battle for those who offered the most crowns. | When %they% cleaved five men with one swing, three of which were on %their% side, the hedge knight was banned from service in every army in the land. | Ordered to kill a lord\'s enemies, the hedge knight kicked in the door of a family and slaughtered them all with %their% bare hands. When the lord refused to pay, %name% killed %them%, too. | The hedge knight has spent many nights sleeping peacefully beneath a pale moon - and just as many days killing ruthlessly beneath a shining sun.} {Always on the hunt for more crowns, the company of sellswords seemed like a good fit. | Too terrifying to be employed for long, %name% seeks the company of men who will not piss themselves when %they% grabs a weapon. | Tired of killing jousters and lords, as well as women and children, %name% sees mercenary work as something of a vacation. | War has apparently gotten in the way of %name%\'s jousting career. He seeks to amend that problem.}";

	}

	o.onSetAppearance = function ()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");

		if (this.Math.rand(1, 100) <= 25)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			tattoo_head.setBrush("scar_02_head");
			tattoo_head.Visible = true;
		}
	}

	o.updateAppearance = function ()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
		}
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				12,
				13
			],
			Bravery = [
				4,
				9
			],
			Stamina = [
				10,
				15
			],
			MeleeSkill = [
				10,
				11
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				9,
				12
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				-14,
				-7
			]
		};
		return c;
	}


	o.onAddEquipment = function ()
	{
		local actor = this.getContainer().getActor();
		actor.setVeteranPerks(3);
		local items = actor.getItems();

		local weapons = [
			"scripts/items/weapons/greataxe",
			"scripts/items/weapons/longsword",
			"scripts/items/weapons/legend_zweihander",
			"scripts/items/weapons/greatsword",
			"scripts/items/weapons/two_handed_hammer",
			"scripts/items/weapons/two_handed_flail",
			"scripts/items/weapons/two_handed_flanged_mace"
		];
		items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.mail_hauberk],
			[1, ::Legends.Armor.Standard.basic_mail_shirt],
			[1, ::Legends.Armor.Standard.scale_armor],
			[1, ::Legends.Armor.Standard.reinforced_mail_hauberk],
			[1, ::Legends.Armor.Standard.worn_mail_shirt]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.nasal_helmet],
			[1, ::Legends.Helmet.Standard.nasal_helmet_with_mail],
			[1, ::Legends.Helmet.Standard.mail_coif],
			[1, ::Legends.Helmet.Standard.bascinet_with_mail],
			[1, ::Legends.Helmet.Standard.closed_flat_top_helmet],
			[1, ::Legends.Helmet.Standard.theamson_barbute_helmet]
		]));
	}
});
