this.encounter <- {
    m = {
        ID = 0,
        Type = "",
        Name = "",
        Icon = "ui/encounters/encounter_01.png",
        Cooldown = 7.0 * ::World.getTime().SecondsPerDay,
        CooldownUntil = 0.0,
        Screens = [],
        ActiveScreen = null,
        IsActive = false,
        HasBigButtons = false,
    },

    function getID()
    {
        return this.m.ID;
    }

    function getType()
    {
        return this.m.Type;
    }

    function getTitle()
    {
        return this.buildText(this.m.Name);
    }

    function getName()
    {
        return this.m.Name;
    }

    function getActiveScreen()
    {
        return this.m.ActiveScreen;
    }

    function isActive()
    {
        return this.m.IsActive;
    }

    function hasBigButtons()
    {
        return this.m.HasBigButtons;
    }

    function setActive( _f )
    {
        this.m.IsActive = _f;
    }

    function create()
    {
        this.createScreens();
    }

    function createScreens()
    {
    }

    function start()
    {
    }

    function getActiveScreen() {
        return this.m.ActiveScreen;
    }

    function getScreen( _id )
    {
        if (typeof _id == "table" || typeof _id == "instance")
        {
            return _id;
        }

        foreach( s in this.m.Screens )
        {
            if (s.ID == _id)
            {
                return s;
            }
        }

        this.logError("Screen \"" + _id + "\" not found for encounter \"" + this.m.Type + "\".");
        return null;
    }

    function processInput( _option )
    {
        if (this.m.ActiveScreen == null)
        {
            return false;
        }

        if (_option >= this.m.ActiveScreen.Options.len())
        {
            return true;
        }

        local result = this.m.ActiveScreen.Options[_option].getResult(this);

        if (typeof result != "string" && result <= 0)
        {
            if (this.isActive())
            {
                this.setScreen(null);
            }

            return false;
        }

        this.setScreen(this.getScreen(result));
        return true;
    }

    function setScreen( _screen, _restartIfAlreadyActive = true )
    {
        if (_screen == null)
        {
            this.m.ActiveScreen = null;
            return;
        }

        if (typeof _screen == "string")
        {
            _screen = this.getScreen(_screen);
        }

        local oldID = "";

        if (this.m.ActiveScreen != null)
        {
            oldID = this.m.ActiveScreen.ID;
        }

        this.m.ActiveScreen = clone _screen;
        this.m.ActiveScreen.Contract <- this;
//        this.m.ActiveScreen.Flags <- this.m.Flags;
//        this.m.ActiveScreen.TempFlags <- this.m.TempFlags;
        this.m.ActiveScreen.Options = [];

        foreach( o in _screen.Options )
        {
            local option = {
                Text = o.Text,
                getResult = o.getResult
            };
            this.m.ActiveScreen.Options.push(option);
        }

        if ("List" in this.m.ActiveScreen)
        {
            this.m.ActiveScreen.List = [];
        }

        if ("Characters" in this.m.ActiveScreen)
        {
            this.m.ActiveScreen.Characters = [];
        }

        if (("start" in this.m.ActiveScreen) && (_restartIfAlreadyActive || this.m.ActiveScreen.ID != oldID))
        {
            this.m.ActiveScreen.start(this);
        }

        this.m.ActiveScreen.Title = this.buildText(this.m.ActiveScreen.Title);
        this.m.ActiveScreen.Text = this.buildText(this.m.ActiveScreen.Text);

        foreach( option in this.m.ActiveScreen.Options )
        {
            option.Text <- this.buildText(option.Text);
        }
    }

    function buildText( _text )
    {
        local brothers = this.World.getPlayerRoster().getAll();
        local brother1;
        local brother2;
        local notnagel;
        local slaves = [];

        for( local i = 0; i < brothers.len(); i = ++i )
        {
            if (brothers[i].getSkills().hasTrait(::Legends.Trait.Player))
            {
                notnagel = brothers[i];

                if (brothers.len() > 1)
                {
                    brothers.remove(i);
                }
            }
            else if (brothers.len() > 1 && brothers[i].getBackground().getID() == "background.slave")
            {
                slaves.push(brothers[i]);
                brothers.remove(i);
            }
        }

        local r = this.Math.rand(0, brothers.len() - 1);
        brother1 = brothers[r].getName();
        brothers.remove(r);

        if (brothers.len() != 0)
            brother2 = brothers[this.Math.rand(0, brothers.len() - 1)].getName();
        else if (slaves.len() != 0)
            brother2 = slaves[this.Math.rand(0, slaves.len() - 1)].getName();
        else if (notnagel != null)
			brother2 = notnagel.getName();
		else
			brother2 = brother1;

        local villages = this.World.EntityManager.getSettlements();
        local randomTown;

        local text;
        local vars = [
        [
			"SPEECH_ON",
			"\n\n[color=#bcad8c]\""
        ],
        [
			"SPEECH_START",
			"[color=#bcad8c]\""
        ],
        [
			"SPEECH_OFF",
			"\"[/color]\n\n"
        ],
        [
			"companyname",
			this.World.Assets.getName()
        ],
        [
			"randomname",
			this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]
        ],
        [
			"randomnoble",
			this.Const.Strings.KnightNames[this.Math.rand(0, this.Const.Strings.KnightNames.len() - 1)]
        ],
        [
			"randombrother",
			brother1
        ],
        [
			"randombrother2",
			brother2
        ],
        [
			"randomtown",
			randomTown
        ]
        ];
        this.onPrepareVariables(vars);
        return this.buildTextFromTemplate(_text, vars);
    }

    function getUITitle()
    {
        if (this.m.ActiveScreen && "Title" in this.m.ActiveScreen)
        {
            return this.m.ActiveScreen.Title;
        }
        else
        {
            return this.m.Name;
        }
    }

    function getUIButtons()
    {
        local buttons = [];

        foreach( i, option in this.m.ActiveScreen.Options )
        {
            buttons.push({
                id = i,
                text = option.Text
            });
        }

        return buttons;
    }

    function getUIContent()
    {
        local result = [];
        result.push({
            id = 1,
            type = "description",
            text = this.m.ActiveScreen.Text
        });
        return result;
    }

    function getUIList()
    {
        local ret = [];

        if (this.m.ActiveScreen.List.len() != 0)
        {
            local list = {
                title = "",
                items = this.m.ActiveScreen.List,
                fixed = false
            };
            ret.push(list);
        }
        return ret;
    }

    function getUIImage()
    {
        return this.m.ActiveScreen.Image;
    }

    function getUICharacterImage( _index = 0 )
    {
        if (("Characters" in this.m.ActiveScreen) && this.m.ActiveScreen.Characters.len() > _index)
        {
            return {
                Image = this.m.ActiveScreen.Characters[_index],
                IsProcedural = true
            };
        }
        else if (("Banner" in this.m.ActiveScreen) && _index > 0)
        {
            return {
                Image = this.m.ActiveScreen.Banner,
                IsProcedural = false
            };
        }
    }

    function getUIMiddleOverlay()
    {
        return null;
    }

    function isValid(_settlement)
    {
        return false;
    }

    function isOnCooldown() {
        return this.m.CooldownUntil > this.Time.getVirtualTimeF()
    }

    function reset()
    {
        this.m.CooldownUntil = 0;
        this.clear();
    }

    function clear()
    {
        this.onClear();
    }

    function onPrepareVariables( _vars )
    {
    }

    function onClear()
    {
    }

    function colorizeDone( _str )
    {
        return "[color=#30ac2a]" + _str + "[/color]";
    }

    function importScreens( _screens )
    {
        this.m.Screens.extend(_screens);
    }

    function fire()
    {
		if (this.m.Screens.len() > 0)
        	this.setScreen(this.m.Screens[0]);
        this.m.CooldownUntil = this.Time.getVirtualTimeF() + this.m.Cooldown;
    }

    function onSerialize( _out ) {
        _out.writeF32(this.m.CooldownUntil);
    }

    function onDeserialize( _in ) {
        this.m.CooldownUntil = _in.readF32();
    }

};

