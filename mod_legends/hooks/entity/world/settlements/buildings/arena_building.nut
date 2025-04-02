::mods_hookExactClass("entity/world/settlements/buildings/arena_building", function(o)
{
	o.m.ArenaAttemptsRefresh <- 1;

	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _list)
	{
		onUpdateDraftList(_list);
		_list.push("legend_gladiator_prizefighter_background");
		_list.push("legend_gladiator_prizefighter_background");
	}

	o.refreshCooldown = function ()
	{
		if(!this.World.Assets.m.IsArenaTooled || this.m.ArenaAttemptsRefresh == 1){
			refreshCooldown();
			if(this.World.Assets.m.IsArenaTooled){
				this.m.ArenaAttemptsRefresh = 5;
			}
		}
		else{
			this.m.ArenaAttemptsRefresh--;
		}

		
	}
});
