::mods_hookExactClass("skills/backgrounds/historian_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.historian";
		this.m.Name = "Historian";
		this.m.Icon = "ui/backgrounds/background_47.png";
		this.m.BackgroundDescription = "Historians are studious individuals with vast amounts of knowledge, none of it any use on the battlefield.";
		this.m.GoodEnding = "You did not expect the historian, %name%, to stay in the company forever. He eventually left and it is said he took with him a large trove of scrolls. As it turns out, he was compiling a list of the %companyname%\'s achievements. He created a codex of all its accomplishments, enshrining the name of all the mercenaries into the history books for future generations to see. You hope they learn something from your doings.";
		this.m.BadEnding = "The %companyname% continued its decline and many non-fighters such as %name% the historian saw this as a good time to leave. You tried to keep up with these men, but the historian was particularly easy to find: he left a paper trail. You sought the man out, asking scribes if they had heard of him. They said he was a mere little man writing a tome about how dark, violent, and pointless the life of a sellsword is.";
		this.m.HiringCost = 100;
		this.m.DailyCost = 7;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Huge),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.Paranoid),
			::Legends.Traits.getID(::Legends.Trait.Impatient),
			::Legends.Traits.getID(::Legends.Trait.IronJaw),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.IronLungs),
			::Legends.Traits.getID(::Legends.Trait.Irrational),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Dexterous),
			::Legends.Traits.getID(::Legends.Trait.SureFooting),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Tough),
			::Legends.Traits.getID(::Legends.Trait.Superstitious),
			::Legends.Traits.getID(::Legends.Trait.Spartan),
			::Legends.Traits.getID(::Legends.Trait.LegendAggressive)
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Hitpoints,
			this.Const.Attributes.Fatigue
		];
		this.m.Titles = [
			"the Owl",
			"the Studious",
			"the Historian"
		];
		this.m.Faces = this.Const.Faces.SmartMale;
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;

		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.BackgroundType = this.Const.BackgroundType.OffendedByViolence | this.Const.BackgroundType.Crusader | this.Const.BackgroundType.Educated;
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[2];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.DaggerTree,
				this.Const.Perks.StaffTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.SpearTree
			],
			Defense = [
				this.Const.Perks.ClothArmorTree
			],
			Traits = [
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.DeviousTree,
				this.Const.Perks.OrganisedTree,
				this.Const.Perks.InspirationalTree,
				this.Const.Perks.CalmTree
			],
			Enemy = [],
			Class = [],
			Magic = [
				// this.Const.Perks.CaptainMagicTree,
				this.Const.Perks.PhilosophyMagicTree
			]
		}
	}

	o.getTooltip = function ()
	{
		local ret = this.character_background.getTooltip();
		ret.push(
			{
				id = 13,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] Experience Gain"
			}
		);
		return ret;
	}

	o.onBuildDescription <- function ()
	{
		return "{Always a voracious reader, %name%\'s early life consisted of long nights in %randomcity%\'s library. | Bullied by his stronger peers, a young %name% retreated into the world of books. | Looking for where man\'s past truly lies, %name% read books and studied human nature. | With so many changes in the world, %name% decided to help record them. | A quick-learner with a penchant for a good read, %name% sought to envision the world on paper for others. | A scholar of %randomcity%\'s small college, %name% records the histories of the world for future generations. | Chilled by dark events in the world, %name% stopped studying plants and began recording human history.} {A proper historian seeks the closest sources he can get, which has brought the man to the company of mercenaries. | After brigands ruined his written works, the man strapped on his boots to carve out new research - personally. | When his professor said his research was rubbish, the historian went out into the world to prove him wrong. | Accused of plagiarism, the historian was kicked out of academia. He seeks redemption in the world of what he studied: war. | Using his position in academia to bed women, eventual scandals and controversies drove the historian from his field, and left him penniless and ready to take on any job. | Bored with reading about adventurers, the historian figured he\'d suit up to fashion himself a closer look at the real thing. | With so many mercenary bands floating around, the historian sought to attach himself for some real-life studying.} {%name% has little in common with actual soldiers, but his imaginative mind fancies a good battle nonetheless. | While %name% spent all his life writing, he spent exactly none of it fighting. Until now. | %name% has the itch to record your outfit\'s travels. He can help by grabbing a sword and suiting up. | A bag of books is hefted over %name%\'s shoulder. You suggest a flail as replacement. It\'s similar, but pointier and stabbier. | %name% is frequently found scribbling notes as he still sees the world with a researcher\'s eye. | %name% comes with a pocketful of quill pens. The feathers would make for some pretty good arrows. | You can place good faith in %name%\'s earnest want to research, but maybe not so much faith in his ability to swing a sword. | %name%\'s time with the outfit is to develop a theory, but can he survive the experiments? | You promise %name% that, shall he perish, you will find a way to record his life. He thanks you and hands over his will. It\'s written in a language foreign to you and you can read absolutely none of it. You smile back anyway.}";
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				-5,
				-2
			],
			Bravery = [
				15,
				20
			],
			Stamina = [
				-5,
				-5
			],
			MeleeSkill = [
				-3,
				1
			],
			RangedSkill = [
				-3,
				0
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
				5,
				8
			]
		};
		return c;
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();

		items.equip(this.Const.World.Common.pickArmor([
			[1, "linen_tunic"]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
				[1, "feathered_hat"],
				[3, ""]
		]))
	}

	o.onUpdate = function ( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.XPGainMult *= 1.15;
	}

});
