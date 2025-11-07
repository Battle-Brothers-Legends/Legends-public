this.perk_legend_himshaw <- this.inherit("scripts/skills/skill", {
	m = {
		RepairedToday = false
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHimshaw);
	}

	function onCombatFinished()
	{
		if (repair(0.2))
			this.m.RepairedToday = true;
	}

	function repair(_toRepair)
	{
		local actor = this.getContainer().getActor();
		local body = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local bodyAdded = 0;
		local bodyMissing = 0;
		local repaired = false;
		if (body)
		{
			bodyMissing = body.getArmorMax() - body.getArmor();
			bodyAdded = this.Math.min(bodyMissing, this.Math.max(0, this.Math.floor(body.getArmorMax() * _toRepair)));

			if (bodyAdded > 0)
			{
				body.setArmor(body.getArmor() + bodyAdded);
				actor.setDirty(true);
			}
			repaired = true;
		}

		body = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
		if (body)
		{
			bodyMissing = body.getArmorMax() - body.getArmor();
			bodyAdded = this.Math.min(bodyMissing, this.Math.max(0, this.Math.floor(body.getArmorMax() * _toRepair)));

			if (bodyAdded > 0)
			{
				body.setArmor(body.getArmor() + bodyAdded);
				actor.setDirty(true);
			}
			repaired = true;
		}
		if (repaired)
			return true;
		return false;
	}

	function onNewDay()
	{
		repair(0.1);
		this.m.RepairedToday = false;
	}

});
