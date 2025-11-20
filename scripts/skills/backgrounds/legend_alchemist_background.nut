this.legend_alchemist_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_alchemist";
		this.m.Name = "Alchemist";
		this.m.Icon = "ui/backgrounds/background_alchemist.png";
		this.m.BackgroundDescription = "The alchemist creates potions and gunpowder accessories, for a price.";
		this.m.GoodEnding = "Although weak with a sword and not an enjoyer of combat, %name% left the company soon after the commander\'s departure and focused themselves on the curing of disease and sickness they had seen much of across the land. Their knowledge of alchemy was of great value in the north, earning more crowns than they thought possible. %name% set up a shop in a border town with the southern realms, selling remedies to those who needed them for far below normal prices. They died content and of old age, without a regret in their mind.";
		this.m.BadEnding = "The subject of death terrified %name% to look for remedies and concoctions to prolong their own life by using the crowns they had accumulated from their time with the company. %name% travelled the known world in search of all the reagents they could find until they were killed in a wildman raid, never knowing the cure to their short existence.";
		this.m.HiringCost = 1250;
		this.m.DailyCost = 20;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.LegendHeavy),
			::Legends.Traits.getID(::Legends.Trait.LegendMartial),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.Spartan),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Dumb)
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.MeleeSkill,
			this.Const.Attributes.Fatigue
		];
		this.m.Bodies = this.Const.Bodies.SouthernMale;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.BeardChance = 50;
		this.m.Ethnicity = 1;
		this.m.BackgroundType = this.Const.BackgroundType.Educated;
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[2];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[1];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[1];
		this.m.Modifiers.Crafting = this.Const.LegendMod.ResourceModifiers.Crafting[3];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.SwordTree,
				this.Const.Perks.DaggerTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.ClothArmorTree
			],
			Traits = [ //lf 5
				this.Const.Perks.TrainedTree,
				this.Const.Perks.DeviousTree,
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.CalmTree,
				this.Const.Perks.OrganisedTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.SickleClassTree,
				this.Const.Perks.PoisonClassTree
			]
			Profession = [
				this.Const.Perks.BarterProfessionTree,
				this.Const.Perks.HerbalistProfessionTree
			], 
			Magic = []
		}
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-5,
				-5
			],
			Bravery = [
				8,
				12
			],
			Stamina = [
				-5,
				-5
			],
			MeleeSkill = [
				-5,
				2
			],
			RangedSkill = [
				6,
				8
			],
			MeleeDefense = [
				0,
				0
			],
			RangedDefense = [
				1,
				3
			],
			Initiative = [
				10,
				10
			]
		};
		return c;
	}

	function onBuildDescription()
	{
		return "{%name% is heard before they are seen, a rattle and clink of tools, flasks and other equipment strapped to their belt make them stand out among the crowds. | Their mind is constantly deconstructing and reconstructing materials as they inspect them with a scrutinising gaze, intellectually picking apart objects for their own uses. }{While %name% appears more skinny and diminutive than others you have seen, their ability to create things out of sparse materials using nothing but a campfire and tongs is a testament to southern ingenuity. | They assure you it is not magic, but to those around them it might as well be. }{The sickly smell of sulphur surrounds %name% like a natural musk. | In a profession where mistakes are common and often fatal, %name% seems to be one of the few characters you have men with all eyes, fingers, toes and everything else accounted for.  | How long this will persist as a mercenary is anyone\'s guess. }{Minor burns, chars and singes are like pock marks across %name%\'s body, their frequency increasing around the face and fingertips of the alchemist. | %name% says there is nothing to fear and that their methods are \'perfectly safe\'. | But every now and again you see them wince and grit their teeth on combining two mixtures together.}"
	}

	function onAdded()
	{
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();
		actor.setTitle("the Alchemist");
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[3, ::Legends.Armor.Southern.vizier_gear]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[2, ::Legends.Helmet.None],
			[1, ::Legends.Helmet.Southern.vizier_headgear],
			[1, ::Legends.Helmet.Southern.engineer_hat]
		]));
	}
});

