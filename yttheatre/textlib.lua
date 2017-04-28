dxText = {}
dxText_mt = { __index = dxText }
local idAssign,idPrefix = 0,"c"
local g_screenX,g_screenY = guiGetScreenSize()
local visibleText = {}
------
defaults = {
        fX                                                      = 0.5,
        fY                                                      = 0.5,
        bRelativePosition                       = true,
        strText                                         = "",
        bVerticalAlign                          = "center",
        bHorizontalAlign                        = "center",
        tColor                                          = {255,255,255,255},
        fScale                                          = 1,
        strFont                                         = "default",
        strType                                         = "normal",
        tAttributes                                     = {},
        bPostGUI                                        = false,
        bClip                                           = false,
        bWordWrap                                       = true,
        bVisible                                        = true,
        tBoundingBox                            = false, --If a bounding box is not set, it will not be used.
        bRelativeBoundingBox            = true,
}

local validFonts = {
        default                                         = true,
        ["default-bold"]                        = true,
        clear                                           = true,
        arial                                           = true,
        pricedown                                       = true,
        bankgothic                                      = true,
        diploma                                         = true,
        beckett                                         = true,
}

local validTypes = {
        normal                                          = true,
        shadow                                          = true,
        border                                          = true,
        stroke                                          = true, --Clone of border
}

local validAlignTypes = {
        center                                          = true,
        left                                            = true,
        right                                           = true,
}

function dxText:create( text, x, y, relative, strFont, fScale, horzA )
        assert(not self.fX, "attempt to call method 'create' (a nil value)")
        if ( type(text) ~= "string" ) or ( not tonumber(x) ) or ( not tonumber(y) ) then
                outputDebugString ( "dxText:create - Bad argument", 0, 112, 112, 112 )
                return false
        end
    local new = {}
        setmetatable( new, dxText_mt )
        --Add default settings
        for i,v in pairs(defaults) do
                new[i] = v
        end
        idAssign = idAssign + 1
        new.id = idPrefix..idAssign
        new.strText = text or new.strText
        new.fX = x or new.fX
        new.fY = y or new.fY
        if type(relative) == "boolean" then
                new.bRelativePosition = relative
        end
        new:scale( fScale or new.fScale )
        new:font( strFont or new.strFont )
        new:align( horzA or new.bHorizontalAlign )
        visibleText[new] = true
        return new
end

function dxText:text(text)
        if type(text) ~= "string" then return self.strText end
        self.strText = text
        return true
end

function dxText:position(x,y,relative)
        if not tonumber(x) then return self.fX, self.fY end
        self.fX = x
        self.fY = y
        if type(relative) == "boolean" then
                self.bRelativePosition = relative
        else
                self.bRelativePosition = true
        end
        return true
end

function dxText:color(r,g,b,a)
        if not tonumber(r) then return unpack(self.tColor) end
        g = g or self.tColor[2]
        b = b or self.tColor[3]
        a = a or self.tColor[4]
        self.tColor = { r,g,b,a }
        return true
end

function dxText:scale(scale)
        if not tonumber(scale) then return self.fScale end
        self.fScale = scale
        return true
end

function dxText:visible(bool)
        if type(bool) ~= "boolean" then return self.bVisible end
        if self.bVisible == bool then return end
        self.bVisible = bool
        if bool then
                visibleText[self] = true
        else
                visibleText[self] = nil
        end
        return true
end

function dxText:destroy()
        self.bDestroyed = true
        setmetatable( self, self )
        return true
end

function dxText:font(font)
        if not validFonts[font] then return self.strFont end
        self.strFont = font
        return true
end

function dxText:postGUI(bool)
        if type(bool) ~= "boolean" then return self.bPostGUI end
        self.bPostGUI = bool
        return true
end

function dxText:clip(bool)
        if type(bool) ~= "boolean" then return self.bClip end
        self.bClip = bool
        return true
end

function dxText:wordWrap(bool)
        if type(bool) ~= "boolean" then return self.bWordWrap end
        self.bWordWrap = bool
        return true
end

function dxText:type(type,...)
        if not validTypes[type] then return self.strType, unpack(self.tAttributes) end
        self.strType = type
        self.tAttributes = {...}
        return true
end

