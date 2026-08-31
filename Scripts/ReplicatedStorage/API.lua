--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     API
  Path:     game.ReplicatedStorage.Packages._Index.michael-48_iris@2.3.1.iris.API
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:42 2026
]]

-- Decompiled with Potassium's decompiler.

require(script.Parent.Types);

return function(u1) -- Line: 3
    local function wrapper(u2: string) -- Line: 5
        -- upvalues: u1 (copy)
        return function(p3, p4) -- Line: 6
            -- upvalues: u1 (ref), u2 (copy)
            return u1.Internal._Insert(u2, p3, p4);
        end;
    end;

    local u5 = "Window";

    function u1.Window(p6, p7) -- Line: 6
        -- upvalues: u1 (copy), u5 (copy)
        return u1.Internal._Insert(u5, p6, p7);
    end;

    u1.SetFocusedWindow = u1.Internal.SetFocusedWindow;
    local u8 = "Tooltip";

    function u1.Tooltip(p9, p10) -- Line: 6
        -- upvalues: u1 (copy), u8 (copy)
        return u1.Internal._Insert(u8, p9, p10);
    end;

    local u11 = "MenuBar";

    function u1.MenuBar(p12, p13) -- Line: 6
        -- upvalues: u1 (copy), u11 (copy)
        return u1.Internal._Insert(u11, p12, p13);
    end;

    local u14 = "Menu";

    function u1.Menu(p15, p16) -- Line: 6
        -- upvalues: u1 (copy), u14 (copy)
        return u1.Internal._Insert(u14, p15, p16);
    end;

    local u17 = "MenuItem";

    function u1.MenuItem(p18, p19) -- Line: 6
        -- upvalues: u1 (copy), u17 (copy)
        return u1.Internal._Insert(u17, p18, p19);
    end;

    local u20 = "MenuToggle";

    function u1.MenuToggle(p21, p22) -- Line: 6
        -- upvalues: u1 (copy), u20 (copy)
        return u1.Internal._Insert(u20, p21, p22);
    end;

    local u23 = "Separator";

    function u1.Separator(p24, p25) -- Line: 6
        -- upvalues: u1 (copy), u23 (copy)
        return u1.Internal._Insert(u23, p24, p25);
    end;

    local u26 = "Indent";

    function u1.Indent(p27, p28) -- Line: 6
        -- upvalues: u1 (copy), u26 (copy)
        return u1.Internal._Insert(u26, p27, p28);
    end;

    local u29 = "SameLine";

    function u1.SameLine(p30, p31) -- Line: 6
        -- upvalues: u1 (copy), u29 (copy)
        return u1.Internal._Insert(u29, p30, p31);
    end;

    local u32 = "Group";

    function u1.Group(p33, p34) -- Line: 6
        -- upvalues: u1 (copy), u32 (copy)
        return u1.Internal._Insert(u32, p33, p34);
    end;

    local u35 = "Text";

    function u1.Text(p36, p37) -- Line: 6
        -- upvalues: u1 (copy), u35 (copy)
        return u1.Internal._Insert(u35, p36, p37);
    end;

    function u1.TextWrapped(p38) -- Line: 365
        -- upvalues: u1 (copy)
        p38[2] = true;

        return u1.Internal._Insert("Text", p38);
    end;

    function u1.TextColored(p39) -- Line: 390
        -- upvalues: u1 (copy)
        p39[3] = p39[2];
        p39[2] = nil;

        return u1.Internal._Insert("Text", p39);
    end;

    local u40 = "SeparatorText";

    function u1.SeparatorText(p41, p42) -- Line: 6
        -- upvalues: u1 (copy), u40 (copy)
        return u1.Internal._Insert(u40, p41, p42);
    end;

    local u43 = "InputText";

    function u1.InputText(p44, p45) -- Line: 6
        -- upvalues: u1 (copy), u43 (copy)
        return u1.Internal._Insert(u43, p44, p45);
    end;

    local u46 = "Button";

    function u1.Button(p47, p48) -- Line: 6
        -- upvalues: u1 (copy), u46 (copy)
        return u1.Internal._Insert(u46, p47, p48);
    end;

    local u49 = "SmallButton";

    function u1.SmallButton(p50, p51) -- Line: 6
        -- upvalues: u1 (copy), u49 (copy)
        return u1.Internal._Insert(u49, p50, p51);
    end;

    local u52 = "Checkbox";

    function u1.Checkbox(p53, p54) -- Line: 6
        -- upvalues: u1 (copy), u52 (copy)
        return u1.Internal._Insert(u52, p53, p54);
    end;

    local u55 = "RadioButton";

    function u1.RadioButton(p56, p57) -- Line: 6
        -- upvalues: u1 (copy), u55 (copy)
        return u1.Internal._Insert(u55, p56, p57);
    end;

    local u58 = "Image";

    function u1.Image(p59, p60) -- Line: 6
        -- upvalues: u1 (copy), u58 (copy)
        return u1.Internal._Insert(u58, p59, p60);
    end;

    local u61 = "ImageButton";

    function u1.ImageButton(p62, p63) -- Line: 6
        -- upvalues: u1 (copy), u61 (copy)
        return u1.Internal._Insert(u61, p62, p63);
    end;

    local u64 = "Tree";

    function u1.Tree(p65, p66) -- Line: 6
        -- upvalues: u1 (copy), u64 (copy)
        return u1.Internal._Insert(u64, p65, p66);
    end;

    local u67 = "CollapsingHeader";

    function u1.CollapsingHeader(p68, p69) -- Line: 6
        -- upvalues: u1 (copy), u67 (copy)
        return u1.Internal._Insert(u67, p68, p69);
    end;

    local u70 = "InputNum";

    function u1.InputNum(p71, p72) -- Line: 6
        -- upvalues: u1 (copy), u70 (copy)
        return u1.Internal._Insert(u70, p71, p72);
    end;

    local u73 = "InputVector2";

    function u1.InputVector2(p74, p75) -- Line: 6
        -- upvalues: u1 (copy), u73 (copy)
        return u1.Internal._Insert(u73, p74, p75);
    end;

    local u76 = "InputVector3";

    function u1.InputVector3(p77, p78) -- Line: 6
        -- upvalues: u1 (copy), u76 (copy)
        return u1.Internal._Insert(u76, p77, p78);
    end;

    local u79 = "InputUDim";

    function u1.InputUDim(p80, p81) -- Line: 6
        -- upvalues: u1 (copy), u79 (copy)
        return u1.Internal._Insert(u79, p80, p81);
    end;

    local u82 = "InputUDim2";

    function u1.InputUDim2(p83, p84) -- Line: 6
        -- upvalues: u1 (copy), u82 (copy)
        return u1.Internal._Insert(u82, p83, p84);
    end;

    local u85 = "InputRect";

    function u1.InputRect(p86, p87) -- Line: 6
        -- upvalues: u1 (copy), u85 (copy)
        return u1.Internal._Insert(u85, p86, p87);
    end;

    local u88 = "DragNum";

    function u1.DragNum(p89, p90) -- Line: 6
        -- upvalues: u1 (copy), u88 (copy)
        return u1.Internal._Insert(u88, p89, p90);
    end;

    local u91 = "DragVector2";

    function u1.DragVector2(p92, p93) -- Line: 6
        -- upvalues: u1 (copy), u91 (copy)
        return u1.Internal._Insert(u91, p92, p93);
    end;

    local u94 = "DragVector3";

    function u1.DragVector3(p95, p96) -- Line: 6
        -- upvalues: u1 (copy), u94 (copy)
        return u1.Internal._Insert(u94, p95, p96);
    end;

    local u97 = "DragUDim";

    function u1.DragUDim(p98, p99) -- Line: 6
        -- upvalues: u1 (copy), u97 (copy)
        return u1.Internal._Insert(u97, p98, p99);
    end;

    local u100 = "DragUDim2";

    function u1.DragUDim2(p101, p102) -- Line: 6
        -- upvalues: u1 (copy), u100 (copy)
        return u1.Internal._Insert(u100, p101, p102);
    end;

    local u103 = "DragRect";

    function u1.DragRect(p104, p105) -- Line: 6
        -- upvalues: u1 (copy), u103 (copy)
        return u1.Internal._Insert(u103, p104, p105);
    end;

    local u106 = "InputColor3";

    function u1.InputColor3(p107, p108) -- Line: 6
        -- upvalues: u1 (copy), u106 (copy)
        return u1.Internal._Insert(u106, p107, p108);
    end;

    local u109 = "InputColor4";

    function u1.InputColor4(p110, p111) -- Line: 6
        -- upvalues: u1 (copy), u109 (copy)
        return u1.Internal._Insert(u109, p110, p111);
    end;

    local u112 = "SliderNum";

    function u1.SliderNum(p113, p114) -- Line: 6
        -- upvalues: u1 (copy), u112 (copy)
        return u1.Internal._Insert(u112, p113, p114);
    end;

    local u115 = "SliderVector2";

    function u1.SliderVector2(p116, p117) -- Line: 6
        -- upvalues: u1 (copy), u115 (copy)
        return u1.Internal._Insert(u115, p116, p117);
    end;

    local u118 = "SliderVector3";

    function u1.SliderVector3(p119, p120) -- Line: 6
        -- upvalues: u1 (copy), u118 (copy)
        return u1.Internal._Insert(u118, p119, p120);
    end;

    local u121 = "SliderUDim";

    function u1.SliderUDim(p122, p123) -- Line: 6
        -- upvalues: u1 (copy), u121 (copy)
        return u1.Internal._Insert(u121, p122, p123);
    end;

    local u124 = "SliderUDim2";

    function u1.SliderUDim2(p125, p126) -- Line: 6
        -- upvalues: u1 (copy), u124 (copy)
        return u1.Internal._Insert(u124, p125, p126);
    end;

    local u127 = "SliderRect";

    function u1.SliderRect(p128, p129) -- Line: 6
        -- upvalues: u1 (copy), u127 (copy)
        return u1.Internal._Insert(u127, p128, p129);
    end;

    local u130 = "Selectable";

    function u1.Selectable(p131, p132) -- Line: 6
        -- upvalues: u1 (copy), u130 (copy)
        return u1.Internal._Insert(u130, p131, p132);
    end;

    local u133 = "Combo";

    function u1.Combo(p134, p135) -- Line: 6
        -- upvalues: u1 (copy), u133 (copy)
        return u1.Internal._Insert(u133, p134, p135);
    end;

    function u1.ComboArray(p136: any, p137: any, p138: table) -- Line: 1530
        -- upvalues: u1 (copy)
        if p137 == nil then
            p137 = u1.State(p138[1]);
        end;

        local v139 = u1.Internal._Insert("Combo", p136, p137);
        local index = v139.state.index;

        for _, v in p138 do
            u1.Internal._Insert("Selectable", { v, v }, {
                index = index
            });
        end;

        u1.End();

        return v139;
    end;

    function u1.ComboEnum(p140: any, p141: any, p142: userdata) -- Line: 1579
        -- upvalues: u1 (copy)
        if p141 == nil then
            p141 = u1.State(p142:GetEnumItems()[1]);
        end;

        local v143 = u1.Internal._Insert("Combo", p140, p141);
        local index = v143.state.index;

        for _, v in p142:GetEnumItems() do
            u1.Internal._Insert("Selectable", { v.Name, v }, {
                index = index
            });
        end;

        u1.End();

        return v143;
    end;

    u1.InputEnum = u1.ComboEnum;
    local u144 = "ProgressBar";

    function u1.ProgressBar(p145, p146) -- Line: 6
        -- upvalues: u1 (copy), u144 (copy)
        return u1.Internal._Insert(u144, p145, p146);
    end;

    local u147 = "Table";

    function u1.Table(p148, p149) -- Line: 6
        -- upvalues: u1 (copy), u147 (copy)
        return u1.Internal._Insert(u147, p148, p149);
    end;

    function u1.NextColumn() -- Line: 1674
        -- upvalues: u1 (copy)
        local v150 = u1.Internal._GetParentWidget();
        v150.RowColumnIndex = v150.RowColumnIndex + 1;
    end;

    function u1.SetColumnIndex(p151: number) -- Line: 1685
        -- upvalues: u1 (copy)
        local v152 = u1.Internal._GetParentWidget();
        assert(v152.InitialNumColumns <= p151, "Iris.SetColumnIndex Argument must be in column range");
        v152.RowColumnIndex = math.floor(v152.RowColumnIndex / v152.InitialNumColumns) + (p151 - 1);
    end;

    function u1.NextRow() -- Line: 1698
        -- upvalues: u1 (copy)
        local v153 = u1.Internal._GetParentWidget();
        local InitialNumColumns = v153.InitialNumColumns;
        v153.RowColumnIndex = math.floor((v153.RowColumnIndex + 1) / InitialNumColumns) * InitialNumColumns;
    end;
end;