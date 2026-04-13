this.legend_return_favor_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendReturnFavor);
		this.m.Description = "This character has assumed a defensive stance seeking to incapacitate anyone attacking.";
		this.m.Icon = "ui/perks/perk_31.png";
		this.m.IconMini = "perk_31_mini";
		this.m.Overlay = "perk_31";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]75%[/color] chance to stun and stagger any opponent missing with a melee attack (resistances and immunities still apply)."
			}
		];
	}

	function onMissed( _attacker, _skill )
	{
		local user = this.getContainer().getActor();

		if (::Tactical.TurnSequenceBar.isActiveEntity(user))
			return;

		if (_skill.isRanged())
			return;

		if (this.Math.rand(1, 100) <= 75 && !_attacker.getCurrentProperties().IsImmuneToStun && !_attacker.getSkills().hasEffect(::Legends.Effect.Stunned))
		{
			local d = _attacker.getTile().getDistanceTo(user.getTile());
			local item = user.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

			if (d <= 1 || item != null && item.isItemType(this.Const.Items.ItemType.Weapon) && d <= item.getRangeMax())
			{
				::Legends.Effects.grant(_attacker, ::Legends.Effect.Stunned, function(_effect) {
					_effect.addTurns(1);
				}.bindenv(this));
				::Legends.Effects.grant(_attacker, ::Legends.Effect.Staggered);
				if (!user.isHiddenToPlayer() && !_attacker.isHiddenToPlayer())
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " has stunned and staggered " + this.Const.UI.getColorizedEntityName(_attacker) + " for one turn");
				}
			}
		}
	}

	function onTurnStart()
	{
		this.removeSelf();
	}

});