function dxText:align(horzA, vertA)
        if not validAlignTypes[horzA] then return self.bHorizontalAlign, self.bVerticalAlign end
        vertA = vertA or self.bVerticalAlign
        self.bHorizontalAlign, self.bVerticalAlign = horzA, vertA
        return true
end

function dxText:boundingBox(left,top,right,bottom,relative)
        if left == nil then
                if self.tBoundingBox then
                        return unpack(boundingBox)
                else
                        return false
                end
        elseif tonumber(left) and tonumber(right) and tonumber(top) and tonumber(bottom) then
                self.tBoundingBox = {left,top,right,bottom}
                if type(relative) == "boolean" then
                        self.bRelativeBoundingBox = relative
                else
                        self.bRelativeBoundingBox = true
                end
        else
                self.tBoundingBox = false
        end
        return true
end

addEventHandler ( "onClientRender", getRootElement(),
        function()
                for self,_ in pairs(visibleText) do
                        while true do
                                if self.bDestroyed then
                                        visibleText[self] = nil
                                        break
                                end
                                if self.tColor[4] < 1 then
                                        break
                                end
                                local l,t,r,b
                                --If we arent using a bounding box
                                if not self.tBoundingBox then
                                        --Decide if we use relative or absolute
                                        local p_screenX,p_screenY = 1,1
                                        if self.bRelativePosition then
                                                p_screenX,p_screenY = g_screenX,g_screenY
                                        end
                                        local fX,fY = (self.fX)*p_screenX,(self.fY)*p_screenY
                                        if self.bHorizontalAlign == "left" then
                                                l = fX
                                                r = fX + g_screenX
                                        elseif self.bHorizontalAlign == "right" then
                                                l = fX - g_screenX
                                                r = fX
                                        else
                                                l = fX - g_screenX
                                                r = fX + g_screenX
                                        end
                                        if self.bVerticalAlign == "top" then
                                                t = fY
                                                b = fY + g_screenY
                                        elseif self.bVerticalAlign == "bottom" then
                                                t = fY - g_screenY
                                                b = fY
                                        else
                                                t = fY - g_screenY
                                                b = fY + g_screenY
                                        end
                                elseif type(self.tBoundingBox) == "table" then
                                        local b_screenX,b_screenY = 1,1
                                        if self.bRelativeBoundingBox then
                                                b_screenX,b_screenY = g_screenX,g_screenY
                                        end
                                        l,t,r,b = self.tBoundingBox[1],self.tBoundingBox[2],self.tBoundingBox[3],self.tBoundingBox[4]
                                        l = l*b_screenX
                                        t = t*b_screenY
                                        r = r*b_screenX
                                        b = b*b_screenY
                                end
                                local type,att1,att2,att3,att4,att5 = self:type()
                                if type == "border" or type == "stroke" then
                                        att2 = att2 or 0
                                        att3 = att3 or 0
                                        att4 = att4 or 0
                                        att5 = att5 or self.tColor[4]
                                        outlinesize = att1 or 2
                                        outlinesize = math.min(self.fScale,outlinesize) --Make sure the outline size isnt thicker than the size of the label
                                        if outlinesize > 0 then
                                                for offsetX=-outlinesize,outlinesize,outlinesize do
                                                        for offsetY=-outlinesize,outlinesize,outlinesize do
                                                                if not (offsetX == 0 and offsetY == 0) then
                                                                        dxDrawText(self.strText, l + offsetX, t + offsetY, r + offsetX, b + offsetY, tocolor(att2, att3, att4, att5), self.fScale, self.strFont, self.bHorizontalAlign, self.bVerticalAlign, self.bClip, self.bWordWrap, self.bPostGUI )
                                                                end
                                                        end
                                                end
                                        end
                                elseif type == "shadow" then
                                        local shadowDist = att1
                                        att2 = att2 or 0
                                        att3 = att3 or 0
                                        att4 = att4 or 0
                                        att5 = att5 or self.tColor[4]
                                        dxDrawText(self.strText, l + shadowDist, t + shadowDist, r + shadowDist, b + shadowDist, tocolor(att2, att3, att4, att5), self.fScale, self.strFont, self.bHorizontalAlign, self.bVerticalAlign, self.bClip, self.bWordWrap, self.bPostGUI )
                                end
                                dxDrawText ( self.strText, l, t, r, b, tocolor(unpack(self.tColor)), self.fScale, self.strFont, self.bHorizontalAlign, self.bVerticalAlign, self.bClip, self.bWordWrap, self.bPostGUI )
                                break
                        end
                end
        end
)

