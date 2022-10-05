require("firecast.lua");
local __o_rrpgObjs = require("rrpgObjs.lua");
require("rrpgGUI.lua");
require("rrpgDialogs.lua");
require("rrpgLFM.lua");
require("ndb.lua");
require("locale.lua");
local __o_Utils = require("utils.lua");

local function constructNew_frmHabilidade()
    local obj = GUI.fromHandle(_obj_newObject("form"));
    local self = obj;
    local sheet = nil;

    rawset(obj, "_oldSetNodeObjectFunction", rawget(obj, "setNodeObject"));

    function obj:setNodeObject(nodeObject)
        sheet = nodeObject;
        self.sheet = nodeObject;
        self:_oldSetNodeObjectFunction(nodeObject);
    end;

    function obj:setNodeDatabase(nodeObject)
        self:setNodeObject(nodeObject);
    end;

    _gui_assignInitialParentForForm(obj.handle);
    obj:beginUpdate();
    obj:setName("frmHabilidade");
    obj:setHeight(25);
    obj:setWidth(350);
    obj:setMargins({top=2});

			
		local function askForDelete()
			Dialogs.confirmYesNo("Deseja realmente apagar essa habilidade?",
								 function (confirmado)
									if confirmado then
										NDB.deleteNode(sheet);
									end;
								 end);
		end;

		local function showHabilidadePopup()
			local pop = self:findControlByName("popHabilidade");
				
			if pop ~= nil then
				pop:setNodeObject(self.sheet);
				pop:showPopupEx("right", self);
			else
				showMessage("Ops, bug.. nao encontrei o popup de habilidades para exibir");
			end;				
		end;
	


    obj.edit1 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit1:setParent(obj);
    obj.edit1:setAlign("left");
    obj.edit1:setWidth(30);
    obj.edit1:setField("qtdHabilidade");
    obj.edit1:setType("number");
    obj.edit1:setVertTextAlign("center");
    obj.edit1:setName("edit1");

    obj.button1 = GUI.fromHandle(_obj_newObject("button"));
    obj.button1:setParent(obj);
    obj.button1:setAlign("right");
    obj.button1:setWidth(25);
    obj.button1:setText("i");
    obj.button1:setName("button1");

    obj.button2 = GUI.fromHandle(_obj_newObject("button"));
    obj.button2:setParent(obj);
    obj.button2:setAlign("right");
    obj.button2:setWidth(25);
    obj.button2:setText("X");
    obj.button2:setName("button2");

    obj.edit2 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit2:setParent(obj);
    obj.edit2:setAlign("client");
    obj.edit2:setVertTextAlign("center");
    obj.edit2:setField("nome");
    obj.edit2:setName("edit2");

    obj._e_event0 = obj.button1:addEventListener("onClick",
        function (_)
            showHabilidadePopup();
        end, obj);

    obj._e_event1 = obj.button2:addEventListener("onClick",
        function (_)
            askForDelete();
        end, obj);

    function obj:_releaseEvents()
        __o_rrpgObjs.removeEventListenerById(self._e_event1);
        __o_rrpgObjs.removeEventListenerById(self._e_event0);
    end;

    obj._oldLFMDestroy = obj.destroy;

    function obj:destroy() 
        self:_releaseEvents();

        if (self.handle ~= 0) and (self.setNodeDatabase ~= nil) then
          self:setNodeDatabase(nil);
        end;

        if self.edit1 ~= nil then self.edit1:destroy(); self.edit1 = nil; end;
        if self.button1 ~= nil then self.button1:destroy(); self.button1 = nil; end;
        if self.button2 ~= nil then self.button2:destroy(); self.button2 = nil; end;
        if self.edit2 ~= nil then self.edit2:destroy(); self.edit2 = nil; end;
        self:_oldLFMDestroy();
    end;

    obj:endUpdate();

    return obj;
end;

function newfrmHabilidade()
    local retObj = nil;
    __o_rrpgObjs.beginObjectsLoading();

    __o_Utils.tryFinally(
      function()
        retObj = constructNew_frmHabilidade();
      end,
      function()
        __o_rrpgObjs.endObjectsLoading();
      end);

    assert(retObj ~= nil);
    return retObj;
end;

local _frmHabilidade = {
    newEditor = newfrmHabilidade, 
    new = newfrmHabilidade, 
    name = "frmHabilidade", 
    dataType = "", 
    formType = "undefined", 
    formComponentName = "form", 
    title = "", 
    description=""};

frmHabilidade = _frmHabilidade;
Firecast.registrarForm(_frmHabilidade);

return _frmHabilidade;
