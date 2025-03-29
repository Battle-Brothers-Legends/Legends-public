local g_modHooks = { }, g_newHooks = null, g_exactHooks = null, g_inheritHooks = null, g_inheritAllHooks = null, g_oneTimeHooks = { }, g_parents = { }, g_states = { };
local g_cssFiles = [ ], g_jsFiles = [ ], g_mods = [ ], g_queue = [ ];

local varcall = function(func, args)
{
  switch(args.len())
  {
    case 0: return func();
    case 1: return func(args[0]);
    case 2: return func(args[0], args[1]);
    case 3: return func(args[0], args[1], args[2]);
    case 4: return func(args[0], args[1], args[2], args[3]);
    case 5: return func(args[0], args[1], args[2], args[3], args[4]);
    case 6: return func(args[0], args[1], args[2], args[3], args[4], args[5]);
    case 7: return func(args[0], args[1], args[2], args[3], args[4], args[5], args[6]);
    case 8: return func(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7]);
    default: throw "Too many arguments: " + args.len();
  }
}

local wrapInstance = function(o)
{
  local wrapper = { };
  foreach(k,_v in o.getclass())
  {
    local v = o[k];
    wrapper[k] <- typeof(v) == "function" ? @(...) varcall(v.bindenv(o), vargv) : v;
  }
  return wrapper;
}

::mods_addHookCore <- function(hooks, name, func)
{
  if(!(name in hooks)) hooks[name] <- [ ];
  if(func) hooks[name].append(func);
}

::mods_addHook <- function(name, func = null) { ::mods_addHookCore(g_modHooks, name, func); }

::mods_callHookCore <- function(hooks, name, args)
{
  if(hooks != null && name in hooks)
  {
    local funcs = hooks[name];
    for(local i = 0; i < funcs.len(); )
    {
      local func = funcs[i];
      local result = varcall(func, args);
      if(result != null) return result;
      if (i < funcs.len() && funcs[i] == func) ++i; // only increment if the hook didn't remove itself
    }
  }

  return null;
}

::mods_callHook <- function(name, ...) { return ::mods_callHookCore(g_modHooks, name, vargv); }

::mods_removeHookCore <- function(hooks, name, func)
{
  if(name in hooks)
  {
    local funcs = hooks[name], index = funcs.find(func);
    if(index != null) funcs.remove(index);
  }
}

::mods_removeHook <- function(name, func) { ::mods_removeHookCore(g_modHooks, name, func); }

::mods_hookNewObject <- function(name, func, once = false)
{
  if(g_newHooks == null)
  {
    g_newHooks = { };
    ::mods_addHook("new", @(n,o) ::mods_callHookCore(g_newHooks, n, [o]));
  }

  local scriptName = "scripts/" + name, hook = func;
  if(once)
  {
    hook = function(o)
    {
      o = func(o);
      ::mods_removeHookCore(g_newHooks, scriptName, hook);
      if(!(scriptName in g_oneTimeHooks)) g_oneTimeHooks[scriptName] <- [ ];
      g_oneTimeHooks[scriptName].append(hook);
      return o;
    };
  }

  ::mods_addHookCore(g_newHooks, scriptName, hook);
}

::mods_hookNewObjectOnce <- function(name, func) { ::mods_hookNewObject(name, func, true); }

::mods_hookClass <- function(name, func, abstract = false, childrenOnly = true)
{
  if(!abstract) ::mods_hookNewObject(name, func);

  local hooks = childrenOnly ? g_inheritHooks : g_inheritAllHooks;
  if(hooks == null)
  {
    if(childrenOnly) hooks = g_inheritHooks = { };
    else hooks = g_inheritAllHooks = { };
  }
  ::mods_addHookCore(hooks, "scripts/" + name, func);
}

::mods_hookBaseClass <- function(name, func) { ::mods_hookClass(name, func, true); }

::mods_hookExactClass <- function(name, func)
{
  if(g_exactHooks == null) g_exactHooks = { };
	::logInfo("mods_hookExactClass " + name);
  ::mods_addHookCore(g_exactHooks, "scripts/" + name, func);
}

