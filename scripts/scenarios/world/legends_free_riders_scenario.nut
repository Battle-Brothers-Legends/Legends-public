this.legends_free_riders_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
    m = {},
    function create()
    {
        this.m.ID = "scenario.legends_free_riders";
        this.m.Name = "Free Riders";
        this.m.Description = "[p=c][img]gfx/ui/events/event_41.png[/img][/p][p]Two horsemen, light and heavy, riding together.\n\n[color=#bcad8c]Backline:[/color] Master Archer mounted.\n[color=#bcad8c]Frontline:[/color] Man-at-Arms mounted.\n[color=#bcad8c]Horsemanship:[/color] Horses start with key riding perks (Bitting, Liberty, Desensitization) which apply to the rider while mounted.[/p]";
        this.m.Difficulty = 2;
        this.m.Order = 12;
        this.m.StartingRosterTier = this.Const.Roster.getTierForSize(4);
    }

    function onSpawnAssets()
    {
        local roster = this.World.getPlayerRoster();
        local names = [];

        // Create 4 entities: Archer, Archer's Horse, Man-at-Arms, His Horse
        for (local i = 0; i < 4; i = ++i)
        {
            local bro = roster.create("scripts/entity/tactical/player");
            bro.m.HireTime = this.Time.getVirtualTimeF();
            while (names.find(bro.getNameOnly()) != null)
            {
                bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
            }
            names.push(bro.getNameOnly());
        }

        local bros = roster.getAll();

        // Master Archer (back row)
        local archer = bros[0];
        archer.setStartValuesEx(["legend_master_archer_background"]);
        archer.setPlaceInFormation(11);

        // Archer's Horse (back row neighbor)
        local archerHorse = bros[1];
        archerHorse.setStartValuesEx(["legend_horse"]);
        archerHorse.setPlaceInFormation(12);

        // Man-at-Arms (front row)
        local maa = bros[2];
        maa.setStartValuesEx(["legend_man_at_arms_background"]);
        maa.setPlaceInFormation(3);

        // Man-at-Arms' Horse (front row neighbor)
        local maaHorse = bros[3];
        maaHorse.setStartValuesEx(["legend_horse"]);
        maaHorse.setPlaceInFormation(4);

        // Give key horse perks and bind bridles to auto-mount at deployment
        local perkGrants = function(horse)
        {
            ::Legends.Perks.grant(horse, ::Legends.Perk.LegendHorseBitting);
            ::Legends.Perks.grant(horse, ::Legends.Perk.LegendHorseLiberty);
            ::Legends.Perks.grant(horse, ::Legends.Perk.LegendHorseDesensitization);
        };
        perkGrants(archerHorse);
        perkGrants(maaHorse);

        // Note: Bridles are automatically created and added to stash by the horse background
        // No need to manually create them here

        // A little starter kit
        this.World.Assets.getStash().add(this.new("scripts/items/supplies/bread_item"));
        this.World.Assets.getStash().add(this.new("scripts/items/supplies/dried_fish_item"));
        this.World.Assets.m.Money += 200;
    }

    function onSpawnPlayer()
    {
        local randomVillage;
        // Pick a reasonable starting settlement (non-military, roads, mid-size)
        for (local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i)
        {
            randomVillage = this.World.EntityManager.getSettlements()[i];
            if (!randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() >= 2)
            {
                break;
            }
        }

        local randomVillageTile = randomVillage.getTile();
        this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
        this.World.Assets.updateLook(9);
        this.World.getCamera().setPos(this.World.State.m.Player.getPos());
    }

    function onInit()
    {
        this.starting_scenario.onInit();
    }
});

