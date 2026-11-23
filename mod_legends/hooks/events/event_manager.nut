::mods_hookExactClass("events/event_manager", function(o) {
	o.m.AllowNewsOnly <- false;
	o.m.LastNewsEventTime <- 0.0;
	o.create = function ()
	{
		local scriptFiles = this.IO.enumerateFiles("scripts/events/events/");

		foreach( i, scriptFile in scriptFiles )
		{
			this.m.Events.push(this.new(scriptFile));
		}

		if (this.Const.DLC.Desert)
		{
			this.addSpecialEvent("event.manhunters_origin_capture_prisoner");
		}

		this.addSpecialEvent("event.legends.retinue_brother_lost");
		this.addSpecialEvent("event.helped_caravan");
		this.addSpecialEvent("event.legend_legendary_locations_check");
		this.m.LastEventTime = this.Time.getVirtualTimeF();
	}

	o.addSpecialEvent = function ( _e ) {
		if (this.m.SpecialEvents.find(_e) == null)
			this.m.SpecialEvents.push(_e);
	}

	o.updateSpecialEvents = function ()
	{
		foreach( e in this.m.SpecialEvents )
		{
			if (this.getEvent(e).isValid())
			{
				if (this.canFireEvent(true, true))
				{
					this.fire(e);
				}
				else
				{
					this.Time.scheduleEvent(this.TimeUnit.Real, 4000, function ( _tag )
					{
						if (this.World.Events.canFireEvent(true, true) && this.World.Events.getEvent(e).canFire()) {
							this.World.Events.fire(e);
						}
					}, null);
				}

				return true;
			}
		}
		return false;
	}

	o.removeSpecialEvent <- function (_id) {
		foreach(i, e in this.m.SpecialEvents) {
			if (e == _id) {
				this.m.SpecialEvents.remove(i);
				break;
			}
		}
	}

	o.update = function () {
		if (this.World.State.getMenuStack().hasBacksteps() || this.LoadingScreen != null && (this.LoadingScreen.isAnimating() || this.LoadingScreen.isVisible())) {
			return;
		}

		if (("State" in this.Tactical) && this.Tactical.State != null) {
			return;
		}

		if (this.m.ActiveEvent != null) {
			if (!this.m.IsEventShown && (this.m.ActiveEvent.getScore() != 0 || this.m.ActiveEvent.isSpecial())) {
				if (!this.m.ActiveEvent.isSpecial() && this.m.ActiveEvent.getScore() < 500) {
					local parties = this.World.getAllEntitiesAtPos(this.World.State.getPlayer().getPos(), 400.0);

					foreach (party in parties) {
						if (!party.isAlliedWithPlayer()) {
							return;
						}
					}
				}

				if (this.m.ForceScreen != null) {
					this.m.ActiveEvent.setScreen(this.m.ActiveEvent.getScreen(this.m.ForceScreen));
					this.m.ForceScreen = null;
				}

				this.m.IsEventShown = this.World.State.showEventScreen(this.m.ActiveEvent) != false;
			}

			return;
		}

		if (this.updateSpecialEvents()) {
			return;
		}

		local timeF = this.Time.getVirtualTimeF();
		local newsDelay = ::World.getTime().SecondsPerHour * 0.25;

		if (this.m.Thread != null) {
			if (resume this.m.Thread != false) {
				this.m.Thread = null;
				if (this.m.ActiveEvent == null) {
            		this.m.LastNewsEventTime = timeF + newsDelay;
        		}
			}
			return;
		}

		if (timeF - this.m.LastBattleTime < 2.0) {
			return;
		}

		this.m.AllowNewsOnly = false;
		local isNewsReady = this.World.Statistics.isNewsReady();
		if (isNewsReady) {
			isNewsReady = false;
			local checkFrequency = this.Math.max(1, this.World.getSpeedMult()) * 3;
			if (timeF - this.m.LastNewsEventTime > this.World.getTime().SecondsPerHour * 2 / checkFrequency) {
				this.m.AllowNewsOnly = true;
            	isNewsReady = true;
				this.m.LastNewsEventTime = timeF;
			}
		}
		if (!isNewsReady) {
			if (this.m.LastEventTime + this.Const.Events.GlobalMinDelay > timeF) {
				return;
			}

			if (timeF - this.m.LastCheckTime <= this.World.getTime().SecondsPerHour * 2) {
				return;
			}

			this.m.LastCheckTime = timeF;
			local timeSinceLastEvent = timeF - this.m.LastEventTime - this.Const.Events.GlobalMinDelay;
			local chanceToFireEvent = this.Const.Events.GlobalBaseChance + timeSinceLastEvent * this.Const.Events.GlobalChancePerSecond;

			if (timeF - this.m.LastBattleTime >= 5.0 && this.Math.rand(1, 100) > chanceToFireEvent) {
				return;
			}
		}

		local parties = this.World.getAllEntitiesAtPos(this.World.State.getPlayer().getPos(), 400.0);
		foreach (party in parties) {
			if (!party.isAlliedWithPlayer()) {
				return;
			}
		}

		this.m.Thread = this.selectEvent();

		if (resume this.m.Thread != false) {
			this.m.Thread = null;
			if (this.m.ActiveEvent == null) {
        		this.m.LastNewsEventTime = timeF + newsDelay;
    		}
		}
	}

	o.selectEvent = function () {
		// Function is a generator.
		local score = 0;
		local eventToFire;
		local timeF = this.Time.getVirtualTimeF();
		local limit = this.Math.max(1, this.World.getSpeedMult()) * 3;
		local allowNewsOnly = this.m.AllowNewsOnly || (timeF - this.m.LastEventTime < this.Const.Events.GlobalMinDelay);
		local recentBattleCheck = timeF - this.m.LastBattleTime < 5.0;

		for (local i = 0; i < this.m.Events.len(); i = ++i) {
			local event = this.m.Events[i];
			if (this.m.LastEventID == event.getID() && !event.isSpecial()) {
				event.clear();
			} else {
				event.update();
			}

			if (i % limit == 0) {
				yield false;
			}

			local eventScore = event.getScore();
			if (eventScore <= 0 || allowNewsOnly && eventScore < 2000 || recentBattleCheck && eventScore < 500) {
				continue;
			}
			
			score += eventScore;
		}

		if (score <= 0) return true;
		local pick = this.Math.rand(1, score);
		yield false;

		for (local i = 0; i < this.m.Events.len(); i = ++i) {
			local event = this.m.Events[i];
			local eventScore = event.getScore();
			if (eventScore <= 0 || allowNewsOnly && eventScore < 2000 || recentBattleCheck && eventScore < 500) {
				continue;
			}

			if (eventScore >= 2000) {
				eventToFire = event;
				break;
			}
			if (pick <= eventScore) {
				eventToFire = event;
				break;
			}

			pick -= eventScore;		
		}

		if (eventToFire == null) {
			this.logDebug("no event???");
			return true;
		}

		yield false;
		this.m.ActiveEvent = eventToFire;
		this.m.ActiveEvent.clear();
		this.m.ActiveEvent.update();

		if (this.m.ActiveEvent.getScore() == 0) {
			this.m.ActiveEvent.clear();
			this.m.ActiveEvent = null;
			return true;
		}

		if (this.m.ActiveEvent.getScore() < 500) {
			local parties = this.World.getAllEntitiesAtPos(this.World.State.getPlayer().getPos(), 400.0);

			foreach (party in parties) {
				if (!party.isAlliedWithPlayer()) {
					this.m.ActiveEvent.clear();
					this.m.ActiveEvent = null;
					return true;
				}
			}
		}

		if (this.m.ActiveEvent.getScore() < 2000) {
			this.m.LastEventTime = this.Time.getVirtualTimeF();
		}

		this.m.ActiveEvent.fire();
		this.m.IsEventShown = this.World.State.showEventScreen(this.m.ActiveEvent);
		return true;
	}

	/**
	 * Adds new method that fires event from event instance instead of ID, to be used for events that should happens on settlement enter
	 */
	 // unused
	o.fireEvent <- function (_event) {
		if (_event != null && this.m.ActiveEvent != null && this.m.ActiveEvent.getID() != _event.getID()) {
			this.logInfo("Failed to fire event - another event with id \'" + this.m.ActiveEvent.getID() + "\' is already queued.");
			return false;
		}
		if (_event != null) {
			this.m.ActiveEvent = _event;
			this.m.ActiveEvent.fire();

			if (this.World.State.showEventScreen(this.m.ActiveEvent)) {
				return true;
			} else {
				this.m.ActiveEvent.clear();
				this.m.ActiveEvent = null;
				return false;
			}
		} else {
			this.logInfo("Failed to fire event - with id \'" + _event.getID() + "\' not found.");
			return false;
		}
	}
});
