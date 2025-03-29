::mods_hookExactClass("events/events/killer_vs_others_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_06.png[/img]While you attempt to study some poorly drawn maps, the sound of blades being drawn pierces your ears. You roll up your work and put it into a scroll\'s sleeve before making way to the disturbance.\n\n%killerontherun% is being held down by one mercenary\'s knee, while %otherguy1% and %otherguy2% look about ready to chop a head off. Seeing your arrival, the mercenaries calm down for a moment. They explain that the killer tried to slay one of them. Indeed, the speaker has a nick on their neck. A little bit deeper and something other than words would be coming out of their mouth right about now. The company demand %killerontherun% be hanged for this attempted murder.";
				s.Options[0].Text = "Have the knave flogged for this.";
				s.Options[1].Text = "Have the villain hanged for this.";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_38.png[/img]You order the attacker flogged. %killerontherun% spits on your name while being tied to a tree. You say if that happens again you\'ll add more lashings. They rip the back of perpertrators shirt and take turns with the whip as you stand by the side, counting. On the first lash a straight line of skin is stripped from %killerontherun%\'s back, who flinches and you hear the binding ropes draw taut as tense hands clench into fists. By the fifth lashing %killerontherun% is no longer standing, and no longer awake by the tenth. After five more you call it, and order the mercenaries to untie the bonds and tend the wounds.";
				local start = s.start;
				s.start <- function ( _event ) {
					this.World.Assets.addMoralReputation(1);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases slightly"
					});
					start(_event);
				}
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_02.png[/img]You order the attacker hanged. Half the company cheers and %killerontherun% screams a shriek rather suitable for seeing death ordered. They drag %killerontherun% beneath a tree. Ropes are thrown up over the branches, again and again, looping and drawing taut. One mercenary ties a noose while the others cheer and clap and drink beer. A stool is placed and the condemned is forced to stand on it. %killerontherun%\'s head is put into the noose, who claims to have a word for all of you, but is cut off when %otherguy1% kicks the stool out from below.\n\nThis is not a good way to die. It is by an executioner\'s hand or means. Ordinarily someone dropped from a platform breaks their neck, or is even decapitated. This one hangs choking and kicking. You hear some screams in lungs, but they struggle to reach the throat. A few minutes pass and %killerontherun% is still fighting. %otherguy2% steps over to the dying mercenary, grabbing one of the jerking feet to keep it still, and with a free hand stabs %killerontherun% in the heart. And that was that.\n\n{Surprisingly, the brothers agree to cut the attacker down for a burial. | The killer is left hanging there when the company\'s march begins anew.}";
				s.start <- function ( _event ) {
					this.World.Assets.addMoralReputation(-1);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases slightly"
					});
					this.Characters.push(_event.m.OtherGuy1.getImagePath());
					this.List.push({
						id = 13,
						icon = "ui/icons/kills.png",
						text = _event.m.Killer.getName() + " has died"
					});
					_event.m.Killer.getItems().transferToStash(this.World.Assets.getStash());
					_event.m.Killer.getSkills().onDeath(this.Const.FatalityType.None);
					::Legends.addFallen(_event.m.Killer, "Hanged for attempted murder");
					this.World.getPlayerRoster().remove(_event.m.Killer);
					_event.m.OtherGuy1.improveMood(2.0, "Got satisfaction with " + _event.m.Killer.getNameOnly() + "\'s hanging");

					if (_event.m.OtherGuy1.getMoodState() >= this.Const.MoodState.Neutral) {
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.OtherGuy1.getMoodState()],
							text = _event.m.OtherGuy1.getName() + this.Const.MoodStateEvent[_event.m.OtherGuy1.getMoodState()]
						});
					}
				}
			}

			if (s.ID == "D") {
				s.Text = "[img]gfx/ui/events/event_64.png[/img]While you try to bring peace between a party of misfits, your attempts for neutrality only seem to anger a few of them. In particular, the one with the nicked neck is seething, swearing and kicking things over. A few of the others worry aloud about a lack of discipline.";
				local start = s.start;
				s.start <- function ( _event ) {
					this.World.Assets.addMoralReputation(-1);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases slightly"
					});
					start(_event);
				}
			}
			if (s.ID == "E") {
				s.Text = "[img]gfx/ui/events/event_64.png[/img]The call for cooler heads to prevail seems to have failed as %killerontherun%\'s body is found dead anyway. {It appears someone stabbed the killer in the back. | Someone garroted the killer with a line of strong linen. | %killerontherun% was nearly chopped in half, the work of a truly angry person. | %killerontherun%\'s head was found resting next to their chest, hands placed in such a manner as to be holding it. | Emphasis on the word \'body\', as the head was nowhere to be found. | Someone had slit %killerontherun% \'s throat in the night. | Bruises on the body and cuts on the hands suggests a fight, but whoever it was managed to gut the killer anyway.} You have a good guess as to who did it, but none of the mercenaries seem all that upset about the killer\'s death and certain proof would elude any kind of investigation. While all of that may be true, you still order the suspected mercenary to help bury the dead.";
				s.start <- function ( _event ) {
					this.World.Assets.addMoralReputation(-2);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases"
					});
					this.Characters.push(_event.m.OtherGuy1.getImagePath());
					local dead = _event.m.Killer;
					::Legends.addFallen(dead, "Murdered by his fellow brothers");
					this.List.push({
						id = 13,
						icon = "ui/icons/kills.png",
						text = _event.m.Killer.getName() + " has died"
					});
					_event.m.Killer.getItems().transferToStash(this.World.Assets.getStash());
					_event.m.Killer.getSkills().onDeath(this.Const.FatalityType.None);
					::Legends.addFallen(_event.m.Killer, "Murdered by his fellow comrades");
					this.World.getPlayerRoster().remove(_event.m.Killer);
					local brothers = this.World.getPlayerRoster().getAll();

					foreach( bro in brothers )
					{
						if (bro.getID() == _event.m.OtherGuy1.getID())
						{
							continue;
						}

						if (this.Math.rand(1, 100) <= 33)
						{
							continue;
						}

						bro.worsenMood(1.0, "Concerned about lack of discipline");

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
				}
			}
			if (s.ID == "F") {
				s.Text = "Well, %killerontherun% isn\'t dead, but stands before you broken and beaten. It looks like vengeful justice was found anyway. %killerontherun% demands that some suspected mercenaries be punished for going around your orders. You consider this, but then ask the killer what will happen if you continue this cycle of violence. It\'s hard to see the %killerontherun% \'s face as it is puffed up in blacks and purples, with eyes are lost behind puckered lids, but you see the gingerly nods. You are right. It is best to let this whole thing die down lest it get out of control.";
				local start = s.start;
				s.start <- function ( _event ) {
					this.World.Assets.addMoralReputation(-1);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases slightly"
					});
					start(_event);
				}
			}
		}
	}
})