::mods_hookChildren <- function(name, func) { ::mods_hookBaseClass(name, func); }
::mods_hookDescendants <- function(name, func) { ::mods_hookClass(name, func, true, false); }

::mods_addField <- function(obj, className, fieldName, value)
{
  ::mods_getClassForOverride(obj, className).m[fieldName] <- value;
}

::mods_addMember <- function(obj, className, memberName, value)
{
  ::mods_getClassForOverride(obj, className)[memberName] <- value;
}

::mods_getClassForOverride <- function(obj, className)
{
  return className ? ::mods_isClass(obj, className) || obj : obj;
}

::mods_getField <- function(obj, fieldName)
{
  while(true)
  {
    if("m" in obj && fieldName in obj.m) return obj.m[fieldName];
    else obj = obj[obj.SuperName];
  }
}

::mods_getMember <- function(obj, key)
{
  while(true)
  {
    if(key in obj) return obj[key];
    else obj = obj[obj.SuperName];
  }
}

::mods_isClass <- function(obj, className)
{
  if("ClassName" in obj && obj.ClassName == className)
  {
    return obj;
  }
  else
  {
    for(local o = obj; "SuperName" in o; )
    {
      local baseName = o.SuperName;
      o = o[baseName];
      if(baseName == className) return o;
    }
    return null;
  }
}

::mods_override <- function(obj, key, value)
{
  while(true)
  {
    if(key in obj) { obj[key] = value; break; }
    else obj = obj[obj.SuperName];
  }
}

::mods_overrideField <- function(obj, fieldName, value)
{
  while(true)
  {
    if("m" in obj && fieldName in obj.m) { obj.m[fieldName] = value; break; }
    else obj = obj[obj.SuperName];
  }
}

this.logInfo("mod_hooks: Redirecting core functions");

local function replace(str, sub, rep)
{
  local s, i;
  for(i = 0; i < str.len(); )
  {
    local e = str.find(sub, i);
    if(e == null) break;
    if(s == null) s = "";
    s += str.slice(i, e) + rep;
    i = e + sub.len();
  }
  if(s == null) return str;
  return s + str.slice(i);
}

local inheritFunc = inherit;
inherit = function(baseScript, newMembers)
{
  local currentScript = getstackinfos(2).src.slice(0, -4);
  // some people compile scripts incorrectly so the embedded path does not start with "scripts/". try to fix it. first, replace
  // backslashes with forward slashes and then chop off anything before the last "scripts/" within the path
  currentScript = replace(currentScript, "\\", "/");
  local i = -8; // 8 is the length of "scripts/"
  for(local j; (j = currentScript.find("scripts/", i+8)) != null; i = j) { }
  if(i > 0) currentScript = currentScript.slice(i);

  g_parents[currentScript] <- baseScript;
  local c = inheritFunc(baseScript, newMembers);
  return ::mods_callHook("inherit", baseScript, currentScript, c) || c;
}

local newFunc = new;
new = function(scriptName)
{
  local o = newFunc(scriptName);
  return ::mods_callHook("new", scriptName, o) || o;
}

local wrapSpawnFunc = function(func)
{
  return function(scriptName, ...) {
    local args = [ scriptName ];
    args.extend(vargv);
    local o = varcall(func, args);
    return ::mods_callHook("new", scriptName, o) || o;
  }
}

Tactical.spawnEntity = wrapSpawnFunc(Tactical.spawnEntity);
World.spawnEntity = wrapSpawnFunc(World.spawnEntity);
World.spawnLocation = wrapSpawnFunc(World.spawnLocation);

local getPlayerEntityFunc = World.getPlayerEntity, lastPlayer = null;
World.getPlayerEntity = function()
{
  local o = getPlayerEntityFunc();
  if(o != (lastPlayer != null ? lastPlayer.ref() : null))
  {
    lastPlayer = o != null ? o.weakref() : null;
    o = ::mods_callHook("new", "scripts/entity/world/player_party", o) || o;
  }

  return o;
}

local wrapRoster = function(roster)
{
  local wrapper = typeof(roster) == "instance" ? wrapInstance(roster) : roster;
  local createFunc = wrapper.create;
  wrapper.create = function(scriptName)
  {
    local o = createFunc(scriptName);
    return ::mods_callHook("new", scriptName, o) || o;
  }
  return wrapper;
}

