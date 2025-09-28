this.scenario_custom_map <- this.inherit("scripts/scenarios/tactical/scenario_template", {
    m = {},

    function generate()
    {
        this.createStash();
        this.initMap();
        this.initEntities();
        this.initStash();
        this.Tactical.Entities.makeEnemiesKnownToAI();
        // Use a proper music track list like vanilla scenarios (a list, not a single string)
        this.m.Music = this.Const.Music.BeastsTracks;
    }

    function initMap()
    {
        local sel = ("Legends" in getroottable() && "CustomMaps" in ::Legends && "Selected" in ::Legends.CustomMaps) ? ::Legends.CustomMaps.Selected : null;
        local map = null;
        if (sel != null && ("Script" in sel))
        {
            // Load the script; if it defines a symbol different from filename, resolve by stem
            ::logInfo("CustomMaps: loading script '" + sel.Script + "'");
            local ret = null;
            try { ret = this.new(sel.Script); }
            catch (e)
            {
                ::logError("CustomMaps: failed to load script '" + sel.Script + "' error=" + e);
            }
            if (ret != null && ("init" in ret))
            {
                ::logInfo("CustomMaps: using returned instance from new() for map");
                map = ret;
            }
            if (map == null)
            {
                // Derive symbol name from filename
                local parts = split(sel.Script, "/");
                local fname = parts[parts.len() - 1]; // e.g., 'vanilla_template_map'
                local trimmed = fname;
                if (trimmed.len() >= 4 && trimmed.slice(trimmed.len() - 4) == "_map") trimmed = trimmed.slice(0, trimmed.len() - 4);

                // Try in order: exact filename, trimmed, 'tactical_' + trimmed
                if (fname in getroottable())
                {
                    ::logInfo("CustomMaps: using root symbol (fname) '" + fname + "'");
                    map = getroottable()[fname];
                }
                else if (trimmed in getroottable())
                {
                    ::logInfo("CustomMaps: using root symbol (trimmed) '" + trimmed + "'");
                    map = getroottable()[trimmed];
                }
                else
                {
                    local alt = trimmed;
                    if (!(alt.find("tactical_") == 0)) alt = "tactical_" + trimmed;
                    if (alt in getroottable())
                    {
                        ::logInfo("CustomMaps: using alt root symbol '" + alt + "'");
                        map = getroottable()[alt];
                    }
                    else
                    {
                        ::logError("CustomMaps: no root symbol found for fname='" + fname + "' trimmed='" + trimmed + "' alt='" + alt + "'");
                        // Last resort: include script then retry symbols
                        try { ::include(sel.Script + ".nut"); } catch (e) {}
                        if (map == null && fname in getroottable()) map = getroottable()[fname];
                        else if (map == null && trimmed in getroottable()) map = getroottable()[trimmed];
                        else if (map == null && alt in getroottable()) map = getroottable()[alt];
                    }
                }
            }
        }
        if (map == null)
        {
            local templateID = (sel != null && ("Template" in sel)) ? sel.Template : "tactical.vanilla_template";
            ::logInfo("CustomMaps: falling back to MapGen.get '" + templateID + "'");
            map = this.MapGen.get(templateID);
        }
        if (map == null)
        {
            ::logError("CustomMaps: map is null after loading; aborting fill");
        }
        else
        {
            if ("init" in map) map.init();
            local minX = map.getMinX();
            local minY = map.getMinY();
            ::logInfo("CustomMaps: map size " + minX + "x" + minY);
            this.Tactical.resizeScene(minX, minY);
            local rect = { X = 0, Y = 0, W = minX, H = minY };
            // Pass 1: ground/terrain
            map.fill(rect, null, 1);
            // Pass 2: objects/overlays (if implemented)
            try { map.fill(rect, null, 2); } catch (e) { ::logInfo("CustomMaps: second pass skipped or failed: " + e); }
            // Pass 3: optional (rarely used)
            try { map.fill(rect, null, 3); } catch (e) { /* ignore */ }
        }
    }

    function initEntities()
    {
        // Simple party so maps are explorable
        for (local i = 0; i < 6; ++i)
        {
            local e = this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7);
            e.setName(this.getRandomPlayerName());
            e.setScenarioValues();
            local it = e.getItems();
            it.equip(this.new("scripts/items/helmets/hood"));
            it.equip(this.new("scripts/items/armor/padded_leather"));
            it.equip(this.new("scripts/items/weapons/militia_spear"));
            it.equip(this.new("scripts/items/shields/wooden_shield"));
        }

        // Spawn a few distant hostiles so the battle doesn\'t immediately auto-finish as victory
        // Place towards far side of the map bounds (hard-coded safe ranges for 30x20 maps)
        for (local k = 0; k < 3; ++k)
        {
            local h = this.spawnEntity("scripts/entity/tactical/enemies/ghoul", 22, 28, 8, 18);
            h.setFaction(this.Const.Faction.Beasts);
        }
    }

    function spawnEntity( _script, _minX = 10, _maxX = 28, _minY = 3, _maxY = 28 )
    {
        local x = 0;
        local y = 0;
        while (1)
        {
            x = this.Math.rand(_minX, _maxX);
            y = this.Math.rand(_minY, _maxY) - x / 2;
            local tile = this.Tactical.getTile(x, y);
            if (tile == null) continue;
            if (tile.Level > 1) continue;
            if (tile.IsEmpty) break;
        }
        return this.Tactical.spawnEntity(_script, x, y);
    }

    function initStash()
    {
        this.Stash.clear();
        // Enable pre-battle arrangement like vanilla prep scenarios
        if ("setResizable" in this.Stash) this.Stash.setResizable(true);
        if ("resize" in this.Stash) this.Stash.resize(27);
        this.Stash.setLocked(false);
    }
});
