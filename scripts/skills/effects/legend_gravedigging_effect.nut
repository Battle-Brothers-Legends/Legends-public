this.legend_gravedigging_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Stacks = 0
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendGravedigging);
		this.m.Description = "This character gets unnaturally excited about dead bodies.";
	}

	function getTooltip() {
		local bonus = this.getCorpses();
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
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%positive%]+" + bonus + "[/color] Initiative"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=%positive%]+" + bonus + "[/color] Damage"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%positive%]+" + bonus + "[/color] Resolve"
			}
		];
	}

	function isHidden() {
		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon == null || !(weapon.isWeaponType(::Const.Items.WeaponType.Mace) && weapon.isItemType(::Const.Items.ItemType.TwoHanded)) || getCorpses() == 0;
	}

	function getCorpses() {
		if (!this.getContainer().getActor().isPlacedOnMap()) {
			return 0;
		}
		return ::Math.floor(::Tactical.Entities.getCorpses().len() / 2);
	}

	function onUpdate(_properties) {
		if (!::Tactical.isActive()) {
			this.m.Stacks = 0;
			return;
		}

		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		this.m.Stacks = (item != null && item.isWeaponType(::Const.Items.WeaponType.Mace) && item.isItemType(::Const.Items.ItemType.TwoHanded) ? getCorpses() : 0);

		if (!(item.getID() == "weapon.legend_shovel")) {
			this.m.Stacks = ::Math.min(5, this.m.Stacks);
		}

		_properties.Initiative += this.m.Stacks;
		_properties.Bravery += this.m.Stacks;
		_properties.DamageRegularMin += this.m.Stacks;
		_properties.DamageRegularMax += this.m.Stacks;
	}

	function onCombatStarted() {
		this.m.Stacks = 0;
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+" + this.m.Stacks + "[/color] " + ::Legends.S.inlineIcon("initiative") + ::Legends.S.inlineIcon("bravery") + ::Legends.S.inlineIcon("regular_damage");
	}
});
