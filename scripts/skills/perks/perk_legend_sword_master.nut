this.perk_legend_sword_master <- this.inherit("scripts/skills/skill", {
	m = {
		SwingUsedThisTurn = false,
		HasCuttingSword = false,
		CuttingSwordsList = [
			"falchion",
			"goblin_falchion",
			"scimitar",
			"two_handed_scimitar",
			"shamshir",
			"saif",
			"rhomphaia",
			"two_handed_saif",
			"warbrand",
			"legend_sickle"
			"legend_kopis",
			"legend_skin_flayer",
			"named_goblin_falchion",
			"named_shamshir",
			"named_two_handed_scimitar",
			"named_warbrand",
			"legend_named_sickle"
		]
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSwordMaster);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate(_properties)
	{
		local actor = this.getContainer().getActor();
		local mainHand = actor.getMainhandItem();

		if (mainHand == null)
			return;
		if (!mainHand.isWeaponType(this.Const.Items.WeaponType.Sword))
			return;

		foreach (id in this.m.CuttingSwordsList)
		{
			if (mainHand.getID() == "weapon." + id)
			{
				this.m.HasCuttingSword = true;
				break;
			}
		}
	}

	function onAfterUpdate(_properties)
	{
		if (!this.m.SwingUsedThisTurn)
			return;

		local skills = this.getContainer().getAllSkillsOfType(this.Const.SkillType.Active);
		foreach (skill in skills)
		{
			if (this.m.Skills.find(skill.getID()) != null)
			{
				skill.m.FatigueCostMult *= 0.5;

				if (skill.getID() == "actives.swing")
				{
					skill.m.ActionPointCost /= 2;
				}
			}
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.getID() == "actives.swing" && !this.m.SwingUsedThisTurn)
			this.m.SwingUsedThisTurn = true;

		if (_targetEntity == null)
			return;

		if (this.m.HasCuttingSword)
		{
			_properties.DamageTotalMult *= this.getCutBonus(_targetEntity);
		}
	}

	function getCutBonus(_targetEntity)
	{
		local fat = 0;
		local body = _targetEntity.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local head = _targetEntity.getItems().getItemAtSlot(this.Const.ItemSlot.Head);

		if (body != null)
		{
			fat = fat + body.getStaminaModifier();
		}

		if (head != null)
		{
			fat = fat + head.getStaminaModifier();
		}

		fat = this.Math.pow(this.Math.abs(fat) / 4.5, 2)
		return this.Math.minf(0, 0.2 - this.Math.floor(fat) * 0.01);
	}


});
