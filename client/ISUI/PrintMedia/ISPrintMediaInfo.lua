require "ISBaseObject"

ISPrintMediaInfo = ISBaseObject:derive("ISPrintMediaInfo");

--************************************************************************--
--** ISPrintMediaInfo:initialise
--**
--************************************************************************--

function ISPrintMediaInfo:initialise()

end

--************************************************************************--
--** ISPrintMediaInfo:new
--**
--************************************************************************--
function ISPrintMediaInfo:new (title, text, moreTextInfo, nextcondition)
	local o = {}
	o.data = {}
    setmetatable(o, self)
    self.__index = self
	o.title = title;
	o.text = text;
	o.nextcondition = nextcondition;
	o.moreTextInfo = moreTextInfo;
   return o
end

ISPrintMediaSetInfo = ISBaseObject:derive("ISPrintMediaSetInfo");

--************************************************************************--
--** ISPrintMediaInfo:initialise
--**
--************************************************************************--

function ISPrintMediaSetInfo:initialise()

end

function ISPrintMediaSetInfo:addPage(pagetitle, pagetext, moreTextInfo, pagenextcondition)
	self.pages[self.pageCount] = ISPrintMediaInfo:new(pagetitle, pagetext, moreTextInfo, pagenextcondition);
	self.pageCount = self.pageCount + 1;
end

function ISPrintMediaSetInfo:getCurrent()
	return self.pages[self.currentPage];
end

function ISPrintMediaSetInfo:applyPageToRichTextPanel(tutorialPanel)
	local current = self:getCurrent();
	tutorialPanel.textDirty = true;
	tutorialPanel.text = current.text;
	tutorialPanel:paginate();
end

function ISPrintMediaSetInfo:hasNext()
    return self.currentPage + 1 < self.pageCount;
end

function ISPrintMediaSetInfo:hasPrevious()
    return self.currentPage > 1;
end

function ISPrintMediaSetInfo:update(tutorialPanel)
	local current = self:getCurrent();

	if current ~= nil then
		if(current.nextcondition ~= nil) then
			if current.nextcondition() == true then
				self.currentPage = self.currentPage + 1;
				self:applyPageToRichTextPanel(tutorialPanel);
			end
		end
	end
end

--************************************************************************--
--** ISPrintMediaInfo:new
--**
--************************************************************************--
function ISPrintMediaSetInfo:new ()
	local o = {}
    setmetatable(o, self)
    self.__index = self
	o.pages = {}
	o.pageCount = 1;
	o.currentPage = 1;
   return o
end

