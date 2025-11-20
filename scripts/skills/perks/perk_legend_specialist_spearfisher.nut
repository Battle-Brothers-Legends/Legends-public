this.perk_legend_specialist_spearfisher <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		FreeNet = false,
		SpecialistWeaponIds = [
			"weapon.javelin"
		],
		ApplicableWeaponTypes = [
			this.Const.Items.WeaponType.Throwing
		],
		ExcludedItemTypes = [
			this.Const.Items.ItemType.MeleeWeapon
		],
		BonusRanged = 12,
		BonusDamage = 10
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSpecialistSpearfisher);
		this.m.IconMini = "perk_spec_longbow_mini";
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill == null)
			return;

		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.ThrowNet) && this.m.FreeNet)
		{
			this.m.FreeNet = false;
			return;
		}
		local item = _skill.getItem();

		if (item == null)
			return;
		if (!item.isItemType(this.Const.Items.ItemType.Weapon))
			return;
		if (!item.isWeaponType(this.Const.Items.WeaponType.Throwing))
			return;

		this.m.FreeNet = true;
	}

	function onCombatFinished()
	{
		this.m.FreeNet = false;
	}

	function onAfterUpdate(_properties)
	{
		if (!this.m.FreeNet)
			return;
		local skills = this.getContainer().getAllSkillsOfType(this.Const.SkillType.Active);
		foreach (skill in skills)
		{
			if (skill.getID() == ::Legends.Actives.getID(::Legends.Active.ThrowNet))
			{
				skill.m.ActionPointCost = 0;
			}
		}
	}
});
