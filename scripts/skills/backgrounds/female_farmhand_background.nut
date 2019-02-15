this.female_farmhand_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.female_farmhand";
		this.m.Name = "Milkmaid";
		this.m.Icon = "ui/backgrounds/background_09.png";
		this.m.BackgroundDescription = "Milkmaid are used to physical labor.";
		this.m.GoodEnding = "The former milkmaid, %name%, retired from the %companyname%. The money she made was put toward purchasing a bit of land. she spends the rest of her days happily farming and starting a family with way too many children.";
		this.m.BadEnding = "The former milkmaid, %name%, soon left the %companyname%. She purchased a bit of land out {south | north | east | west} and was doing quite well for herself - until noble soldiers hanged her from a tree for refusing to hand over all her crops.";
		this.m.HiringCost = 90;
		this.m.DailyCost = 10;
		this.m.Excluded = [
			"trait.weasel",
			"trait.fear_undead",
			"trait.hate_undead",
			"trait.clubfooted",
			"trait.asthmatic"
		];
		this.m.Faces = this.Const.Faces.AllFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.Body = "bust_naked_body_03";
		this.m.IsLowborn = true;
		this.m.IsFemaleBackground = true;
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
	}

	function onBuildDescription()
	{
		return "{Tilling the soil is hard work, requiring the blood and sweat of sturdier women. | Every farm in the land needs a stable of hardy folk to work the fields.  | A woman puts her sweat into the earth to feed herself, and she feeds herself to put her sweat into the Earth another day. | No matter the weather, a farm needs working. | Pigsties, stables, and ungated pens, these are the dreams and nightmares of farming women. | While some women earn their keep by killing, others look below their own two feet, wondering what crops the soil may hold. | A special breed of women comes out of ranchers and farmers. Sturdy, resolute, hard-working. | With food so needed, there\'s little wonder why farmers are the most common sort of woman in all the land. | A farm wife hates to see her land fertilized in blood, but that\'s becoming more and more common these days. | In war, farms are hotspots for armies. Not just to feed themselves, but to recruit from the stable of strong women who work those lands. | As cities grow and distance themselves from the hinterland, citizens often forget to whom their full bellies owe gratitude.} %name% {is a burly, sweat-sculpted farmhand. | hails from the outskirts of %randomtown% where she drove ploughs and broke horses. | knows a couple kinds of hoes, all of which the farmhand can swing with ease. | grew up on one of the land\'s many farms. | spent many years harvesting the crops that feed everyone in the land. | worked as a farmhand for a simple homestead. | fell into farming after her father\'s boating business went under. | became a farmhand to help feed his dozen kids and layabout husband. | took up farming as a means to a belly-filled end. | carries the stocky frame best used for planting, harvesting, and surviving winters.} {Unfortunately, it didn\'t take war and turmoil long to find her farm. | But poor harvests have driven her from the farms. | Sadly, her farm was one of the first to be attacked during these trying times. | Word of coming violence, however, drove her from the peaceful vocation of farming. | Droughts, poorly-timed as ever, have now driven the woman from her work. | Unpaid for her labor, she eventually abandoned the farm life. | With more crowns than ever in the killing businesses, the woman was easily drawn away from her motley crops. | One day, she realized her strong body had more value chopping heads than milking cows. | After raiders pillaged his crops, she\'d had enough, leaving the farm life for good. | After the weather soured her harvest, the farmer decided to choose a vocation not wholly based on the whims of Mother Nature. | Word has it she really did sleep with the farmer\'s son. What a surprise she\'s no longer on the farm.} {Cornfed and barnbred, %name% stands before you as fit a woman you\'ve ever seen. | She misses the cows, true, but %name% should take to the mercenary\'s tough life with ease. | Growing up on a farm gives a woman all the nutrients she\'d ever need, and %name% certainly took advantage. | %name% once took a mule kick to the face. Its foot broken, they had to put the animal down. | If women were trees, %name% would never fall down. Or something gracious like that. | Don\'t let her simple past fool you, %name% could fit right in with any wrestler or fighter. | %name% shares a lot in common with draught animals. Just point her the right way. | Judging by her size, there must have been a lot of meat in that corn %name% spent all her life eating. | %name% is big enough to wring a guy\'s neck like it was a cow\'s udder.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				7,
				5
			],
			Bravery = [
				-2,
				-3
			],
			Stamina = [
				15,
				25
			],
			MeleeSkill = [
				0,
				0
			],
			RangedSkill = [
				0,
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
				0,
				0
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/pitchfork"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/wooden_flail"));
		}

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/sackcloth"));
		}
		else
		{
			local item = this.new("scripts/items/armor/linen_tunic");
			item.setVariant(this.Math.rand(6, 7));
			items.equip(item);
		}

		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/straw_hat"));
		}
	}

});
