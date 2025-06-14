this.perk_legend_himshaw <- this.inherit("scripts/skills/skill", {
	m = {
		RepairedToday = false
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendHimshaw);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onCombatFinished()
	{
		if (repair(20))
			this.m.RepairedToday = true;
	}

	function repair(_toRepair)
	{
		local actor = this.getContainer().getActor();
		local body = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local bodyAdded = 0
		local bodyMissing = 0;
		local repaired = false;
		if (body)
		{
			bodyMissing = body.getArmorMax() - body.getArmor();
			bodyAdded = this.Math.min(bodyMissing, this.Math.min(_toRepair, this.Math.floor(body.getArmorMax() * 0.1)));

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
			bodyAdded = this.Math.min(bodyMissing, this.Math.min(_toRepair / 2, this.Math.floor(body.getArmorMax() * 0.1)));

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
		repair(10);
		this.m.RepairedToday = false;
	}

});
