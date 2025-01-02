local mod = ::EventsFix <- { //added to Legends codebase 23/11/23 by Luft with the permission of the author, Hackflow.
    ID = "mod_events_delayed_fix_legends"
    Name = "Events and Ambitions Delayed Fix"
    Version = 0.7
}
::mods_registerMod(mod.ID, mod.Version, mod.Name);
::mods_queue(mod.ID, "mod_hooks(>=20)", function () {
    // ...
    ::mods_hookExactClass("states/world_state", function (o) {
        local function doUpdates() {
            this.m.Events.update();
            this.m.Ambitions.update();

            if (this.Time.getRealTimeF() - this.m.LastMusicUpdate > 60.0)
            {
                this.setWorldmapMusic(true);
            }
        }

        local onUpdate = o.onUpdate;
        o.onUpdate = function() {
            onUpdate();

            // If pause, in a menu or a loading screen then don't bother
            if (this.m.IsGamePaused || this.m.IsGameAutoPaused) return;
            if (this.m.MenuStack.hasBacksteps()) return;
            if (LoadingScreen != null && (LoadingScreen.isAnimating() || LoadingScreen.isVisible()))
                return;

            if (this.m.AutoEnterLocation != null && !this.m.AutoEnterLocation.isNull())
            {
                if (!(this.m.Player.getTile().isSameTileAs(this.m.AutoEnterLocation.getTile())
                      && this.m.Player.getDistanceTo(this.m.AutoEnterLocation.get())
                         <= this.Const.World.CombatSettings.CombatPlayerDistance))
                {
                    doUpdates();
                }
            }
            else if (this.m.AutoAttack != null && !this.m.AutoAttack.isNull()
                     && this.m.AutoAttack.isAlive() && !this.m.AutoAttack.isHiddenToPlayer())
            {
                if (!(this.m.Player.getDistanceTo(this.m.AutoAttack.get())
                      <= this.Const.World.CombatSettings.CombatPlayerDistance))
                {
                    doUpdates();
                }
            }
        }
    });

    // selectEvent() may fail or just drop its work for a number of reasons:
    //  - enemies nearby
    //  - battle occured
    //  - special event interfering, i.e. a reminder to look at retinue
    //  - crysis news: start, progress, end
    // All of these still require selectEvent() to finish, i.e. calculate scores for all events,
    // then they are rolled with an error - sum of scores should be updated to exclude events that
    // won't pass because of any of the above, but it's not so roll might simply miss everything.
    ::mods_hookNewObject("events/event_manager", function (o) {
        local selectEvent = o.selectEvent;
        o.selectEvent = function() {
            local gen = selectEvent();
            while (true) {
                if (resume gen == true) {
                    // If we finished but didn't get an event we need to restart quick,
                    // a retinue slot reminder is not a real event :)
                    if (!this.m.ActiveEvent || this.m.ActiveEvent.getID() == "event.retinue_slot") {
                        // Make it 100% chance to fire an event next time we get to roll that
                        this.m.LastEventTime = -99999;
                        // I won't override checks for last battle to keep things nice.
                        // There are two checks for that, one of them goes after we roll
                        // a chance to fire event and update LastCheckTime. WTF.
                        // Anyway we don't want to update LastCheckTime in vain and postpone stuff.
                        this.m.LastCheckTime = this.m.LastBattleTime
                            + 5.0 - this.World.getTime().SecondsPerHour * 2;
                    }
                    return true;
                }
                yield false;
            }
        }
    })
})
