::mods_hookExactClass("skills/perks/perk_inspiring_presence", function(o) {
	o.onCombatStarted = function()
	{
		this.logInfo("inspiring presence: on combat started!");
		this.skill.onCombatStarted();
		local allies = this.Tactical.Entities.getInstancesOfFaction(this.getContainer().getActor().getFaction());
		local ownID = this.getContainer().getActor().getID();
		local resolve = this.getContainer().getActor().getCurrentProperties().getBravery();

		foreach( ally in allies )
		{
			if (ally.getID() == ownID)
			{
				continue;
			}

			if (ally.getMoraleState() != this.Const.MoraleState.Ignore && ally.getMoraleState() != this.Const.MoraleState.Confident)
			{
				local resolve_ally = ally.getCurrentProperties().getBravery();
				local waverchance = (200 - resolve) * 0.01;
				local r = this.Math.rand(1, resolve);
				if (r <= waverchance)
				{
					ally.setMoraleState(this.Const.MoraleState.Wavering);
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(ally) + " is wavering after being scared by a speech");
				}
				else if (r >= (resolve_ally * 0.33))
				{
					ally.setMoraleState(this.Const.MoraleState.Confident);
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(ally) + " is confident due to an inspiring speech");
				}
				else
				{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(ally) + " was not paying attention to a speech");
				}

			}
		}
	}

	o.onUpdate <- function( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (item != null)
		{
			local itemID = item.getID();
			if(itemID == "weapon.player_banner")
			{
				_properties.DamageRegularMin += 10;
				_properties.DamageRegularMax += 10;
			}
		}
	}
});