local wrapRosterFunc = function(func)
{
  local lastRoster, wrapper;
  return function() {
    local roster = func();
    if(roster != (lastRoster != null ? lastRoster.ref() : null))
    {
      lastRoster = roster.weakref();
      wrapper = wrapRoster(roster);
    }
    return wrapper;
  }
}

local wrapRosterFunc1 = function(func)
{
  local lastRoster = { }, wrapper = { };
  return function(id) {
    local roster = func(id);
    if(roster != (id in roster ? lastRoster[id] : null)) // weakrefs inside tables magically evaluate to the .ref()
    {
      lastRoster[id] <- roster.weakref();
      wrapper[id] <- wrapRoster(roster);
    }
    return wrapper[id];
  }
}

Tactical.getCasualtyRoster = wrapRosterFunc(Tactical.getCasualtyRoster);
World.getGuestRoster = wrapRosterFunc(World.getGuestRoster);
World.getPlayerRoster = wrapRosterFunc(World.getPlayerRoster);
World.getTemporaryRoster = wrapRosterFunc(World.getTemporaryRoster);
World.getRoster = wrapRosterFunc1(World.getRoster);

local callClassHooks = null;
callClassHooks = function(baseName, scriptName, obj)
{
  if(scriptName in g_parents)
  {
    local parentScript = g_parents[scriptName];
    ::mods_callHookCore(g_inheritAllHooks, parentScript, [callClassHooks(null, parentScript, obj)]);
  }
  if(baseName)
  {
    obj = ::mods_callHookCore(g_inheritHooks, baseName, [obj]) || obj;
    obj = ::mods_callHookCore(g_exactHooks, scriptName, [obj]);
  }
  return obj;
}
::mods_addHook("inherit", callClassHooks);

::mods_addHook("beforeCampaignLoad", function() // executed once per campaign load
{
  foreach(k,L in g_oneTimeHooks) // restore one-time hooks
    foreach(h in L)
      ::mods_addHookCore(g_newHooks, k, h);
  g_oneTimeHooks = { };
});

::mods_addHook("root_state.onInit", function(r) // executed once per game session
{
  local addFunc = r.add;
  r.add = function(name, scriptName)
  {
    local old = name in g_states ? g_states[name] : null, o = addFunc(name, scriptName);
    if(o != old)
    {
      // world_state is (re)added when a campaign is loaded
      if(scriptName == "scripts/states/world_state") ::mods_callHook("beforeCampaignLoad");
      g_states[name] <- o != null ? o.weakref() : null;
      o = ::mods_callHook("new", scriptName, o) || o;
    }

    return o;
  }
});

::mods_hookNewObjectOnce("states/world_state", function(o) {
  local loadCampaign = o.loadCampaign;
  o.loadCampaign = function(fileName)
  {
    // this ugly hack exists in world_state.nut so we have to duplicate it
    if (Time.getRealTimeF() - m.CampaignLoadTime >= 4.0)
    {
      loadCampaign(fileName);
      ::mods_callHook("onCampaignLoaded", this);
    }
  }
});

::mods_addHook("onCampaignLoaded", function(worldState) {
  foreach(e in World.getAllEntitiesAtPos(worldState.getPlayer().getPos(), 1.0e9))
  {
    if(e.ClassName == "party" || e.ClassName == "player_party")
      ::mods_callHook("new", "scripts/entity/world/" + e.ClassName, e);
  }

  foreach(loc in World.EntityManager.getSettlements())
  {
    local roster = World.getRoster(loc.getID());
    if(roster != null)
    {
      foreach(e in roster.getAll()) ::mods_callHook("new", "scripts/entity/tactical/" + e.ClassName, e);
    }
  }

  foreach(e in World.getPlayerRoster().getAll())
    ::mods_callHook("new", "scripts/entity/tactical/" + e.ClassName, e);
});

::mods_hookNewObjectOnce("ui/screens/menu/main_menu_screen", function(o) {
  o.getRegisteredCSSHooks <- function()
  {
    local files = g_cssFiles;
    g_cssFiles = [ ];
    return files;
  }

  o.getRegisteredJSHooks <- function()
  {
    local files = g_jsFiles;
    g_jsFiles = [ ];
    return files;
  }
});

