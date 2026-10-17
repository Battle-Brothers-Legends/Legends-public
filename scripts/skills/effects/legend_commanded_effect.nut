this.legend_commanded_effect <- this.inherit("scripts/skills/skill", {
	m = {
		IsAlive = true,
		IsApplied = false,
		TurnsLeft = 1
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendCommanded);
		this.m.Description = "Received commands from a superior, %they% will now push %themselves% to greater heights.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
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
				id = 11,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=%positive%]+4[/color] Action Points"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%positive%]+10[/color] Melee Skill"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%positive%]+15[/color] Ranged Skill"
			},
			{
				id = 14,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%positive%]+5[/color] Melee Defense"
			},
			{
				id = 15,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%positive%]+5[/color] Ranged Defense"
			},
			{
				id = 16,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%positive%]+50[/color] Initiative"
			},
			{
				id = 16,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "[color=%negative%]-50%[/color] Damage Received"
			}
		];
	}

	function onUpdate(_properties) {
		_properties.ActionPoints += 4;
		_properties.MeleeSkill += 10;
		_properties.RangedSkill += 15;
		_properties.MeleeDefense += 5;
		_properties.RangedDefense += 5;
		_properties.Initiative += 50;
		_properties.DamageReceivedTotalMult *= 0.5;
	}

	function onTurnStart() {
		if (!this.m.IsApplied) {
			local actor = this.getContainer().getActor();
			actor.setActionPoints(::Math.min(actor.getActionPointsMax(), actor.getActionPoints() + 4));
			this.m.IsApplied = true;
		}
	}

	function onResumeTurn() {
		if (!this.m.IsApplied) {
			local actor = this.getContainer().getActor();
			actor.setActionPoints(::Math.min(actor.getActionPointsMax(), actor.getActionPoints() + 4));
			this.m.IsApplied = true;
		}
	}

	function onDamageReceived(_attacker, _damageHitpoints, _damageArmor) {
		if (_damageHitpoints >= this.getContainer().getActor().getHitpoints()) {
			this.m.IsAlive = false;
			this.onRemoved();
		}
	}

	function onTurnEnd() {
		this.removeSelf();
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+4[/color] " + ::Legends.S.inlineIcon("action_points") + ", [color=%positive%]+10[/color] " + ::Legends.S.inlineIcon("melee_skill") + ", [color=%positive%]+15[/color] " + ::Legends.S.inlineIcon("ranged_skill") + ", [color=%positive%]+5[/color] " + ::Legends.S.inlineIcon("melee_defense") + ::Legends.S.inlineIcon("ranged_defense") + ", [color=%positive%]+50[/color] " + ::Legends.S.inlineIcon("initiative") + ", [color=%negative%]-50%[/color] " + ::Legends.S.inlineIcon("damage_received");
	}
});
