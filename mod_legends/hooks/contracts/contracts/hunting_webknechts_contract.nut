::mods_hookExactClass("contracts/contracts/hunting_webknechts_contract", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "Scuttling Horrors";
		this.m.DescriptionTemplates = [
			"Townsfolk are reporting a swarm of skittering monstrosities is nearby, taking children and dogs and the like.",
			"Spiders. Fark, you hate Spiders.",
			"The forest is alive with danger, as horrifyingly large spiders weave deadly traps among the trees.",
			"Venturing into the forest means facing the silent menace of web spiders, whose intricate webs ensnare the unwary.",
			"Life in the village is currently overshadowed by the spider threat, as the arachnids weave their deadly webs among the houses and fields.",
			"In the quiet of night, spiders descend upon the village, spinning their deadly traps and creeping into homes.",
			"The village is besieged by monstrous spiders, their scuttling numbers apparently growing with each passing day.",
			"The forest is home to a new danger: webknechts, whose silky threads are stretching across the trees like a lethal net.",
		];
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		foreach (s in this.m.Screens)
		{
			if (s.ID == "OldArmor")
			{
				s.start <- function ()
				{
					local item = this.Const.World.Common.pickArmor([
						[1, ::Legends.Armor.Standard.decayed_reinforced_mail_hauberk],
						[1, ::Legends.Armor.Standard.decayed_coat_of_scales],
					]);
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain a " + item.getName()
					});
				}
			}
			if (s.ID == "Task")
			{
				s.Title = "Scuttling Horrors";
			}
		}
	}
});