::mods_registerCSS <- function(path)
{
  g_cssFiles.append("mods/" + path);
}

::mods_registerJS <- function(path)
{
  g_jsFiles.append("mods/" + path);
}

::mods_getRegisteredMod <- function(codeName)
{
  for(local i = 0; i < g_mods.len(); ++i)
  {
    if(g_mods[i].Name == codeName) return clone g_mods[i];
  }
  return null;
}

::mods_getRegisteredMods <- function()
{
  return clone g_mods;
}

local g_nameRe = regexp("^\\w+$"), g_lastRegistered;
::mods_registerMod <- function(codeName, version, friendlyName = null, extra = null)
{
  if(!g_nameRe.match(codeName))
  {
    throw "Mod '" + codeName + "' is using an illegal code name. Code names must be composed of letters, numbers, and underscores only.";
  }
  if(typeof version != "integer" && typeof version != "float")
  {
    throw "Mod " + codeName + " is not using a numeric version. Mods must use nonnegative numeric versions.";
  }
  if(version < 0) throw "Mod " + codeName + " is using a negative version. Versions must be nonnegative.";
  local m = extra ? clone extra : { };
  m.Name <- codeName;
  m.Version <- version;
  m.FriendlyName <- friendlyName ? friendlyName : codeName;
  g_mods.append(m);
  logInfo("mod_hooks: " + codeName + (m.FriendlyName != codeName ? " (" + friendlyName + ")" : "") + " version " + version + " registered.");
  g_lastRegistered = codeName;
}

local g_exprRe = regexp("^([!<>])?(\\w+)(?:\\(([<>]=?|=|!=)?(\\d+(?:\\.\\d*)?|\\.\\d+)\\))?$");
::mods_queue <- function(codeName, expr, func)
{
  if(codeName == null) codeName = g_lastRegistered;
  if(::mods_getRegisteredMod(codeName) == null) throw "Mod " + codeName  + " not registered.";
  if(expr == null || expr == "")
  {
    expr = [];
  }
  else
  {
    // NOTE: the m[i].begin < s.len() check exists to work around a bug in Squirrel that causes bogus match results sometimes
    local match = @(s,m,i) m[i].end > 0 && m[i].begin < s.len() ? s.slice(m[i].begin, m[i].end) : null;
    expr = split(expr, ",");
    for(local i = 0; i < expr.len(); ++i)
    {
      local e = strip(expr[i]), m = g_exprRe.capture(e);
      if(m == null) throw "Invalid queue expression '" + e + "'.";
      expr[i] = { op = m[1].end != 0 ? e[0] : null, modName = match(e, m, 2), verOp = match(e, m, 3), version = match(e, m, 4) };
      if(expr[i].version != null)
      {
        expr[i].version = expr[i].version.tofloat();
        if(expr[i].op != null && expr[i].op != '!') // ordering operands are not supported for mods with version numbers
        {
          throw "Invalid queue expression '" + e + "'. Ordering operators cannot be combined with version numbers.";
        }
      }
    }
  }

  local id = "", alphabet = "0123456789abcdefghijklmnopqrstuvwxyz";
  for(local i = 0; i < 16; i++)
  {
    local idx = ::rng.next(alphabet.len());
    id += alphabet.slice(idx-1, idx);
  }
  g_queue.append({id=id, modName=codeName, expr=expr, func=func});
}

