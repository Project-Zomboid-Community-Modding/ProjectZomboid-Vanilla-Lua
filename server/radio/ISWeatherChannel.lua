WeatherChannel = {};
WeatherChannel.channelUUID = "EMRG-711984"; --required for DynamicRadio
WeatherChannel.debugTestAll = false;

local function comp(_str)
    return _str;
end

-- FIXME: ISDebugUtils isn't loaded on the server
ISDebugUtils = ISDebugUtils or {}
function ISDebugUtils.roundNum(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

local function roundstring(_val)
    return tostring(ISDebugUtils.roundNum(_val,2));
end

local function roundstring100(_val)
    return tostring(ISDebugUtils.roundNum(_val,0));
end

local activity = {
    "anomalous",
    "suspicious",
    "hostile",
    "undead",
    "class 5",
    "class 4",
    "class 3",
    "survivor",
    "vehicle",
    "airborne",
    "friendly",
    "unknown",
    "neutral",
};

local zones = {
    { name = "south", sectors = { 2, 5, 8, 9 } },
    { name = "south-west", sectors = { 1, 3, 6, 7 } },
    { name = "north-west", sectors = { 10, 14, 15, 18 } },
    { name = "central", sectors = { 11, 12, 13, 19 } },
    { name = "north", sectors = { 17, 4, 16, 23 } },
    { name = "north-east", sectors = { 21, 25, 29, 31 } },
    { name = "west", sectors = { 22, 24, 28, 32 } },
    { name = "east", sectors = { 27, 30, 33, 36 } },
    { name = "south-east", sectors = { 20, 26, 34, 35 } },
}

function WeatherChannel.Init()
    activity = {
        "AEBS_rand_pre_0",
        "AEBS_rand_pre_1",
        "AEBS_rand_pre_2",
        "AEBS_rand_pre_4",
        "AEBS_rand_pre_5",
        "AEBS_rand_pre_6",
        "AEBS_rand_pre_7",
        "AEBS_rand_pre_8",
        "AEBS_rand_pre_9",
        "AEBS_rand_pre_10",
        "AEBS_rand_pre_11",
        "AEBS_rand_pre_12",
    };

    zones = {
        { name = "AEBS_zone_name_s", sectors = { 2, 5, 8, 9 } },
        { name = "AEBS_zone_name_sw", sectors = { 1, 3, 6, 7 } },
        { name = "AEBS_zone_name_nw", sectors = { 10, 14, 15, 18 } },
        { name = "AEBS_zone_name_c", sectors = { 11, 12, 13, 19 } },
        { name = "AEBS_zone_name_n", sectors = { 17, 4, 16, 23 } },
        { name = "AEBS_zone_name_ne", sectors = { 21, 25, 29, 31 } },
        { name = "AEBS_zone_name_w", sectors = { 22, 24, 28, 32 } },
        { name = "AEBS_zone_name_e", sectors = { 27, 30, 33, 36 } },
        { name = "AEBS_zone_name_se", sectors = { 20, 26, 34, 35 } },
    }
end

--required for DynamicRadio:
function WeatherChannel.OnLoadRadioScripts()
    WeatherChannel.Init();
    table.insert(DynamicRadio.scripts, WeatherChannel);
end

--required for DynamicRadio:
function WeatherChannel.OnEveryHour(_channel, _gametime, _radio)
    local hour = _gametime:getHour();

    if hour<120 then
        local bc = WeatherChannel.CreateBroadcast(_gametime);

        _channel:setAiringBroadcast(bc);
    end
end

Events.OnLoadRadioScripts.Add(WeatherChannel.OnLoadRadioScripts);

function WeatherChannel.CreateBroadcast(_gametime)
    local bc = RadioBroadCast.new("GEN-"..tostring(ZombRand(100000,999999)),-1,-1);

    if WeatherChannel.debugTestAll then
        WeatherChannel.TestAll(_gametime, bc)
    else
        WeatherChannel.FillBroadcast(_gametime, bc);
    end

    return bc;
end

function WeatherChannel.FillBroadcast(_gametime, _bc)
    local hour = _gametime:getHour();
    local c = { r=1.0, g=1.0, b=1.0 };

    _bc:AddRadioLine( RadioLine.new(comp(getText("AEBS_Intro")), c.r, c.g, c.b) );

    WeatherChannel.AddFuzz(c, _bc);

    WeatherChannel.AddPowerNotice(c, _bc);

    WeatherChannel.GetRandomString(c, _bc, 100);

    WeatherChannel.AddFuzz(c, _bc);

    WeatherChannel.AddForecasting(c, _bc, hour);

    WeatherChannel.AddFuzz(c, _bc);

    WeatherChannel.GetRandomString(c, _bc, 100);

    if getGameTime():getNightsSurvived() == getGameTime():getHelicopterDay1() then
        WeatherChannel.AddFuzz(c, _bc, 6);
        _bc:AddRadioLine( RadioLine.new(comp(getText("AEBS_Choppah")), c.r, c.g, c.b) );
    end

    WeatherChannel.AddFuzz(c, _bc);
end

function WeatherChannel.AddFuzz(_c, _bc, _chance)
    local rand = ZombRand(1,_chance or 12);

    if rand==1 or rand==2 then
        _bc:AddRadioLine( RadioLine.new("<bzzt>", _c.r, _c.g, _c.b) );
    elseif rand==3 or rand==4 then
        _bc:AddRadioLine( RadioLine.new("<fzzt>", _c.r, _c.g, _c.b) );
    elseif rand==5 or rand==6 then
        _bc:AddRadioLine( RadioLine.new("<wzzt>", _c.r, _c.g, _c.b) );
    end
end

function WeatherChannel.AddPowerNotice(_c, _bc, _force)
    local day = getGameTime():getWorldAgeHours() / 24 + (getSandboxOptions():getTimeSinceApo() - 1) * 30
    local powerOffDay = getSandboxOptions():getElecShutModifier()
    if _force or (day >= powerOffDay-2 and day < powerOffDay-1) then
        _bc:AddRadioLine( RadioLine.new(comp(getText("AEBS_Power_1")), _c.r, _c.g, _c.b) );
    end
    if _force or (day >= powerOffDay-1 and day < powerOffDay) then
        _bc:AddRadioLine( RadioLine.new(comp(getText("AEBS_Power_2")), _c.r, _c.g, _c.b) );
    end
    if _force or (day >= powerOffDay) then
        _bc:AddRadioLine( RadioLine.new(comp(getText("AEBS_Power_3")), _c.r, _c.g, _c.b) );
    end
end

function WeatherChannel.AddForecasting(_c, _bc, _hour)
    local clim = getClimateManager();
    local forecaster = clim:getClimateForecaster();

    local forecast = forecaster:getForecast();
    WeatherChannel.AddForecast(_c, _bc, forecast, getText("AEBS_Pre_today"), _hour<12);

    local forecast = forecaster:getForecast(1);
    WeatherChannel.AddForecast(_c, _bc, forecast, getText("AEBS_Pre_tomorrow"), true);

    WeatherChannel.AddExtremesForecasting(_c, _bc, 2);
end

function WeatherChannel.AddForecast(_c, _bc, _forecast, _prefix, _doFog)
    local s = _prefix;
    s = s .. WeatherChannel.GetForecastString(1, _forecast);
    _bc:AddRadioLine( RadioLine.new(comp(s), _c.r, _c.g, _c.b) );

    s = WeatherChannel.GetForecastString(2, _forecast);
    _bc:AddRadioLine( RadioLine.new(comp(s), _c.r, _c.g, _c.b) );

    if _doFog and _forecast:isHasFog() then
        s = WeatherChannel.GetForecastString(3, _forecast);
        _bc:AddRadioLine( RadioLine.new(comp(s), _c.r, _c.g, _c.b) );
    end

    if _forecast:isWeatherStarts() then
        -- a new weather period starts
        s = WeatherChannel.GetForecastString(4, _forecast);
        _bc:AddRadioLine( RadioLine.new(comp(s), _c.r, _c.g, _c.b) );
    elseif _forecast:getWeatherOverlap() then
        -- a already started weather period overlaps this day
        s = WeatherChannel.GetForecastString(5, _forecast);
        _bc:AddRadioLine( RadioLine.new(comp(s), _c.r, _c.g, _c.b) );
    end
end

function WeatherChannel.GetForecastString(_type, _forecast)
    local s = "";
    if _type==1 then
        local v = _forecast:getTemperature();
        local a,b,c = v:getTotalMean(), v:getTotalMin(), v:getTotalMax();
        local d = roundstring100(_forecast:getHumidity():getTotalMean()*100);
        s = " "..getText("AEBS_temperature", Temperature.getTemperatureString(a), Temperature.getTemperatureString(b), Temperature.getTemperatureString(c), d);
    elseif _type==2 then
        local v = _forecast:getWindPower();
        local a,b,c = v:getTotalMean(), v:getTotalMin(), v:getTotalMax();
        if getCore():getOptionDisplayAsCelsius() then
            c = roundstring(ClimateManager.ToKph(c))..getText("AEBS_KpH");
        else
            c = roundstring(ClimateManager.ToMph(c))..getText("AEBS_MpH");
        end
        local d = _forecast:getMeanWindAngleString();
        local dnew = getText("AEBS_zone_name_"..d:lower());
        if dnew then
            d = dnew;
        end
        local e = getText("AEBS_clouds_0");
        local cloudsA = _forecast:getCloudiness():getTotalMean();
        local cloudsB = _forecast:getCloudiness():getTotalMax();

        if cloudsA>0.7 then
            e = getText("AEBS_clouds_2");
        elseif cloudsA>0.4 then
            e = getText("AEBS_clouds_1");
            if cloudsB>0.7 then
                e = e .. " "..getText("AEBS_clouds_4");
            end
        else
            if cloudsB>0.7 then
                e = e .. " "..getText("AEBS_clouds_4");
            elseif cloudsB>0.4 then
                e = e .. " "..getText("AEBS_clouds_3");
            end
        end

        local w = getText("AEBS_wind_1");
        if a>0.75 then
            w = getText("AEBS_wind_4");
        elseif a>0.5 then
            w = getText("AEBS_wind_3");
        elseif a>0.25 then
            w = getText("AEBS_wind_2");
        end

        s = getText("AEBS_wind_0", w, d, c, e);
    elseif _type==3 then
        local v = _forecast:getFogStrength();
        if v==1 then
            s = getText("AEBS_fog_2");
        elseif v>0.75 then
            s = getText("AEBS_fog_1");
        else
            s = getText("AEBS_fog_0");
        end
    elseif _type==4 or _type==5 then
        if _type==4 then
            s = getText("AEBS_weather_0_a", WeatherChannel.GetDaySegmentForHour(_forecast:getWeatherStartTime()));
        else
            local endTime = _forecast:getWeatherEndTime();
            if endTime>=22 then
                s = getText("AEBS_weather_0_b");
            else
                s = getText("AEBS_weather_0_c", WeatherChannel.GetDaySegmentForHour(endTime));
            end

        end

        local t = {};
        if _forecast:isHasHeavyRain() then
            table.insert(t,getText("AEBS_weather_heavy_rain"));
        end
        if _forecast:isHasStorm() then
            table.insert(t,getText("AEBS_weather_storm"));
        end
        if _forecast:isHasTropicalStorm() then
            table.insert(t,getText("AEBS_weather_tropical"));
        end
        if _forecast:isHasBlizzard() then
            table.insert(t,getText("AEBS_weather_blizzard"));
        end

        if #t>0 then
            if #t==1 then
                s = s .. getText("AEBS_weather_predicted")..t[1];
            else
                s = s .. getText("AEBS_weather_predicted");
                for k,v in ipairs(t) do
                    if k<#t then
                        s = s .. v .. (v~=#t-1 and ", " or "");
                    else
                        s = s .. getText("AEBS_weather_and_a") .. v .. "...";
                    end
                end
            end
        else
            s = s .. getText("AEBS_weather_light_moderate");
        end

        if _forecast:isChanceOnSnow() then
            s = s..getText("AEBS_weather_snowfall");
        end
    end
    return s;
end

function WeatherChannel.GetDaySegmentForHour(_hour)
    if _hour<=4 or _hour>=23 then
        return getText("AEBS_segment_night");
    elseif _hour>=4 and _hour<8 then
        return getText("AEBS_segment_early_morning");
    elseif _hour>=8 and _hour<12 then
        return getText("AEBS_segment_morning");
    elseif _hour>=12 and _hour<18 then
        return getText("AEBS_segment_afternoon");
    elseif _hour>=18 and _hour<23 then
        return getText("AEBS_segment_evening");
    end
end


function WeatherChannel.AddExtremesForecasting(_c, _bc, offset, _len)
    local clim = getClimateManager();
    local forecaster = clim:getClimateForecaster();

    for i=offset,offset+(_len or 3) do
        local forecast = forecaster:getForecast(i);

        if forecast and ( forecast:isHasBlizzard() or forecast:isHasTropicalStorm() or forecast:isHasStorm() ) then
            local type = getText("AEBS_weather_storm_C");
            if forecast:isHasTropicalStorm() then
                type = getText("AEBS_weather_tropical_C");
            elseif forecast:isHasBlizzard() then
                type = getText("AEBS_weather_blizzard_C");
            else
            end

            local s = getText("AEBS_weather_warning", type, tostring(i));
            _bc:AddRadioLine( RadioLine.new(comp(s), _c.r, _c.g, _c.b) );
            return;
        end
    end
end

function WeatherChannel.GetRandomString(_c, _bc, _doItThreshold, _forceRand)
    local rand = ZombRand(1,100);

    if _doItThreshold and rand>_doItThreshold then
        return;
    end

    local rand = _forceRand or ZombRand(1,10000);

    local s = nil;
    if rand<500 then
        local zone = zones[ZombRand(1,#zones)];
        s = getText("AEBS_random_0", getText(zone.name), zone.sectors[1], zone.sectors[2], zone.sectors[3], zone.sectors[4]);
    elseif rand<1000 then
        s = getText("AEBS_random_1", ZombRand(1,36));
    elseif rand<1500 then
        s = getText("AEBS_random_2", ZombRand(1,1000));
    elseif rand<2000 then
        s = getText("AEBS_random_3", activity[ZombRand(1,#activity)], ZombRand(1,36));
    elseif rand>=9000 and rand<9002 then
        s = getText("AEBS_random_5");
    elseif rand>=9002 and rand<9004 then
        s = getText("AEBS_random_6");
    elseif rand>=9004 and rand<9006 then
        s = getText("AEBS_random_7");
    elseif rand>=9006 and rand<9008 then
        s = getText("AEBS_random_8");
    elseif rand>=9008 and rand<9010 then
        s = getText("AEBS_random_9");
    elseif rand>=9010 and rand<9012 then
        s = getText("AEBS_random_10");
    elseif rand>=9012 and rand<9014 then
        s = getText("AEBS_random_11");
    elseif rand>=9014 and rand<9016 then
        s = getText("AEBS_random_12");
    elseif rand>=9016 and rand<9018 then
        s = getText("AEBS_random_13");
    end

    if s~=nil then
        --local radio = getZomboidRadio();
        --s = radio:scrambleString(s, 20, false, nil);
        local c = {r=0.5,g=0.5,b=0.5};
        _bc:AddRadioLine( RadioLine.new(s, c.r, c.g, c.b) );
    end
end


function WeatherChannel.TestAll(_gametime, _bc)
    local clim = getClimateManager();
    local forecaster = clim:getClimateForecaster();

    local c = { r=1.0, g=1.0, b=1.0 };
    _bc:AddRadioLine( RadioLine.new(getText("AEBS_Intro"), c.r, c.g, c.b) );
    WeatherChannel.AddPowerNotice(c, _bc, true);

    local forecast = forecaster:getForecast();
    WeatherChannel.AddForecast(c, _bc, forecast, getText("AEBS_Pre_today"), true);

    local forecast = forecaster:getForecast(1);
    WeatherChannel.AddForecast(c, _bc, forecast, getText("AEBS_Pre_tomorrow"), true);

    local forecast = forecaster:getForecast(2);
    WeatherChannel.AddForecast(c, _bc, forecast, getText("AEBS_Pre_dayafter"), true);

    WeatherChannel.AddExtremesForecasting(c, _bc, 3, 20);

    WeatherChannel.GetRandomString(c, _bc, 100, 0);
    WeatherChannel.GetRandomString(c, _bc, 100, 500);
    WeatherChannel.GetRandomString(c, _bc, 100, 1000);
    WeatherChannel.GetRandomString(c, _bc, 100, 1500);
    WeatherChannel.GetRandomString(c, _bc, 100, 9000);
    WeatherChannel.GetRandomString(c, _bc, 100, 9001);
    WeatherChannel.GetRandomString(c, _bc, 100, 9002);
    WeatherChannel.GetRandomString(c, _bc, 100, 9003);
    WeatherChannel.GetRandomString(c, _bc, 100, 9004);
    WeatherChannel.GetRandomString(c, _bc, 100, 9005);
    WeatherChannel.GetRandomString(c, _bc, 100, 9006);
    WeatherChannel.GetRandomString(c, _bc, 100, 9007);
    WeatherChannel.GetRandomString(c, _bc, 100, 9008);
    WeatherChannel.GetRandomString(c, _bc, 100, 9009);
    WeatherChannel.GetRandomString(c, _bc, 100, 9010);

    _bc:AddRadioLine( RadioLine.new(getText("AEBS_Choppah"), c.r, c.g, c.b) );
    WeatherChannel.AddFuzz(c, _bc, 6);
end