if addEvent ( "updateDisplaysDM", true ) then
        addEventHandler ( "updateDisplaysDM", getRootElement(),
                function(self)
                        setmetatable( self, dxText_mt )
                        --Use "smart positioning"
                        updateSmartPositions(self)
                        --Remove any old ones with the same id
                        for text,_ in pairs(visibleText) do
                                if text.id == self.id then
                                        visibleText[text] = nil
                                end
                        end
                        if self.bVisible and not self.bDestroyed then
                                visibleText[self] = true
                        end
                end
        )
end

function updateSmartPositions(self)
        self.fX = getSmartPosition(self.fX,g_screenX)
        self.fY = getSmartPosition(self.fY,g_screenY)
        if self.tBoundingBox then
                self.tBoundingBox[1] = getSmartPosition(self.tBoundingBox[1],g_screenX)
                self.tBoundingBox[2] = getSmartPosition(self.tBoundingBox[2],g_screenY)
                self.tBoundingBox[3] = getSmartPosition(self.tBoundingBox[3],g_screenX)
                self.tBoundingBox[4] = getSmartPosition(self.tBoundingBox[4],g_screenY)
        end
        self.bRelative, self.bRelativeBoundingBox = false, false
end

function getSmartPosition(pos,full)
        local final = pos
        if pos > 1 then --Is X bigger than 1?  If so we've got an absolute position
                final = pos
        elseif pos < -1 then --We have a reversed absolute position
                final = full - pos
        elseif pos > 0 then --We have a relative position
                final = full * pos
        else --We have a reversed relative position
                final = full - (full * pos)
        end
        return final