::_mods_runQueue <- function()
{
  local invertOp = @(o) o == "<" ? ">=" : o == ">" ? "<=" : o == "<=" ? ">" : o == ">=" ? "<" : o == "!=" ? "=" : "!=";

  local matchVersion = function(m, e)
  {
    local mv = m.Version, op = e.verOp, v = e.version;
    if(v == null) return true;
    return op == "<=" ? mv <= v : op == ">=" ? mv >= v : op == "<" ? mv < v : op == ">" ? mv > v : op == "!=" ? mv != v : mv == v;
  };
  local modName = function(m)
  {
    if(typeof m == "string")
    {
      local n = m;
      m = ::mods_getRegisteredMod(n);
      if(m == null) return n;
    }
    return m.Name + (m.Name != m.FriendlyName ? " (" + m.FriendlyName + ")" : "");
  };

  local deps = { }, mods = { }, errors = [ ];
  foreach(q in g_queue)
  {
    foreach(e in q.expr)
    {
      if(e.op == '!')
      {
        local mod = ::mods_getRegisteredMod(e.modName);
        if(mod != null && matchVersion(mod, e))
        {
          local vmsg = e.version != null ?
            " version " + mod.Version + " (requires version " + invertOp(e.verOp) + " " + e.version + ")" : "";
          errors.append("Mod " + q.modName + " is incompatible with " + modName(mod) + vmsg + ".");
        }
      }
      else
      {
        local before = e.modName, after = q.modName;
        if(e.op == '<') { before = after; after = e.modName; }
        else if(e.op == null)
        {
          local mod = ::mods_getRegisteredMod(before);
          if(mod == null || !matchVersion(mod, e))
          {
            local vmsg = e.version != null ? " with version " + (e.verOp != null ? e.verOp : "") + " " + e.version : "";
            errors.append("Mod " + modName(q.modName) + " requires mod " + modName(mod || before) + vmsg + ", but " +
              (mod == null ? "it was not found" : "version " + mod.Version + " was found") + ".");
          }
        }

        if(!(after in deps)) deps[after] <- [ ];
        deps[after].append(before);
      }
    }

    if(!(q.modName in mods)) mods[q.modName] <- [ ];
    mods[q.modName].append(q);
  }

  if(errors.len() != 0)
  {
    local msg = errors[0];
    for(local i = 1; i < errors.len(); ++i) msg = msg + " " + errors[i];
    throw msg;
  }

  local sets = [ ], heights = { }, visit = null;
  visit = function(q, chain)
  {
    chain.push(q.modName);
    local height;
    if(q.id in heights)
    {
      height = heights[q.id];
      if(height == 0)
      {
        local modList = "";
        for(local i = 0; i < chain.len(); ++i) modList = (i == 0 ? chain[i] : modList + " -> " + chain[i]);
        throw "Dependency conflict involving mod(s) " + modList + ".";
      }
    }
    else
    {
      heights[q.id] <- 0;
      height = 0;
      if(q.modName in deps)
      {
        foreach(dep in deps[q.modName])
        {
          if(dep in mods)
          {
            foreach(depq in mods[dep]) height = Math.max(height, visit(depq, chain));
          }
        }
      }

      if(height == sets.len()) sets.append([]);
      sets[height].append([q.modName, q.func]);
      ++height;
      heights[q.id] = height;
    }
    chain.pop();
    return height;
  };

  foreach(q in g_queue) visit(q, [ ]);
  foreach(set in sets)
  {
    foreach(f in set)
    {
      logInfo("mod_hooks: Executing queued script for " + modName(f[0]) + ".");
      f[1]();
    }
  }
  g_queue = [ ];
}

::rng_new <- function(seed = 0)
{
  if(seed == 0) seed = (Time.getRealTimeF() * 1000000000).tointeger();
  return {
    x = seed, y = 234567891, z = 345678912, w = 456789123, c = 0,
    nextInt = function()
    {
      x += 1411392427;

      y = y ^ (y<<5);
      y = y ^ (y>>>7);
      y = y ^ (y<<22);

      local t = z + w + c;
      z  = w;
      c  = t >>> 31; // c = (signed)t < 0 ? 1 : 0
      w  = t & 0x7FFFFFFF;

      return (x + y + w) & 0x7FFFFFFF;
    },
    nextFloat = function()
    {
      return nextInt() / 2147483648.0;
    },
    next = function(a, b = null)
    {
      if(b == null)
      {
        if(a <= 0) throw "a must be > 0";
        return nextInt() % a + 1;
      }
      else
      {
        if(a > b) throw "a must be <= than b";
        return nextInt() % (b-a+1) + a;
      }
    }
  }
}

::rng <- ::rng_new();

::mods_registerMod("mod_hooks", 21.1, "modding script hooks");
