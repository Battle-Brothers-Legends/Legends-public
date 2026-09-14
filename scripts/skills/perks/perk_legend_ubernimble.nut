this.perk_legend_ubernimble <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendUberNimble);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	function isHidden()
	{
		local fm = this.Math.floor(this.getChance() * 100);
		return fm >= 100;
	}

	function getDescription()
	{
		return "True berserkers shed even their clothes in the pursuit of unadaulterated primal slaughter. Gain nimble if you have no clothes or helm. Stacks with nimble";
	}

	function getTooltip()
	{
		local fm = this.Math.round(this.getChance() * 100);
		local tooltip = this.skill.getTooltip();
		local  bodyitem = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local  headitem = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Head);

		if (bodyitem == null && headitem == null)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Only receive [color=%positive%]" + fm + "%[/color] of any damage to hitpoints from attacks"
			});
		}
		else
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]This character isn\'t nude.[/color]"
			});
		}

		return tooltip;
	}

	function getChance()
	{
		return 0.4;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
	   local  bodyitem = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Body);
	   local  headitem = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Head);

	   if (bodyitem != null || headitem != null)
	   {
		   return
	   }

		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance())
		{
			return;
		}

		local chance = this.getChance();
		_properties.DamageReceivedRegularMult *= chance;
	}

});