end
















    --[[
     
      Client animation library by arc_
                   Version 1.0.0
     
      Licence
      ----------------
     
      You are free to modify this file and redistribute it with your changes.
      However, always mention that you changed it (and eventually what changes
      you made) and keep the original author, version number and licence intact.
     
      Selling this script or a derivative of it is not allowed.
     
     
      Documentation
      ----------------
     
      Terminology
     
        - Animation: a sequence of phases that act on one or more elements
          and follow each other sequentially in time.
         
          Multiple animations can be running at the same time. All defined
          animations run in parallel.
         
          An animation is in fact one phase with several subphases (see below),
          with animation specific functions available.
         
        - Phase: a part of an animation sequence. A phase consists of a
          paramater that linearly goes from a given starting value to a
          given ending value, over the specified amount of time, and is
          applied to one certain element. While a phase is running, its
          callback function will be called onClientRender with the following
          arguments:
         
            phase.fn(element elem, float param, table phase)
         
          Specifying time and callback function is optional. If no time is
          specified but a function is, phase.fn(elem) will be called once.
          If no function is specified but a time is, the phase consists
          of simply waiting during that time, doing nothing.
         
          A phase can be run once, repeated multiple times or loop infinitely.
         
          Phases can also contain phases. In that case the parent phase consists
          of completing all child phases, in order. This allows you to f.e.
          make an element move left and right continuously: define a phase for
          moving it to the left, followed by a phase for moving it back to the
          right, and encapsulate these two phases in a parent phase that loops
          forever.
         
          Phases can be nested to arbitrary depth. The element a subphase works on
          is inherited from its parent phase (or, if the parent phase doesn't
          specify an element, from the grandparent, etc).
     
         
      Definition of a phase
     
        A phase is simply a table containing properties and (optionally) subphases.
        Available phase properties are: (the values for the properties are examples,
        not default values)
       
        phase = {
            from = 0,           -- the starting value of the parameter
            to = 1,             -- the ending value of the parameter
            [time = 1000,]      -- the time (in ms) in which to go from start to end
            [fn = callback,]    -- the function to call on each frame update
            [repeats = 5,]      -- how many times to run this phase before going on to
                                --   the next. defaults to 1
     
            [subphase1,]        -- optional subphases. if one or more of these are included,
            [subphase2,]        --   only the "repeats" property is valid for this parent phase
            ...
        }
     
      Available functions
     
        anim = Animation.create(elem, phase1, phase2, ...)
          Creates and returns a new animation. This means nothing more than
          creating a new phase, putting the specified phases in it as subphases,
          and making the functions of the Animation class available to it.
         
          Once an animation is created, it is not yet running.
         
        anim = Animation.createAndPlay(elem, phase1, phase2, ...)
          Creates a new animation and immediately starts playing it.
       
        anim = Animation.createNamed(name, elem, ...)
          If an animation with the specified name exists, returns that animation.
          Otherwise creates a new named animation. You can look the animation up
          again later with Animation.getNamed(name).
       
        anim = Animation.createNamedAndPlay(name, elem, ...)
          Self explanatory.
         
        anim = Animation.getNamed(name)
          Returns the animation with the specified name if it exists,
          false otherwise.
         
        anim:play()
          Start playing a newly created animation or resume a paused animation.
         
        anim:pause()
          Pauses the animation. Resume it later with anim:play() or delete it
          with anim:remove().
         
        anim:remove()
          Deletes the animation completely. It can not be resumed anymore.
       
        anim:isPlaying()
          Returns true if the animation is currently playing, false if not.
         
        Animation.playingAnimationsExist()
          Returns true if there is any animation that is currently playing.
         
         
        anim:addPhase(phase3), phase2:addPhase(phase3)
          Appends a new subphase to the animation or phase. Can be done while
          the animation is playing. Note that to be able to use phase2:addPhase(),
          phase2 first has to be processed (default values filled in, made part of
          the Phase class) by being passed as an argument to
          Animation.create[AndPlay] or addPhase.
         
         
      Examples
     
        Fade in a picture:
       
          local pict = guiCreateStaticImage(...)
          Animation.createAndPlay(pict, { from = 0, to = 1, time = 2000, fn = guiSetAlpha })
         
        Fade in a picture using a preset (for more presets, see the end of this file):
       
          local pict = guiCreateStaticImage(...)
          Animation.createAndPlay(pict, Animation.presets.guiFadeIn(2000))
         
        Move a label to the right while fading it in:
       
          local label = guiCreateLabel(10, 100, 150, 20, 'Test', false)
          Animation.createAndPlay(label, Animation.presets.guiMove(200, 100, 2000))
          Animation.createAndPlay(label, Animation.presets.guiFadeIn(2000))
         
        Move a label left and right forever, without presets:
       
          function guiSetX(elem, x)
              local curX, curY = guiGetPosition(elem, false)
              guiSetPosition(elem, x, curY, false)
          end
          local label = guiCreateLabel(10, 100, 150, 20, 'Test', false)
          Animation.createAndPlay(
              label,
              {
                  repeats = 0,
                  { from = 10, to = 200, time = 2000, fn = guiSetX },
                  { from = 200, to = 10, time = 2000, fn = guiSetX }
              }
          )
         
                                                     ]]--
     
    Phase = {}
    Phase.__index = Phase
     
    Animation = setmetatable({}, { __index = Phase })
    Animation.__index = Animation
     
    Animation.collection = {}
     
    function Animation.create(elem, ...)
        local anim = setmetatable({ elem = elem, ... }, Animation)
        anim:_setup()
        return anim
    end
     
    function Animation.createAndPlay(elem, ...)
        local anim = Animation.create(elem, ...)
        anim:play()
        return anim
    end
     
    function Animation.createNamed(name, elem, ...)
        local anim = Animation.getNamed(name) or Animation.create(elem, ...)
        anim.name = name
        return anim
    end
     
    function Animation.createNamedAndPlay(name, elem, ...)
        local anim = Animation.createNamed(name, elem, ...)
        anim:play()
        return anim
    end
     
    function Animation.getNamed(name)
        local i, anim = table.find(Animation.collection, 'name', name)
        return i and anim
    end
     
    function Animation:isPlaying()
        return self.playing or false
    end
     
    function Animation.playingAnimationsExist()
        return table.find(Animation.collection, 'playing', true) and true
    end
     
    function Animation:play()
        if self.playing then
            return
        end
        if not table.find(Animation.collection, self) then
            table.insert(Animation.collection, self)
        end
        if not Animation.playingAnimationsExist() then
            addEventHandler('onClientRender', getRootElement(), updateAnim)
        end
        self.playing = true
    end
     
    function Animation:pause()
        self.playing = false
        if not Animation.playingAnimationsExist() then
            removeEventHandler('onClientRender', getRootElement(), updateAnim)
        end
    end
     
    function Animation:remove()
        table.removevalue(Animation.collection, self)
        if not Animation.playingAnimationsExist() then
            removeEventHandler('onClientRender', getRootElement(), updateAnim)
        end
        self.playing = false
    end
     
    function Phase:_setup(parent)
        self.parent = parent
        if self[1] then
            for i,phase in ipairs(self) do
                if type(phase) == 'function' then
                    phase = { fn = phase }
                    self[i] = phase
                end
                setmetatable(phase, Phase)
                phase:_setup(self)
            end
            self.curphase = 1
        elseif self.time then
            self.from = self.from or 0
            self.to = self.to or 1
            self.speed = (self.to - self.from) / self.time
        end
        self.repeats = self.repeats or 1
        self.currepeat = 1
    end
     
    function Phase:addPhase(phase)
        setmetatable(phase, Phase)
        self[#self+1] = phase
        if #self == 1 then
            self.curphase = 1
        end
        phase:_setup(self)
    end
     
    function Phase:addPhases(...)
        for i,phase in ipairs({ ... }) do
            self:addPhase(phase)
        end
    end
     
    function updateAnim()
        local elem
        local phase
        local curTick = getTickCount()
        local phaseEnded
       
        for i,anim in ipairs(Animation.collection) do
            if anim.playing then
                phase = anim
                while phase.curphase do
                    if phase.elem then
                        elem = phase.elem
                    end
                    phase = phase[phase.curphase]
                end
                phaseEnded = false
                if type(elem) == 'userdata' and not isElement(elem) then
                    anim:remove()
                    phaseEnded = true
                elseif not phase.time then
                    phase.fn(elem, phase)
                    phaseEnded = true
                else
                    if not phase.starttick then
                        phase.starttick = curTick
                    end
                    phase.prevpassed = phase.passed
                    phase.passed = (curTick - phase.starttick) % phase.time
                    if phase.prevpassed and phase.passed < phase.prevpassed then
                        phase.currepeat = phase.currepeat + 1
                        phaseEnded = phase.repeats > 0 and phase.currepeat > phase.repeats
                    end
                end
                if phaseEnded then
                    repeat
                        phase.currepeat = 1
                        phase.starttick = nil
                        phase.passed = nil
                        phase = phase.parent
                        phase.curphase = phase.curphase + 1
                        if phase.curphase > #phase then
                            phase.curphase = 1
                            phase.currepeat = phase.currepeat + 1
                            if phase.repeats == 0 or phase.currepeat <= phase.repeats then
                                break
                            end
                        else
                            break
                        end
                    until phase == anim
                    if phase == anim and phase.currepeat > phase.repeats then
                        anim:remove()
                        anim = false
                    else
                        phase = phase[phase.curphase]
                        if not phase.time then
                            anim = false
                        elseif not phase.passed then
                            phase.passed = 0
                        end
                    end
                end
                if anim and phase.fn then
                    phase.value = phase.from + phase.speed*phase.passed
                    if elem then
                        phase.fn(elem, phase.transform and phase.transform(phase.value) or phase.value, phase)
                    else
                        phase.fn(phase.transform and phase.transform(phase.value) or phase.value, phase)
                    end
                end
            end
        end
    end
     
    function table.find(t, ...)
        local args = { ... }
        if #args == 0 then
            for k,v in pairs(t) do
                if v then
                    return k, v
                end
            end
            return false
        end
       
        local value = table.remove(args)
        if value == '[nil]' then
            value = nil
        end
        for k,v in pairs(t) do
            for i,index in ipairs(args) do
                if type(index) == 'function' then
                    v = index(v)
                else
                    if index == '[last]' then
                        index = #v
                    end
                    v = v[index]
                end
            end
            if v == value then
                return k, t[k]
            end
        end
        return false
    end
     
    function table.removevalue(t, val)
        for i,v in ipairs(t) do
            if v == val then
                table.remove(t, i)
                return i
            end
        end
        return false
    end
     
     
     
    --[[
     
      The preset functions return phases for commonly used animation effects.
     
                                                                               ]]--
    Animation.presets = {}
     
    function Animation.presets.guiPulse(time, value, phase)
        -- guiPulse(time)
        -- Pulses an image (scale down/up). time = ms for a complete pulsation cycle
        if type(time) ~= 'userdata' then
            return { from = 0, to = 2*math.pi, transform = math.sin, time = time, repeats = 0, fn = Animation.presets.guiPulse }
        else
            local elem = time
            if not phase.width then
                phase.width, phase.height = guiGetSize(elem, false)
                phase.centerX, phase.centerY = guiGetPosition(elem, false)
                phase.centerX = phase.centerX + math.floor(phase.width/2)
                phase.centerY = phase.centerY + math.floor(phase.height/2)
            end
            local pct = 1 - (value+1)*0.1
            local width = pct*phase.width
            local height = pct*phase.height
            local x = phase.centerX - math.floor(width/2)
            local y = phase.centerY - math.floor(height/2)
            guiSetPosition(elem, x, y, false)
            guiSetSize(elem, width, height, false)
        end
    end
     
    function Animation.presets.guiFadeIn(time)
        return { from = 0, to = 1, time = time or 1000, fn = guiSetAlpha }
    end
     
    function Animation.presets.guiFadeOut(time)
        return { from = 1, to = 0, time = time or 1000, fn = guiSetAlpha }
    end
     
    function Animation.presets.guiMove(endX, endY, time, loop, startX, startY, speedUpSlowDown)
        -- guiMove(endX, endY, [ time = 1000, loop = false, startX = current X, startY = current Y, speedUpSlowDown = false ])
        if type(endX) ~= 'userdata' then
            return { from = speedUpSlowDown and -math.pi/2 or 0, to = speedUpSlowDown and math.pi/2 or 1,
                     time = time or 1000, repeats = loop and 0 or 1, fn = Animation.presets.guiMove,
                     startX = startX, startY = startY, endX = endX, endY = endY, speedUpSlowDown = speedUpSlowDown }
        else
            local elem, value, phase = endX, endY, time
            if phase.speedUpSlowDown then
                value = (value + 1)/2
            end
            if not phase.startX then
                phase.startX, phase.startY = guiGetPosition(elem, false)
            end
            guiSetPosition(elem, phase.startX + (phase.endX - phase.startX)*value, phase.startY + (phase.endY - phase.startY)*value, false)
        end
    end
     
    function Animation.presets.guiMoveResize(endX, endY, endWidth, endHeight, time, loop, startX, startY, startWidth, startHeight, speedUpSlowDown)
        -- guiMoveResize(endX, endY, endWidth, endHeight, [ time = 1000, loop = false, startX = current X, startY = current Y,
        --   startWidth = current width, startHeight = current height, speedUpSlowDown = false ])
        if type(endX) ~= 'userdata' then
            return { from = speedUpSlowDown and -math.pi/2 or 0, to = speedUpSlowDown and math.pi/2 or 1,
                     time = time or 1000, repeats = loop and 0 or 1, transform = math.sin, fn = Animation.presets.guiMoveResize,
                     startX = startX, startY = startY, startWidth = startWidth, startHeight = startHeight,
                     endX = endX, endY = endY, endWidth = endWidth, endHeight = endHeight, speedUpSlowDown = speedUpSlowDown }
        else
            local elem, value, phase = endX, endY, endWidth
            if phase.speedUpSlowDown then
                value = (value + 1)/2
            end
            if not phase.startX then
                phase.startX, phase.startY = guiGetPosition(elem, false)
                phase.startWidth, phase.startHeight = guiGetSize(elem, false)
            end
            guiSetPosition(elem, math.floor(phase.startX + value*(phase.endX - phase.startX)), math.floor(phase.startY + value*(phase.endY - phase.startY)), false)
            guiSetSize(elem, math.floor(phase.startWidth + value*(phase.endWidth - phase.startWidth)), math.floor(phase.startHeight + value*(phase.endHeight - phase.startHeight)), false)
        end
    end
     