::mods_hookExactClass("contracts/contracts/roaming_beasts_desert_contract", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "Desert Fangs";
		this.m.DescriptionTemplates = [
			"Amid the burning sands, the gnawed bones of deceased travelers are starting to pile up.",
			"The harsh desert trade routes are being made even more treacherous by hungry desert beasts.",
			"Reports of a new pack of roaming desert predators have left travelers on edge.",
			"Being devoured by ferocious desert beasts was not high on your list of things to do today.",
			"Rumor is that a pack of fierce predators have been ambushing caravans in the desert.",
			"A fierce pack of sand beasts appear to have developed quite a taste for human flesh.",
			"The Viziers seek crownling warriors to expend on quelling the sand beast threat.",
			"Some kind of unnatural beasts have been haunting the shifting sands.",
			];
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		foreach (s in this.m.Screens)
		{
			if (s.ID == "Task")
			{
				s.Title = this.m.Name;
			}
			if (s.ID == "Success2")
			{
				s.Text = "[img]gfx/ui/events/event_162.png[/img]{%employer% welcomes you into his throne room. It is filled to the brim with what looks like very important people, yet you are brought in anyway. Pausing briefly because you\'re not sure if the crowd can take it, you shrug and then spill out the nachzehrers\' remains. The froth of blood and guts and heads puddles across the floor, but not a peep comes from the onlookers.\n\nAll you can hear is the soft steps of the Vizier walking over. He stares at the remains, hands clasped before him like some scientist, then he snaps his fingers and a horde of servants come over and clean up the mess. One man with a quill pen and papers makes notations. When all is said and done the Vizier returns to this throne and sits in silence. The only other sound you hear is the chinky-chank of a treasure chest being dragged over. All %reward% crowns are handed to you as promised, then you are quietly urged to leave the room.\n\n Looking back, you see the crowd return their attention to the Vizier who starts into prayers. | A man stops you outside %employer%\'s room. He has with him a few scrawny men with quill pens and ledgers. They descend upon your collection of nachzehrers and make attributions accordingly to their papers. Each one finishes and tears the page away and hands it to the first man who compares his notes. Satisfied, he hands you a purse of %reward% crowns.%SPEECH_ON%May your road be ever gilded, Crownling.%SPEECH_OFF%}";
				foreach (option in s.Options)
				{
					option.Text = "We\'re done here. (Decrease Moral Reputation)";
				}
			}
		}
	}

	o.onPrepareVariables = function ( _vars )
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_helpful = [];
		local candidates_bro1 = [];
		local candidates_bro2 = [];
		local helpful;
		local bro1;
		local bro2;

		foreach( bro in brothers )
		{
			if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Lowborn) && !bro.getBackground().isBackgroundType(this.Const.BackgroundType.OffendedByViolence) && !bro.getSkills().hasTrait(::Legends.Trait.Bright) && bro.getBackground().getID() != "background.hunter")
			{
				candidates_helpful.push(bro);
			}

			if (!bro.getSkills().hasTrait(::Legends.Trait.Player))
			{
				candidates_bro1.push(bro);

				if (!bro.getBackground().isBackgroundType(this.Const.BackgroundType.OffendedByViolence) && bro.getBackground().isBackgroundType(this.Const.BackgroundType.Combat))
				{
					candidates_bro2.push(bro);
				}
			}
		}

		if (candidates_helpful.len() != 0)
		{
			helpful = candidates_helpful[this.Math.rand(0, candidates_helpful.len() - 1)];
		}
		else
		{
			helpful = brothers[this.Math.rand(0, brothers.len() - 1)];
		}

		if (candidates_bro1.len() != 0)
		{
			bro1 = candidates_bro1[this.Math.rand(0, candidates_bro1.len() - 1)];
		}
		else
		{
			bro1 = brothers[this.Math.rand(0, brothers.len() - 1)];
		}

		if (candidates_bro2.len() > 1)
		{
			do
			{
				bro2 = candidates_bro2[this.Math.rand(0, candidates_bro2.len() - 1)];
			}
			while (bro2.getID() == bro1.getID());
		}
		else if (brothers.len() > 1)
		{
			do
			{
				bro2 = brothers[this.Math.rand(0, brothers.len() - 1)];
			}
			while (bro2.getID() == bro1.getID());
		}
		else
		{
			bro2 = bro1;
		}

		_vars.push([
			"helpfulbrother",
			helpful.getName()
		]);
		_vars.push([
			"bro1",
			bro1.getName()
		]);
		_vars.push([
			"bro2",
			bro2.getName()
		]);
		_vars.push([
			"direction",
			this.m.Target == null || this.m.Target.isNull() ? "" : this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(this.m.Target.getTile())]
		]);
	}
});
