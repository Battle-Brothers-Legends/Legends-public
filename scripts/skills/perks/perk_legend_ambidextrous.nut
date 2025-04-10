this.perk_legend_ambidextrous <- this.inherit("scripts/skills/skill", {
	m = {
		offHandSkill = null,
		HandToHand = null,
		ApplicableItems = [
			"shield.legend_named_parrying_dagger",
			"shield.legend_parrying_dagger",
			"shield.buckler",
			"shield.legend_mummy_shield"
		],
	},

	// takes a weakTableRef
	function setOffhandSkill ( _a )
	{
		this.m.offHandSkill = ::MSU.asWeakTableRef(_a);
	}

	function resetOffhandSkill ()
	{
		this.m.offHandSkill = null;
	}

	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendAmbidextrous);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		if (!::MSU.isNull(m.offHandSkill))
			return false;
		local items = this.getContainer().getActor().getItems();
		local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
		local main = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
		return !(off == null && !items.hasBlockedSlot(this.Const.ItemSlot.Offhand));
	}

	function getDescription()
	{
		local skill = !::MSU.isNull(m.offHandSkill) ? this.m.offHandSkill : m.HandToHand;
		return format("Fluid like water!\n\nThis character will follow up any attack with a [color=" + ::Const.UI.Color.Active + "]%s[/color] from their off hand! If both hands are free, they also gain additional melee skill and melee defense.", skill.getName());
	}

	function getTooltip()
	{
		local items = this.getContainer().getActor().getItems();
		local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
		local main = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);

		local ret = [
			{
				id = 1,
				type = "title",
				text = "Fluid" // Since the passive should have a different name than the perk in this case
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription() // Since the passive should have a different name than the perk in this case
			}
		];

		if ((main == null || this.getContainer().hasEffect(::Legends.Effect.Disarmed)) && off == null && !items.hasBlockedSlot(this.Const.ItemSlot.Offhand))
		{
			ret.push({
				id = 3,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] melee skill"
			});
			ret.push({
				id = 4,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] melee defense"
			});
		}

		return ret;
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (!_skill.m.IsAttack || (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.HandToHand) && this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Mainhand) != null))
		{
			// Don't execute a follow up attack if the first skill is not an attack, or if you are using hand to hand while the mainhand is holding a weapon
			return;
		}
		local items = this.getContainer().getActor().getItems();
		local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (_targetEntity != null && !items.hasBlockedSlot(this.Const.ItemSlot.Offhand) && (off == null || !::MSU.isNull(m.offHandSkill)))
		{
			if (!_forFree)
			{
				if (_targetTile == null) // Is this necessary?
					return;
				// i need to somehow do this more dynamically
				::Time.scheduleEvent(::TimeUnit.Virtual, ::Const.Combat.RiposteDelay, this.executeFollowUpAttack.bindenv(this), {
					TargetTile = _targetTile,
					Skill = !::MSU.isNull(m.offHandSkill) ? m.offHandSkill : m.HandToHand
				});
			}
		}
	}

	function executeFollowUpAttack( _info )
	{
		if (!::MSU.isNull(_info.Skill))
			_info.Skill.useForFree(_info.TargetTile);
	}

	function onUpdate( _properties )
	{
		local items = this.getContainer().getActor().getItems();
		local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
		local main = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if ((main == null || this.getContainer().hasEffect(::Legends.Effect.Disarmed)) && off == null && !items.hasBlockedSlot(this.Const.ItemSlot.Offhand))
		{
			_properties.MeleeDefense += 10;
			_properties.MeleeSkill += 5;

		}
	}

	function onAdded()
	{
		m.HandToHand = ::MSU.asWeakTableRef(::Legends.Actives.get(this, ::Legends.Active.HandToHand));

		local off = getContainer().getActor().getOffhandItem();

		if (off != null)
			onEquip(off);
	}

	function onEquip( _item )
	{
		if (m.ApplicableItems.find(_item.getID()) == null)
			return; // not a right one

		setOffhandSkill(_item.getPrimaryOffhandAttack());
	}

	function onUnequip( _item )
	{
		if (m.ApplicableItems.find(_item.getID()) == null)
			return;

		resetOffhandSkill();
	}

});
