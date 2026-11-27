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
		local effect = this.getContainer().getActor().getCurrentProperties().IsSpecializedInMaces ? 75 : 25;
		tooltip.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Any opponent missing with a melee attack will get debuffed with either [color=%effect%]Stunned[/color] or [color=%effect%]Dazed[/color]"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]%_effect%%[/color] chance to apply [color=%effect%]Stunned[/color], else will apply [color=%effect%]Dazed[/color]",
				param = [
					["_effect", effect]
				]
			}
		]);
		return tooltip;
	}

	function onMissed(_attacker, _skill) {
		local actor = this.getContainer().getActor();

		if (::Legends.S.isEntityNullOrDead(_attacker, actor) || ::Tactical.TurnSequenceBar.isActiveEntity(actor) || _skill.isRanged()) {
			return;
		}

		local item = actor.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);
		local d = _attacker.getTile().getDistanceTo(actor.getTile());

		if (item != null && d <= item.getRangeMax()) {
			local stunBracket = actor.getCurrentProperties().IsSpecializedInMaces ? 75 : 25;
			local effect = null;
			local attackerProperties = _attacker.getCurrentProperties();
			if (::Math.rand(1, 100) <= stunBracket && !attackerProperties.IsImmuneToStun && !::Legends.Effects.has(_attacker, ::Legends.Effect.Stunned)) {
				effect = ::Legends.Effects.grant(_attacker, ::Legends.Effect.Stunned, function (_effect) {
					_effect.addTurns(1);
				}.bindenv(this));
				if (!actor.isHiddenToPlayer() && !_attacker.isHiddenToPlayer()) {
					::Tactical.EventLog.log(effect.getLogEntryOnAdded(::Const.UI.getColorizedEntityName(actor), ::Const.UI.getColorizedEntityName(_attacker)));
				}
			} else if (!attackerProperties.IsImmuneToDaze) {
				effect = ::Legends.Effects.grant(_attacker, ::Legends.Effect.Dazed);
				if (!actor.isHiddenToPlayer() && !_attacker.isHiddenToPlayer()) {
					::Tactical.EventLog.log(effect.getLogEntryOnAdded(::Const.UI.getColorizedEntityName(actor), ::Const.UI.getColorizedEntityName(_attacker)));
				}
			}
		}
	}

	function onUpdate(_properties) {
		local item = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);
		if (item == null || !item.isItemType(::Const.Items.ItemType.Weapon) || !item.isWeaponType(::Const.Items.WeaponType.Mace)) {
			this.removeSelf();
		}
	}

	function onTurnStart() {
		this.removeSelf();
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		local effect = _activeEntity.getCurrentProperties().IsSpecializedInMaces ? 75 : 25;
		return "[color=%positive%]" + effect + "%[/color] chance to apply [color=%effect%]Stunned[/color], else will apply [color=%effect%]Dazed[/color] an opponent missing a melee attack";
	}
});
