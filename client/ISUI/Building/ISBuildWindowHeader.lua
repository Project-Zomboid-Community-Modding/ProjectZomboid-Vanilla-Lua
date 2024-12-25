--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************
require "ISUI/ISPanel"

ISBuildWindowHeader = ISPanel:derive("ISBuildWindowHeader");

function ISBuildWindowHeader:initialise()
	ISPanel.initialise(self);
end

function ISBuildWindowHeader:createChildren()
    ISPanel.createChildren(self);

    if self.enableIcon then
        --local iconTex = self.entityStyle and self.entityStyle:getIcon();
        local style = self.styleIcon or "S_Image_BuildWindowHeaderIcon";
        self.icon = ISXuiSkin.build(self.xuiSkin, style, ISImage, 0, 0, 32, 32, iconTex);
        --self.icon.scaledWidth = self.iconSize;
        --self.icon.scaledHeight = self.iconSize;
        --self.icon.texture = self.entityStyle:getIcon();
        self.icon:initialise();
        self.icon:instantiate();
        self:addChild(self.icon);

        self.iconSize = self.icon:getHeight();
    else
        self.iconSize = 32;
    end

    local titleStr = "Building";
    if self.titleStr then
        titleStr = self.titleStr;
    end

    local fontHeight = -1; -- <=0 sets label initial height to font
    local style = self.styleLabel or "S_Label_EntityHeaderTitle";
    self.title = ISXuiSkin.build(self.xuiSkin, style, ISLabel, 0, 0, fontHeight, titleStr, 1, 1, 1, 1, UIFont.Medium, true);
    self.title.origTitleStr = titleStr;
    self.title:initialise();
    self.title:instantiate();
    self:addChild(self.title);

    if self.enableInfoButton then --todo: and self.entityStyle and self.entityStyle:getDescription() then
        local style = self.styleButton or "S_Button_EntityHeaderInfo"
        self.buttonInfo = ISXuiSkin.build(self.xuiSkin, style, ISButton, 0, 0, 24, 24, "");
        --self.buttonInfo.image = self.iconInfo;
        self.buttonInfo.target = self;
        self.buttonInfo.onclick = ISBuildWindowHeader.onButtonClick;
        self.buttonInfo.enable = true;
        self.buttonInfo:initialise();
        self.buttonInfo:instantiate();
        self:addChild(self.buttonInfo);
    end
end

function ISBuildWindowHeader:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    local spacing = 15;

    local requiredWidth = spacing;
    if self.icon then
        requiredWidth = self.icon:getWidth() + spacing;
    end

    requiredWidth = requiredWidth + self.title:getWidth();

    if self.buttonInfo then
        requiredWidth = requiredWidth + spacing + self.buttonInfo:getWidth();
    end

    width = math.max(width, requiredWidth + (self.paddingLeft + self.paddingRight) + (self.marginLeft+self.marginRight));

    if self.icon then
        height = math.max(height, self.icon:getHeight() + (self.paddingTop + self.paddingBottom) + (self.marginTop+self.marginBottom));
    end

    height = math.max(height, self.title:getHeight() + (self.paddingTop + self.paddingBottom) + (self.marginTop+self.marginBottom));

    if self.buttonInfo then
        height = math.max(height, self.buttonInfo:getHeight() + (self.paddingTop + self.paddingBottom) + (self.marginTop+self.marginBottom));
    end

    local x = spacing + self.paddingLeft + self.marginLeft;

    if self.icon then
        self.icon:setX(x);
        self.icon:setY((height/2)-(self.icon:getHeight()/2));

        x = self.icon:getX() + self.icon:getWidth() + spacing;
    end

    self.title:setX(x);
    self.title:setY((height/2) - (self.title:getHeight()/2));

    if self.buttonInfo then
        self.buttonInfo:setX(width - self.buttonInfo:getWidth() - self.paddingRight - self.marginRight - (spacing*0.5));
        self.buttonInfo:setY((height/2)-(self.buttonInfo:getHeight()/2))
    end

    self:setWidth(width);
    self:setHeight(height);
end

function ISBuildWindowHeader:onButtonClick(_button)
    if _button==self.buttonInfo then
        --todo open info panel
        print("Clickety click")
    end
end

function ISBuildWindowHeader:onResize()
    ISUIElement.onResize(self)
end

function ISBuildWindowHeader:prerender()
    --ISPanel.prerender(self);

	if self.background then
		self:drawRectStatic(self.marginLeft, self.marginTop, self.width - self.marginLeft - self.marginRight, self.height - self.marginTop - self.marginBottom, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
		self:drawRectBorderStatic(self.marginLeft, self.marginTop, self.width - self.marginLeft - self.marginRight, self.height - self.marginTop - self.marginBottom, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
	end
end

function ISBuildWindowHeader:render()
    ISPanel.render(self);
end

function ISBuildWindowHeader:update()
    ISPanel.update(self);
end

--************************************************************************--
--** ISBuildWindowHeader:new
--**
--************************************************************************--
function ISBuildWindowHeader:new(x, y, width, height, player, _styleIcon, _styleLabel, _styleButton)
	local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.player = player;

    o.titleStr = false;

    o.styleIcon = _styleIcon;
    o.styleLabel = _styleLabel;
    o.styleButton = _styleButton;

    o.paddingTop = 2;
    o.paddingBottom = 2;
    o.paddingLeft = 2;
    o.paddingRight = 2;
    o.marginTop = 5;
    o.marginBottom = 5;
    o.marginLeft = 5;
    o.marginRight = 5;

    o.enableIcon = true;
    o.enableInfoButton = true;

    return o
end