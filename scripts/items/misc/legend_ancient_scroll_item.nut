this.legend_ancient_scroll_item <- ::inherit("scripts/items/item", {
	m = {
		Selection = null
	},
	function create()
	{
		m.ID = "misc.ancient_scroll";
		m.Name = "Ancient Scroll";
		m.Description = "A torn-up scroll with knowledge unseen for centuries. It can be translated by a character with the interpretation perk in the crafting tent. Highly valuable to some historians, although it is useless to many. They can, however, be studied with effort and a high chance of headache. Every brother may use up to 1 scroll. Being bright increases this to 2 scrolls, and being dumb decreases this to 0 scrolls.";
		m.Icon = "trade/scroll.png";
		m.SlotType = ::Const.ItemSlot.None;
		m.ItemType = ::Const.Items.ItemType.Usable;
		m.IsDroppedAsLoot = true;
		m.IsUsable = true;
		m.Value = 50;
	}

	function playInventorySound( _eventType )
	{
		::Sound.play("sounds/scribble.wav", ::Const.Sound.Volume.Inventory);
	}

	function getTooltip()
	{
		return [
			{
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
				text = "Right-click to use on a character. Studying may lead to headaches and irritability. What mercenary wants to study?"
			},
			{
				id = 67,
				type = "text",
				text = "Every character may use up to 1 scroll. Being bright increases this to 2 scrolls, and being dumb decreases this to 0 scrolls."
			}
		];
	}

	function isAbleToUseScroll( _actor )
	{
		if (_actor.getSkills().hasTrait(::Legends.Trait.Dumb))
			return "Failed to use this scroll as the user has [color=" + ::Const.UI.Color.NegativeValue + "]Dumb[/color] trait.";

		if (_actor.getSkills().hasSkill("injury.brain_damage"))
			return "Failed to use this scroll as the user has [color=" + ::Const.UI.Color.NegativeValue + "]Brain Damage[/color] injury.";

		if (_actor.getFlags().getAsInt("LegendsScrollCount") <= 0)
			return true;

		if (!_actor.getSkills().hasTrait(::Legends.Trait.Bright) || _actor.getFlags().getAsInt("LegendsScrollCount") >= 2)
			return "This character has already reached their maximum scroll usage limit. Please use this scroll on a different character.";

		return true;
	}

	function addScrollCounter( _actor )
	{
		_actor.getFlags().increment("LegendsScrollCount");
	}

	function applySideEffect( _actor )
	{
		if (::Math.rand(0, 4) > 0)
			return;

		if (!_actor.getSkills().hasEffect(::Legends.Effect.LegendHeadache))
			::Legends.Effects.grant(_actor, ::Legends.Effect.LegendHeadache);
		else
			::Legends.Effects.grant(_actor, ::Legends.Effect.LegendIrritable); //dont have to wry about this stacking because u can aat max study twice
	}

	function applyScrollEffect( _result = null, _actor = null )
	{
		if (_result == null)
			_result = ::Math.rand(1, 5);

		switch (_result)
		{
		case 1:
			return gainGiftedEffect(_actor);

		case 2:
			return gainTrainingEffect(_actor);

		case 3:
			return addRandomPerk(_actor);

		case 4:
			return addRandomPerkTree(_actor);

		default:
			return "Nothing happens.";
		}
	}

	function gainGiftedEffect( _actor )
	{
		_actor.m.LevelUps += 1;
		_actor.fillAttributeLevelUpValues(1, true);
		return format("You gain free [color=%s]Gifted[/color] perk worth amount of level-up stats.", ::Const.UI.Color.NegativeValue);
	}

	function gainTrainingEffect( _actor )
	{
		local trained = ::Legends.Effects.get(_actor, ::Legends.Effect.Trained);

		if (trained != null)
		{
			if (!::MSU.isKindOf(trained, "injury"))
			{
				trained.m.Duration += 3;
				trained.m.XPGainMult = 1.5;
				trained.m.Description = format("Trained effect (: +50% XP for %i battles", effect.m.Duration);
			}
			else
			{
				trained.addHealingTime(3);
			}
		}
		else
		{
			trained = ::Legends.Effects.new(::Legends.Effect.Trained);
			trained.m.Description = "Trained effect (: +50% exp for 3 battles"; //todo flavor text
			trained.m.Duration = 3;
			trained.m.XPGainMult = 1.5;
		}

		_actor.getSkills().add(trained);
		return format("You gain [color=%s]%s[/color] effect that lasts for at least 3 battles.", ::Const.UI.Color.NegativeValue, trained.getName());
	}

	function addRandomPerk( _actor )
	{
		local r;
		local r2;
		local pT = _actor.getBackground().getPerkTree();
		do
		{
			r = ::Math.rand(0, pT.len()-1);
			r2 = ::Math.rand(0, pT[r].len()-1);
		}
		while (_actor.getSkills().hasSkill(pT[r][r2].ID))

		local perkDef = pT[r][r2];
		_actor.getSkills().add(::new(perkDef.Script));
		return format("You gain [color=%s]%s[/color] perk for free.", ::Const.UI.Color.NegativeValue, perkDef.Name);
	}

	function addRandomPerkTree( _actor )
	{
		local pool = [], potential = [];
		pool.extend(::Const.Perks.MagicTrees.Tree);
		pool.extend(::Const.Perks.EnemyTrees.Tree);
		pool.extend(::Const.Perks.DefenseTrees.Tree);
		pool.extend(::Const.Perks.WeaponTrees.Tree);
		pool.extend(::Const.Perks.TraitsTrees.Tree);
		pool.extend(::Const.Perks.ClassTrees.Tree);

		foreach (perkGroup in pool)
		{
			if (_actor.getBackground().hasPerkGroup(perkGroup))
				continue;

			potential.push(perkGroup);
		}

		if (potential.len() == 0)
			return format("[color=%s]No possible new perk group can be added to this character.[/color].", ::Const.UI.Color.NegativeValue);

		local tree = ::MSU.Array.rand(potential)
		_actor.getBackground().addPerkGroup(tree.Tree);
		return format("The [color=%s]%s[/color] perk group has been added to this character.", ::Const.UI.Color.NegativeValue, tree.Name);
	}

	function onUse( _actor, _item = null )
	{
		local result = isAbleToUseScroll(_actor);

		if (typeof result == "string") {
			::World.State.m.CharacterScreen.m.JSHandle.asyncCall("openPopupDialog", result);
			return false;
		}

		::World.State.m.CharacterScreen.m.JSHandle.asyncCall("openPopupDialog", applyScrollEffect(m.Selection, _actor));
		::Sound.play("sounds/scribble.wav", ::Const.Sound.Volume.Inventory);
		addScrollCounter(_actor);
		applySideEffect(_actor);
		return true;
	}

});

