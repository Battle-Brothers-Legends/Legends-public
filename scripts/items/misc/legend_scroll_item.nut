this.legend_scroll_item <- ::inherit("scripts/items/item", {
	m = {
		Selection = null,
		Cooldown = 10
	},
	function create() {
		this.item.create();
		this.m.ID = "misc.legend_scroll";
		this.m.Name = "Scroll";
		this.m.Description = "A freshly minted scroll. Could be a masterpiece used to train your mercenaries or gibberish that will be of interest to local scribes.";
		this.m.Icon = "trade/scroll.png";
		this.m.SlotType = ::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = true;
		this.m.IsUsable = true;
		this.m.Value = 2000;
		this.randomSelection();
	}

	function randomSelection() {
		local r = this.Math.rand(0, 100);
		if (r < 50)
			this.m.Selection = 0;
		else if (r < 55)
			this.m.Selection = 1;
		else if (r < 70)
			this.m.Selection = 2;
		else if (r < 85)
			this.m.Selection = 3;
		else if (r <= 100)
			this.m.Selection = 4;
	}

	function playInventorySound( _eventType ) {
		::Sound.play("sounds/scribble.wav", ::Const.Sound.Volume.Inventory);
	}

	function getTooltip() {
		local result = [{
				id = 1,
				type = "title",
				text = getName()
			},
			{
				id = 2,
				type = "description",
				text = getDescription()
			},
			{
				id = 66,
				type = "text",
				text = getValueString()
			},
			{
				id = 3,
				type = "image",
				image = getIcon()
			},
			{
				id = 65,
				type = "text",
				text = "Right-click to use on a character. Studying will lead to [color=%status%]Irritability[/color]. What mercenary wants to study?"
			},
			{
				id = 67,
				type = "text",
				text = "Will apply a [color=%negative%]" + this.getCooldown() + "[/color] day cooldown until you can read again."
			}
		];

		local actor = ::World.State.m.CharacterScreen.getSelectedActor();
		if (::World.State.isInCharacterScreen() && actor != null) {
			local injury = ::Legends.Effects.get(actor, ::Legends.Effect.LegendHeadache);
			if (injury != null) {
				result.push({
					id = 10,
					type = "text",
					icon = "ui/icons/cancel.png",
					text = "Cannot be used for next [color=%negative%]" + injury.m.HealingTimeMin + "-" + injury.m.HealingTimeMax + "[/color] days because of [color=%status%]" + injury.getName() + "[/color] status"
				});
				return result;
			}
			local effect = ::Legends.Effects.get(actor, ::Legends.Effect.LegendIrritable);
			if (effect != null) {
				result.push({
					id = 10,
					type = "text",
					icon = "ui/icons/cancel.png",
					text = "Cannot be used for next [color=%negative%]" + effect.m.HealingTime + "[/color] days because of [color=%status%]" + effect.getName() + "[/color] status"
				});
				return result;
			}
		}
		return result;
	}

	function getBuyPrice() {
		if (this.m.Selection == 0)
			return this.item.getBuyPrice();

		if (this.m.IsSold) {
			return this.getSellPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null) {
			return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.World.State.getCurrentTown().getBeastPartsPriceMult()));
		}
		else {
			return this.Math.ceil(this.getValue());
		}
	}

	// turn the nutin scroll into a trade item
	function getSellPrice() {
		if (this.m.Selection == 0)
			return this.item.getSellPrice();

		if (this.m.IsBought) {
			return this.getBuyPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null) {
			return this.Math.floor(this.getValue() * this.World.State.getCurrentTown().getBeastPartsPriceMult());
		}
		else {
			return this.Math.floor(this.getValue());
		}
	}

	function applyScrollEffect( _result = null, _actor = null ) {
		if (_result == null)
			_result = ::Math.rand(0, 4);

		switch (_result) {
		case 1:
			return gainGiftedEffect(_actor);
		case 2:
			return gainTrainingEffect(_actor);
		case 3:
			return gainExperience(_actor);
		case 4:
			return gainTrainingPoint(_actor);
		default:
			return "Nothing happens.";
		}
	}

	function getCooldown() {
		switch (this.m.Selection) {
			case 1:
				return 50;
			case 2:
				return 10;
			case 3:
				return 10;
			case 4:
				return 20;
			default:
				return 30;
		}
	}

	function applySideEffect( _actor ) {
		::Legends.Effects.grant(_actor, ::Legends.Effect.LegendHeadache, function (_effect) {
			_effect.m.IrritableHealingTime = this.getCooldown();
		}.bindenv(this));
	}


	function isAbleToUseScroll( _actor ) {
		local effect = ::Legends.Effects.get(_actor, ::Legends.Effect.LegendIrritable);
		local injury = ::Legends.Effects.get(_actor, ::Legends.Effect.LegendHeadache);
		if (injury != null)
			return "Failed to use this item as the user will be recovering from the last reading for another [color=%negative%]" + injury.m.HealingTimeMin + "-" + injury.m.HealingTimeMax +"[/color] days.";
		if (effect != null)
			return "Failed to use this item as the user will be recovering from the last reading for another [color=%negative%]" + effect.m.HealingTime + "[/color] days.";
		if (_actor.isStabled())
			return "Are you trying to make an animal read?";

		local trait = ::Legends.Traits.get(_actor, ::Legends.Trait.LegendIntensiveTraining);
		if (this.m.Selection == 4 && trait.isMaxReached())
			return "Max training achieved so this scroll is not useful on this mercenary.";

		return true;
	}

	function gainTrainingPoint( _actor ) {
		local trait = ::Legends.Traits.get(_actor, ::Legends.Trait.LegendIntensiveTraining);
		trait.addRandomSkills(_actor, 1);
		return format("You gain free [color=%s]1[/color] towards [color=%s]Intensive Training[/color].", ::Const.UI.Color.PositiveValue, ::Const.UI.Color.Status);
	}

	function gainGiftedEffect( _actor ) {
		_actor.m.LevelUps += 1;
		_actor.fillAttributeLevelUpValues(1, true);
		return format("You gain free [color=%s]Gifted[/color] perk worth amount of level-up stats.", ::Const.UI.Color.NegativeValue);
	}

	function gainExperience( _actor ) {
		_actor.addXP( this.Math.rand(100, 150));
	}

	function gainTrainingEffect( _actor ) {
		local trained = ::Legends.Effects.get(_actor, ::Legends.Effect.Trained);

		if (trained != null) {
			if (!::MSU.isKindOf(trained, "injury")) {
				trained.m.Duration += 3;
				trained.m.XPGainMult = 1.5;
				trained.m.Description = format("Trained effect (: +50% XP for %i battles", effect.m.Duration);
			}
			else {
				trained.addHealingTime(3);
			}
		}
		else {
			trained = ::Legends.Effects.new(::Legends.Effect.Trained);
			trained.m.Description = "Trained effect (: +50% exp for 3 battles"; //todo flavor text
			trained.m.Duration = 3;
			trained.m.XPGainMult = 1.5;
		}

		_actor.getSkills().add(trained);
		return format("You gain [color=%s]%s[/color] effect that lasts for at least 3 battles.", ::Const.UI.Color.NegativeValue, trained.getName());
	}

	function onUse( _actor, _item = null ) {
		local result = this.isAbleToUseScroll(_actor);

		if (typeof result == "string") {
			::World.State.m.CharacterScreen.m.JSHandle.asyncCall("openPopupDialog", ::Legends.tooltip(result));
			return false;
		}

		::World.State.m.CharacterScreen.m.JSHandle.asyncCall("openPopupDialog", this.applyScrollEffect(m.Selection, _actor));
		::Sound.play("sounds/scribble.wav", ::Const.Sound.Volume.Inventory);
		this.applySideEffect(_actor);
		return true;
	}

	function getValue() {
		if (m.Selection == null || m.Selection == 0)
			return 800;

		return this.item.getValue();
	}

	function getName() {
		switch(this.m.Selection) {
			case 0:
				return "Scroll of .Nut\'in";
			case 1:
				return "Scroll of Natural Talent";
			case 2:
				return "Battle Scroll";
			case 3:
				return "Scroll of Experience";
			case 4:
				return "Scroll of Training";
		}
	}

	function getDescription() {
		switch(this.m.Selection) {
			case 0:
				return "After a bit of labor the scroll seems to just be gibberish and there's nothing meaningful written on it. Can be sold to gullible scholars for a tidy sum.";
			case 1:
				return "Use the scroll to grant a character a max-stat roll similar to gifted.";
			case 2:
				return "Use the scroll on a character to increase experience gains by +50% for at least the next 3 battles. This will override any other current trained effects.";
			case 3:
				return "Use the scroll on a character to gain 100-150 XP.";
			case 4:
				return "Use the scroll on a character to gain 1 point in extensive training.";
		}
	}

	function onSerialize( _out ) {
		this.item.onSerialize(_out);
		_out.writeU8(this.m.Selection);
	}

	function onDeserialize( _in ) {
		this.item.onDeserialize(_in);
		this.m.Selection = _in.readU8();
	}

});

