this.perk_legend_ambidextrous <- this.inherit("scripts/skills/skill", {
	m = {
		offHandSkill = null
	},

	// takes a text string
	function setOffhandSkill ( _a )
	{
		this.m.offHandSkill = _a;
	}

	function resetOffhandSkill ()
	{
		this.m.offHandSkill = null;
	}

	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendAmbidextrous);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{	
		if (this.m.offHandSkill != null)
			return false;
		local items = this.getContainer().getActor().getItems();
		local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
		local main = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
		return !(off == null && !items.hasBlockedSlot(this.Const.ItemSlot.Offhand));
	}

	function getDescription()
	{
		local skill = this.m.offHandSkill != null ? this.m.offHandSkill : "actives.hand_to_hand";
		skill = this.getContainer().getSkillByID(skill).getName();
		return format("Fluid like water!\n\nThis character will follow up any attack with a [color=" + ::Const.UI.Color.Active + "]%s[/color] from their off hand! If both hands are free, they also gain additional melee skill and melee defense.", skill);
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

		if ((main == null || this.getContainer().hasSkill("effects.disarmed")) && off == null && !items.hasBlockedSlot(this.Const.ItemSlot.Offhand))
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
		if (!_skill.m.IsAttack || (_skill.getID() == "actives.hand_to_hand" && this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Mainhand) != null))
		{
			// Don't execute a follow up attack if the first skill is not an attack, or if you are using hand to hand while the mainhand is holding a weapon
			return;
		}
		local items = this.getContainer().getActor().getItems();
		local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (_targetEntity != null && !items.hasBlockedSlot(this.Const.ItemSlot.Offhand) && (off == null || this.m.offHandSkill != null))
		{
			if (!_forFree)
			{
				if (_targetTile == null) // Is this necessary?
					return;
				// i need to somehow do this more dynamically
				local skill = this.m.offHandSkill != null ? this.m.offHandSkill : "actives.hand_to_hand";
				local info = {
					TargetTile = _targetTile,
					skillID = skill
				};
				::Time.scheduleEvent(::TimeUnit.Virtual, ::Const.Combat.RiposteDelay, this.executeFollowUpAttack.bindenv(this), info);
			}
		}
	}

	function executeFollowUpAttack( _info )
	{
		local attack = this.getContainer().getSkillByID(_info.skillID);

		if (attack != null)
		{
			attack.useForFree(_info.TargetTile);
		}
	}

	function onUpdate( _properties )
	{
		local items = this.getContainer().getActor().getItems();
		local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
		local main = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if ((main == null || this.getContainer().hasSkill("effects.disarmed")) && off == null && !items.hasBlockedSlot(this.Const.ItemSlot.Offhand))
		{
			_properties.MeleeDefense += 10;
			_properties.MeleeSkill += 5;

		}
	}

});
