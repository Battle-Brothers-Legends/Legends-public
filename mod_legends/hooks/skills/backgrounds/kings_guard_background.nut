::mods_hookExactClass("skills/backgrounds/kings_guard_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.kings_guard";
		this.m.Name = "King\'s Guard";
		this.m.Icon = "ui/backgrounds/background_59.png";
		this.m.BackgroundDescription = "";
		this.m.GoodEnding = "You thought %name% a simple peasant when you found him freezing in the wastes of the north. As it turned out, he was very much a King\'s Guard, not only in title but in action. He fought like a man protecting his liege from the world at large. Thankfully, for a time, that \'liege\' happened to be you. Last you heard he traveled to the southern realms and is protecting an upstart nomad king trying to overthrow the local Viziers.";
		this.m.BadEnding = "You never truly found out which king %name% supposedly \'guarded\' in his days before joining the %companyname%, but it matters not now. After your abrupt retirement, the King\'s Guard took himself to the southern deserts. He served a Vizier for a time but failed to protect the royal from a concubine\'s poison. For punishment, %name%\'s equipment was melted into a pot and poured down his throat.";
		this.m.HiringCost = 0;
		this.m.DailyCost = 30;
		this.m.BackgroundType = this.Const.BackgroundType.Crusader;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Good;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[1];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[2];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[2];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[2];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.TwoHandedTree,
				this.Const.Perks.PolearmTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.CrossbowTree
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.TrainedTree,
				this.Const.Perks.ViciousTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.FitTree
			],
			Enemy = [
				this.Const.Perks.SwordmastersTree
			],
			Class = [],
			Profession = [], 
			Magic = []
		}
	}

	o.getTooltip = function ()
	{
		return this.character_background.getTooltip();
	}

	o.onAdded = function ()
	{
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();
		actor.setTitle("the Kingsguard");
		::Legends.Traits.grant(this, ::Legends.Trait.Loyal);
		::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
	}
});
