this.perk_legend_specialist_shield_skill <- this.inherit("scripts/skills/skill", {
	m = {
			TurnsLeft = 2
		},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecialistShieldSkill);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	function isHidden()
	{
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		local hasShield = item != null && item.isItemType(this.Const.Items.ItemType.Shield);
		return (this.m.TurnsLeft == 0 || !::Tactical.isActive() || !hasShield)
	}

	function getDescription()
	{
		return "This character has mastered the use of a shield. Even when they are hit, they are able to partially deflect the impact and reduce the damage. Their dedicated practice has made forming a shieldwall as natural as breathing for them.";
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
					id = 3,
					type = "text",
					icon = "ui/icons/special.png",
					text = "[color=%positive%]"+ this.m.TurnsLeft + "[/color] instances of auto shieldwall on turn end left"
		});
		ret.push({
					id = 4,
					type = "text",
					icon = "ui/icons/special.png",
					text = "[color=%positive%]+10%[/color] damage reduction while using a shield"
		});
		return ret;
	}

	function onCombatStarted()
	{
		this.m.TurnsLeft = 2;
	}
	function onCombatFinished()
	{
		this.m.TurnsLeft = 0;
	}

	function onTurnEnd()
	{
		local actor = this.getContainer().getActor();
		# Check for shield
		if (this.m.TurnsLeft > 0 && !actor.getSkills().hasEffect(::Legends.Effect.Shieldwall) && actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null && actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).isItemType(this.Const.Items.ItemType.Shield))
		{
			# Check if they have regular shield
			if (actor.getSkills().hasActive(::Legends.Active.Shieldwall))
			{
				::Legends.Effects.grant(actor, ::Legends.Effect.Shieldwall);
				this.m.TurnsLeft--;
			}
			# Check if they have tower shield
			else if (actor.getSkills().hasActive(::Legends.Active.LegendFortify))
			{
				::Legends.Effects.grant(actor, ::Legends.Effect.LegendFortify);
				this.m.TurnsLeft--;
			}
			else
			{
				# do nothing if they have nothing. For schrat shield/buckler. Don't actually need this line but I put it here for clarity.
			}
		}
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (item != null && item.isItemType(this.Const.Items.ItemType.Shield))
		{
			_properties.DamageReceivedRegularMult *= 0.90;
		}
	}
});
