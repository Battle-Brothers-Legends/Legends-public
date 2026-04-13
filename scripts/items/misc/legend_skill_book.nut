this.legend_skill_book <- ::inherit("scripts/items/item", {
	m = {
		Selection = null,
		PerkGroups = [],
		PerkGroupSelection = null,
		HasToBeIdentified = false,
		Cooldown = 50, // default for skillbooks
		BookName = ""
	},
	function create()
	{
		this.item.create();
		this.m.ID = "";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Icon = "";
		this.m.SlotType = ::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = true;
		this.m.IsUsable = true;
		this.m.Value = 0;
	}

	function playInventorySound( _eventType )
	{
		::Sound.play("sounds/scribble.wav", ::Const.Sound.Volume.Inventory);
	}

	function addScrollCounter (_actor) {}

	function getTooltip()
	{
		local result = [
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
				id = 66,
				type = "text",
				text = this.getValueString()
			},
			{
				id = 3,
				type = "image",
				image = this.getIcon()
			},
			{
				id = 65,
				type = "text",
				text = "Right-click to use on a character. Studying will lead to [color=%status%]Irritability[/color]. What mercenary wants to study?"
			},
			{
				id = 66,
				type = "text",
				text = "Will apply a " + this.m.Cooldown + " day cooldown until you can read again."
			}
		];

		if (::MSU.String.endsWith(this.m.ID, "skill_book"))
		{
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "You can only read one skill book per character, so choose wisely"
			});
		}

		if (this.m.HasToBeIdentified && ::World.Assets.m.HasScholars > 0 || !this.m.HasToBeIdentified)
		{
			local selection = this.m.PerkGroupSelection;
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Reading this will allow the user to learn [color=%negative%]" + selection + "[/color] perk group. Following perks will be added if not already in the tree:"
			});

			local tree = ::MSU.deepClone(this.m.PerkGroups.filter(function (_, _it) { return _it.Name == this.m.PerkGroupSelection; }.bindenv(this)).top().Tree);
			foreach (perk in tree.reduce(function (a, b) { a.extend(b); return a; }).map(@(_def) ::Const.Perks.PerkDefObjects[_def])) {
				result.push({
					id = 10,
					type = "text",
					text = "[leg_img](gfx/" + perk.Icon + ",height=20px,width=20px)[/leg_img] [color=%perk%]" + perk.Name + "[/color]"
				});
			}
		}
		else
		{
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Reading this will allow the user to learn a perk group, but the company does not have a Scholar to know which exactly",
			});
		}

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
			if (this.m.ID.find("ancient_scroll") != null && (actor.getSkills().hasTrait(::Legends.Trait.Bright) && actor.getFlags().getAsInt("LegendsScrollCount") > 2 || actor.getFlags().getAsInt("LegendsScrollCount"))) {
				result.push({
					id = 10,
					type = "text",
					icon = "ui/icons/cancel.png",
					text = "Cannot be used as this chracter has already read a skill book"
				});
				return result;
			}
			if (actor.getFlags().has("LegendsSkillBookCount") && this.m.ID.find("book") != null)
			{
				result.push({
					id = 10,
					type = "text",
					icon = "ui/icons/cancel.png",
					text = "Cannot be used as this chracter has already read a skill book"
				});
				return result;
			}
		}

		return result;
	}

	function getName()
	{
		if (this.m.HasToBeIdentified && ::World.Assets.m.HasScholars > 0 || !this.m.HasToBeIdentified)
			return this.m.BookName + " " + this.m.PerkGroupSelection;
		else
			return this.m.BookName + " " + "Unidentified";
	}

	function isAbleToUseScroll( _actor )
	{
		local effect = ::Legends.Effects.get(_actor, ::Legends.Effect.LegendIrritable);
		local injury = ::Legends.Effects.get(_actor, ::Legends.Effect.LegendHeadache);
		if (injury != null)
			return "Failed to use this item as the user will be recovering from the last reading for another [color=%negative%]" + injury.m.HealingTimeMin + "-" + injury.m.HealingTimeMax +"[/color] days because of [color=%status%]" + injury.getName() + "[/color].";
		if (effect != null)
			return "Failed to use this item as the user will be recovering from the last reading for another [color=%negative%]" + effect.m.HealingTime + "[/color] days because of [color=%status%]" + effect.getName() + "[/color].";

		if (_actor.isStabled())
			return "Are you trying to make an animal read?";

		if (!_actor.getFlags().has("LegendsSkillBookCount"))
			return true;

		return "This character cannot potentially learn anything from this.";
	}

	function onUse( _actor, _item = null )
	{
		local result = this.isAbleToUseScroll(_actor);
		if (typeof result == "string")
		{
			::World.State.m.CharacterScreen.m.JSHandle.asyncCall("openPopupDialog", ::Legends.tooltip(result));
			return false;
		}

		local tree = null;
		foreach (perkGroup in this.m.PerkGroups)
		{
			if (perkGroup.Name == this.m.PerkGroupSelection)
			{
				tree = perkGroup;
			}
		}

		if (_actor.getBackground().hasPerkGroup(tree)) {
			::World.State.m.CharacterScreen.m.JSHandle.asyncCall("openPopupDialog", ::Legends.tooltip("[color=%negative%]No possible new perk group can be added to this character.[/color]"));
			return false;
		}

		_actor.getBackground().addPerkGroup(tree.Tree);

		::World.State.m.CharacterScreen.m.JSHandle.asyncCall("openPopupDialog", ::Legends.tooltip("The [color=%negative%]%group%[/color] perk group has been added to this character.", [["group", this.m.PerkGroupSelection]]));
		::Sound.play("sounds/scribble.wav", ::Const.Sound.Volume.Inventory);

		this.addScrollCounter(_actor);

		::Legends.Effects.grant(_actor, ::Legends.Effect.LegendHeadache, function (_effect) {
			_effect.m.IrritableHealingTime = this.m.Cooldown;
		}.bindenv(this));

		return true;
	}

	function onSerialize( _out )
	{
		this.item.onSerialize(_out);
		_out.writeString(this.m.PerkGroupSelection);
	}

	function onDeserialize( _in )
	{
		this.item.onDeserialize(_in);
		this.m.PerkGroupSelection = _in.readString();
	}

});
