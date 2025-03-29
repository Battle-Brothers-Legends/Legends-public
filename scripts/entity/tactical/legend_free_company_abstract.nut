this.legend_free_company_abstract <- this.inherit("scripts/entity/tactical/human", {
	m = {
		Outfits = [],
		PerkList = [],
		PerkPower = 5
	},
	function assignRandomEquipment()
	{
		foreach( item in this.Const.World.Common.pickOutfit(this.m.Outfits) )
		{
			this.m.Items.equip(item);
		}
		foreach(perk in this.Const.World.Common.pickPerks(this.m.PerkList, this.m.PerkPower)) //this is technically out of place when considering where the other perks are added but we can't randomize when it's put into the init
		{
			::Legends.Perks.grant(this, perk);
		}
	}
});
