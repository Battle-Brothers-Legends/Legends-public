this.legend_coat_with_redback_poison_skill <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendCoatWithRedbackPoison);
		this.m.Description = "Coat your weapons and arrowtips with poison. Can not be used while engaged in melee. Costs 0 Action Points during the first round of combat.";
		this.m.Icon = "skills/active_legend_coat_with_redback_poison.png";
		this.m.IconDisabled = "skills/active_legend_coat_with_redback_poison_bw.png";
		this.m.Overlay = "active_legend_coat_with_redback_poison";
		this.m.SoundOnUse = [
			"sounds/combat/poison_applied_01.wav",
			"sounds/combat/poison_applied_02.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 15;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function getTooltip() {
		local ret = [
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
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The next [color=%positive%]4[/color] attacks will apply the Poisoned status effect."
			}
		];

		if (::Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return ret;
	}

	function getCurrentItem() { // search for more poison bottles if the one under this.m.Item is empty
        if (this.m.Item.m.Ammo <= 0) {
			local self = this;
			local filledPoisons = this.getContainer().getActor().getItems().getAllItems().filter(@(_,_item) (_item.getID() == self.m.Item.getID() && _item.m.Ammo > 0));
			foreach (item in filledPoisons) {
				this.setItem(item);
				return item;
			}
		}

        return this.m.Item;
    }

	function isHidden () {
		return this.getCurrentItem().m.Ammo <= 0;
	}

	function isUsable() {
		local actor = this.getContainer().getActor();
		return (!::Tactical.isActive() || this.skill.isUsable()	&& !actor.getTile().hasZoneOfControlOtherThan(actor.getAlliedFactions())) && (this.getCurrentItem().m.Ammo > 0);
	}

	function onAfterUpdate (_properties) {
		if (::Time.getRound() == 1) {
			this.m.ActionPointCost = 0;
		}
	}

	function onUse(_user, _targetTile) {
		local poison = ::Legends.Effects.get(_user, ::Legends.Effect.LegendRedbackPoisonCoat);

		if (poison != null) {
			poison.resetTime();
		} else {
			::Legends.Effects.grant(this.m.Container, ::Legends.Effect.LegendRedbackPoisonCoat);
		}

		this.getCurrentItem().consumeAmmo();

		return true;
	}
});
