this.legend_return_favor_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendReturnFavor);
		this.m.Description = "Has assumed a defensive stance seeking to incapacitate any attackers.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]75%[/color] chance to Stun and Stagger any opponent missing with a melee attack."
			}
		]);
		return tooltip;
	}

	function onMissed(_attacker, _skill) {
		local actor = this.getContainer().getActor();

		if (::Tactical.TurnSequenceBar.isActiveEntity(actor) || _skill.isRanged()) {
			return;
		}

		if (::Math.rand(1, 100) <= 75 && !_attacker.getCurrentProperties().IsImmuneToStun && !_attacker.getSkills().hasEffect(::Legends.Effect.Stunned)) {
			local d = _attacker.getTile().getDistanceTo(actor.getTile());
			local item = actor.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);

			if (d <= 1 || item != null && item.isItemType(::Const.Items.ItemType.Weapon) && d <= item.getRangeMax()) {
				::Legends.Effects.grant(_attacker, ::Legends.Effect.Stunned, function (_effect) {
					_effect.addTurns(1);
				}.bindenv(this));
				::Legends.Effects.grant(_attacker, ::Legends.Effect.Staggered);
				if (!actor.isHiddenToPlayer() && !_attacker.isHiddenToPlayer()) {
					::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " has stunned and staggered " + ::Const.UI.getColorizedEntityName(_attacker) + " for one turn");
				}
			}
		}
	}

	function onTurnStart() {
		this.removeSelf();
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]75%[/color] chance to Stun and Stagger opponent missing a melee attack";
	}
});
