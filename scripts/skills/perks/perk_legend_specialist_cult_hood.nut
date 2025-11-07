this.perk_legend_specialist_cult_hood <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecCultHood);
	}

	function getCultistPieces(){
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Head);
		local cultItems = [];
		if (item != null)
		{
			if(item.isItemType(this.Const.Items.ItemType.Cultist)) {
				cultItems.push(item)
			}
			foreach( upgrade in item.m.Upgrades )
			{
				if (upgrade != null && upgrade.isItemType(this.Const.Items.ItemType.Cultist)){
					cultItems.push(upgrade);
				}
			}
		}
		return cultItems
	}

	function onAfterUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
		local resolve = actor.getCurrentProperties().getBravery();

		if (this.getCultistPieces().len() > 0){

			_properties.MeleeDefense += this.Math.floor(resolve * 0.15);
			_properties.RangedDefense += this.Math.floor(resolve * 0.15);
		}
	}

});

