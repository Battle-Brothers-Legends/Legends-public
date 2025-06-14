::mods_hookExactClass("events/events/beggar_begs_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]{As you take stock of the inventory, you can\'t help but notice %beggar% lingering in your peripheral. Sighing, you finally turn to the %formerbeggar% and ask what %they_beggar% wants. Like the poorest of the poor %they_beggar% holds a hand out, asking if maybe you could spare a few crowns. | With practiced theatrics, %beggar% approaches you and lets loose a long tale of troubles and squabbles and empty bottles. The %formerbeggar% is down on %their_beggar% luck, apparently, and just needs a few extra crowns to get by. | %otherguy% tells you that %beggar% is going around the camp asking for crowns. Apparently the %formerbeggar% just needs a little more, expressing a longwinded sob story to anyone who\'ll listen. Hearing this news, you go to see the %person_beggar% yourself but before you can even get a word out the %person_beggar% lets loose %their_beggar% long narrative. Finished, %they_beggar% looks you in the eye, trying to gauge whether or not you\'ll give %them_beggar% something. | Apparently %beggar% the former beggar needs some help. %They_beggar%\'s come to you, begging for a few crowns to help %them_beggar% get by. The %person_beggar% looks like %they_beggar%\'s in a poor state, but %they_beggar%\'s had plenty of practice of actually being poor so it\'s hard to tell if %they_beggar%\'s being honest or not.}";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]{You tell the %justbeggar% you\'ll cross %their_beggar% hands with a sword if %they_beggar% doesn\'t get back to work. The %person_beggar% shrugs and pretty much does as told. That was easier than expected. | The %justbeggar%\'s shoulders sag as you tell %them_beggar% to get back to work. You feel a little bad, but then remember that\'s how they get ya.}";
				local start = s.start;
				s.start <- function (_event) {
					start(_event);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases slightly"
					});
				}
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]{The %justbeggar% takes the crowns and with a smile gets right back to work. | Tired of %their_beggar% games, you give the %justbeggar% a few crowns and tell %them_beggar% to get back to work. %They_beggar% bows and thanks you and, surprisingly, actually gets back to work.}";
				local start = s.start;
				s.start <- function (_event) {
					start(_event);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases slightly"
					});
				}
			}
		}
	}

	local onPrepareVariables = o.onPrepareVariables;
	o.onPrepareVariables = function ( _vars )
	{
		onPrepareVariables(_vars);
		local beggar = this.m.Beggar.getGender() == 0 ? "former beggar" : "widow";
		local justBeggar = this.m.Beggar.getGender() == 0 ? "beggar" : "widow";
		_vars.push([
			"justbeggar",
			justBeggar
		]);
		_vars.push([
			"formerbeggar",
			beggar
		]);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Beggar.getGender(), "beggar");
	}
})
