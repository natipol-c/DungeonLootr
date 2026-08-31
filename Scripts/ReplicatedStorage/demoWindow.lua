--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     demoWindow
  Path:     game.ReplicatedStorage.Packages._Index.michael-48_iris@2.3.1.iris.demoWindow
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:42 2026
]]

-- Decompiled with Potassium's decompiler.

require(script.Parent.Types);

return function(u1) -- Line: 3
    local u2 = u1.State(true);
    local u3 = u1.State(false);
    local u4 = u1.State(false);
    local u5 = u1.State(false);
    local u6 = u1.State(false);
    local u7 = u1.State(false);
    local u8 = u1.State(false);

    local function helpMarker(p9) -- Line: 12
        -- upvalues: u1 (copy)
        u1.PushConfig({
            TextColor = u1._config.TextDisabledColor
        });
        local v10 = u1.Text({ "(?)" });
        u1.PopConfig();
        u1.PushConfig({
            ContentWidth = UDim.new(0, 350)
        });

        if v10.hovered() then
            u1.Tooltip({ p9 });
        end;

        u1.PopConfig();
    end;

    local u59 = {
        Basic = function() -- Line: 26, Name: Basic
            -- upvalues: u1 (copy)
            u1.Tree({ "Basic" });
            u1.SeparatorText({ "Basic" });
            local v11 = u1.State(1);
            u1.Button({ "Button" });
            u1.SmallButton({ "SmallButton" });
            u1.Text({ "Text" });
            u1.TextWrapped({ string.rep("Text Wrapped ", 5) });
            u1.TextColored({ "Colored Text", Color3.fromRGB(255, 128, 0) });
            u1.Text({ "Rich Text: <b>bold text</b> <i>italic text</i> <u>underline text</u> <s>strikethrough text</s> <font color= \"rgb(240, 40, 10)\">red text</font> <font size=\"32\">bigger text</font>", true, nil, true });
            u1.SameLine();
            u1.RadioButton({ "Index \'1\'", 1 }, {
                index = v11
            });
            u1.RadioButton({ "Index \'two\'", "two" }, {
                index = v11
            });

            if u1.RadioButton({ "Index \'false\'", false }, {
                index = v11
            }).active() == false and u1.SmallButton({ "Select last" }).clicked() then
                v11:set(false);
            end;

            u1.End();
            u1.Text({ "The Index is: " .. tostring(v11.value) });
            u1.SeparatorText({ "Inputs" });
            u1.InputNum({});
            u1.DragNum({});
            u1.SliderNum({});
            u1.End();
        end,

        Image = function() -- Line: 62, Name: Image
            -- upvalues: u1 (copy)
            u1.Tree({ "Image" });
            u1.SeparatorText({ "Image Controls" });
            local v12 = u1.State("rbxasset://textures/ui/common/robux.png");
            local v13 = u1.State(UDim2.fromOffset(100, 100));
            local v14 = u1.State(Rect.new(0, 0, 0, 0));
            local v15 = u1.State(Enum.ScaleType.Stretch);
            local v16 = u1.State(false);
            local v18 = u1.ComputedState(v16, function(p17: boolean) -- Line: 72
                return p17 and Enum.ResamplerMode.Pixelated or Enum.ResamplerMode.Default;
            end);
            local v19 = u1.State(u1._config.ImageColor);
            local v20 = u1.State(u1._config.ImageTransparency);
            u1.InputColor4({ "Image Tint" }, {
                color = v19,
                transparency = v20
            });
            u1.Combo({ "Asset" }, {
                index = v12
            });
            u1.Selectable({ "Robux Small", "rbxasset://textures/ui/common/robux.png" }, {
                index = v12
            });
            u1.Selectable({ "Robux Large", "rbxasset://textures//ui/common/robux@3x.png" }, {
                index = v12
            });
            u1.Selectable({ "Loading Texture", "rbxasset://textures//loading/darkLoadingTexture.png" }, {
                index = v12
            });
            u1.Selectable({ "Hue-Saturation Gradient", "rbxasset://textures//TagEditor/huesatgradient.png" }, {
                index = v12
            });
            u1.Selectable({ "famfamfam.png (WHY?)", "rbxasset://textures//TagEditor/famfamfam.png" }, {
                index = v12
            });
            u1.End();
            u1.SliderUDim2({
                "Image Size",
                nil,
                nil,
                UDim2.new(1, 240, 1, 240)
            }, {
                number = v13
            });
            u1.SliderRect({
                "Image Rect",
                nil,
                nil,
                Rect.new(256, 256, 256, 256)
            }, {
                number = v14
            });
            u1.Combo({ "Scale Type" }, {
                index = v15
            });
            u1.Selectable({ "Stretch", Enum.ScaleType.Stretch }, {
                index = v15
            });
            u1.Selectable({ "Fit", Enum.ScaleType.Fit }, {
                index = v15
            });
            u1.Selectable({ "Crop", Enum.ScaleType.Crop }, {
                index = v15
            });
            u1.End();
            u1.Checkbox({ "Pixelated" }, {
                isChecked = v16
            });
            u1.PushConfig({
                ImageColor = v19:get(),
                ImageTransparency = v20:get()
            });
            u1.Image({
                v12:get(),
                v13:get(),
                v14:get(),
                v15:get(),
                v18:get()
            });
            u1.PopConfig();
            u1.SeparatorText({ "Tile" });
            local v21 = u1.State(UDim2.fromScale(0.5, 0.5));
            u1.SliderUDim2({
                "Tile Size",
                nil,
                nil,
                UDim2.new(1, 240, 1, 240)
            }, {
                number = v21
            });
            u1.PushConfig({
                ImageColor = v19:get(),
                ImageTransparency = v20:get()
            });
            u1.Image({
                "rbxasset://textures/grid2.png",
                v13:get(),
                nil,
                Enum.ScaleType.Tile,
                v18:get(),
                v21:get()
            });
            u1.PopConfig();
            u1.SeparatorText({ "Slice" });
            local v22 = u1.State(1);
            u1.SliderNum({ "Image Slice Scale", 0.1, 0.1, 5 }, {
                number = v22
            });
            u1.PushConfig({
                ImageColor = v19:get(),
                ImageTransparency = v20:get()
            });
            u1.Image({
                "rbxasset://textures/ui/chatBubble_blue_notify_bkg.png",
                v13:get(),
                nil,
                Enum.ScaleType.Slice,
                v18:get(),
                nil,
                Rect.new(12, 12, 56, 56),
                1
            }, v22:get());
            u1.PopConfig();
            u1.SeparatorText({ "Image Button" });
            local v23 = u1.State(0);
            u1.SameLine();
            u1.PushConfig({
                ImageColor = v19:get(),
                ImageTransparency = v20:get()
            });

            if u1.ImageButton({ "rbxasset://textures/AvatarCompatibilityPreviewer/add.png", UDim2.fromOffset(20, 20) }).clicked() then
                v23:set(v23.value + 1);
            end;

            u1.PopConfig();
            u1.Text({ (`Click count: {v23.value}`) });
            u1.End();
            u1.End();
        end,

        Selectable = function() -- Line: 153, Name: Selectable
            -- upvalues: u1 (copy)
            u1.Tree({ "Selectable" });
            local v24 = u1.State(2);
            u1.Selectable({ "Selectable #1", 1 }, {
                index = v24
            });
            u1.Selectable({ "Selectable #2", 2 }, {
                index = v24
            });

            if u1.Selectable({ "Double click Selectable", 3, true }, {
                index = v24
            }).doubleClicked() then
                v24:set(3);
            end;

            u1.Selectable({ "Impossible to select", 4, true }, {
                index = v24
            });

            if u1.Button({ "Select last" }).clicked() then
                v24:set(4);
            end;

            u1.Selectable({ "Independent Selectable" });
            u1.End();
        end,

        Combo = function() -- Line: 173, Name: Combo
            -- upvalues: u1 (copy)
            u1.Tree({ "Combo" });
            u1.PushConfig({
                ContentWidth = UDim.new(1, -200)
            });
            local v25 = u1.State("No Selection");
            u1.SameLine();
            local v26 = u1.Checkbox({ "No Preview" });
            local v27 = u1.Checkbox({ "No Button" });

            if v26.checked() and v27.isChecked.value == true then
                v27.isChecked:set(false);
            end;

            if v27.checked() and v26.isChecked.value == true then
                v26.isChecked:set(false);
            end;

            u1.End();
            u1.Combo({ "Basic Usage", v27.isChecked:get(), v26.isChecked:get() }, {
                index = v25
            });
            u1.Selectable({ "Select 1", "One" }, {
                index = v25
            });
            u1.Selectable({ "Select 2", "Two" }, {
                index = v25
            });
            u1.Selectable({ "Select 3", "Three" }, {
                index = v25
            });
            u1.End();
            u1.ComboArray({ "Using ComboArray" }, {
                index = "No Selection"
            }, { "Red", "Green", "Blue" });
            local v28 = u1.State("7 AM");
            u1.Combo({ "Combo with Inner widgets" }, {
                index = v28
            });
            u1.Tree({ "Morning Shifts" });
            u1.Selectable({ "Shift at 7 AM", "7 AM" }, {
                index = v28
            });
            u1.Selectable({ "Shift at 11 AM", "11 AM" }, {
                index = v28
            });
            u1.Selectable({ "Shift at 3 PM", "3 PM" }, {
                index = v28
            });
            u1.End();
            u1.Tree({ "Night Shifts" });
            u1.Selectable({ "Shift at 6 PM", "6 PM" }, {
                index = v28
            });
            u1.Selectable({ "Shift at 9 PM", "9 PM" }, {
                index = v28
            });
            u1.End();
            u1.End();
            local v29 = u1.ComboEnum({ "Using ComboEnum" }, {
                index = Enum.UserInputState.Begin
            }, Enum.UserInputState);
            u1.Text({ "Selected: " .. v29.index:get().Name });
            u1.PopConfig();
            u1.End();
        end,

        Tree = function() -- Line: 229, Name: Tree
            -- upvalues: u1 (copy), helpMarker (copy)
            u1.Tree({ "Trees" });
            u1.Tree({ "Tree using SpanAvailWidth", true });
            helpMarker("SpanAvailWidth determines if the Tree is selectable from its entire with, or only the text area");
            u1.End();
            local v30 = u1.Tree({ "Tree with Children" });
            u1.Text({ "Im inside the first tree!" });
            u1.Button({ "Im a button inside the first tree!" });
            u1.Tree({ "Im a tree inside the first tree!" });
            u1.Text({ "I am the innermost text!" });
            u1.End();
            u1.End();
            u1.Checkbox({ "Toggle above tree" }, {
                isChecked = v30.state.isUncollapsed
            });
            u1.End();
        end,

        CollapsingHeader = function() -- Line: 255, Name: CollapsingHeader
            -- upvalues: u1 (copy)
            u1.Tree({ "Collapsing Headers" });
            u1.CollapsingHeader({ "A header" });
            u1.Text({ "This is under the first header!" });
            u1.End();
            local v31 = u1.State(false);
            u1.CollapsingHeader({ "Another header" }, {
                isUncollapsed = v31
            });

            if u1.Button({ "Shhh... secret button!" }).clicked() then
                v31:set(true);
            end;

            u1.End();
            u1.End();
        end,

        Group = function() -- Line: 276, Name: Group
            -- upvalues: u1 (copy)
            u1.Tree({ "Groups" });
            u1.SameLine();
            u1.Group();
            u1.Text({ "I am in group A" });
            u1.Button({ "Im also in A" });
            u1.End();
            u1.Separator();
            u1.Group();
            u1.Text({ "I am in group B" });
            u1.Button({ "Im also in B" });
            u1.Button({ "Also group B" });
            u1.End();
            u1.End();
            u1.End();
        end,

        Indent = function() -- Line: 303, Name: Indent
            -- upvalues: u1 (copy)
            u1.Tree({ "Indents" });
            u1.Text({ "Not Indented" });
            u1.Indent();
            u1.Text({ "Indented" });
            u1.Indent({ 7 });
            u1.Text({ "Indented by 7 more pixels" });
            u1.End();
            u1.Indent({ -7 });
            u1.Text({ "Indented by 7 less pixels" });
            u1.End();
            u1.End();
            u1.End();
        end,

        Input = function() -- Line: 325, Name: Input
            -- upvalues: u1 (copy), helpMarker (copy)
            u1.Tree({ "Input" });
            local v32 = u1.State(false);
            local v33 = u1.State(false);
            local v34 = u1.State(0);
            local v35 = u1.State(100);
            local v36 = u1.State(1);
            local v37 = u1.State("%d");
            u1.PushConfig({
                ContentWidth = UDim.new(1, -120)
            });
            local v38 = u1.InputNum({
                [u1.Args.InputNum.Text] = "Input Number",
                [u1.Args.InputNum.NoButtons] = v33.value,
                [u1.Args.InputNum.Min] = v34.value,
                [u1.Args.InputNum.Max] = v35.value,
                [u1.Args.InputNum.Increment] = v36.value,
                [u1.Args.InputNum.Format] = { v37.value }
            });
            u1.PopConfig();
            u1.Text({ "The Value is: " .. v38.number.value });

            if u1.Button({ "Randomize Number" }).clicked() then
                v38.number:set(math.random(1, 99));
            end;

            local v39 = u1.Checkbox({ "NoField" }, {
                isChecked = v32
            });
            local v40 = u1.Checkbox({ "NoButtons" }, {
                isChecked = v33
            });

            if v39.checked() and v40.isChecked.value == true then
                v40.isChecked:set(false);
            end;

            if v40.checked() and v39.isChecked.value == true then
                v39.isChecked:set(false);
            end;

            u1.PushConfig({
                ContentWidth = UDim.new(1, -120)
            });
            u1.InputVector2({ "InputVector2" });
            u1.InputVector3({ "InputVector3" });
            u1.InputUDim({ "InputUDim" });
            u1.InputUDim2({ "InputUDim2" });
            local v41 = u1.State(false);
            local v42 = u1.State(false);
            local v43 = u1.State(Color3.new());
            local v44 = u1.State(0);
            u1.SliderNum({ "Transparency", 0.01, 0, 1 }, {
                number = v44
            });
            u1.InputColor3({ "InputColor3", v41:get(), v42:get() }, {
                color = v43
            });
            u1.InputColor4({ "InputColor4", v41:get(), v42:get() }, {
                color = v43,
                transparency = v44
            });
            u1.SameLine();
            u1.Text({ v43:get():ToHex() });
            u1.Checkbox({ "Use Floats" }, {
                isChecked = v41
            });
            u1.Checkbox({ "Use HSV" }, {
                isChecked = v42
            });
            u1.End();
            u1.PopConfig();
            u1.Separator();
            u1.SameLine();
            u1.Text({ "Slider Numbers" });
            helpMarker("ctrl + click slider number widgets to input a number");
            u1.End();
            u1.PushConfig({
                ContentWidth = UDim.new(1, -120)
            });
            u1.SliderNum({ "Slide Int", 1, 1, 8 });
            u1.SliderNum({ "Slide Float", 0.01, 0, 100 });
            u1.SliderNum({ "Small Numbers", 0.001, -2, 1, "%f radians" });
            u1.SliderNum({ "Odd Ranges", 0.001, -3.141592653589793, 3.141592653589793, "%f radians" });
            u1.SliderNum({ "Big Numbers", 10000, 100000, 10000000 });
            u1.SliderNum({ "Few Numbers", 1, 0, 3 });
            u1.PopConfig();
            u1.Separator();
            u1.SameLine();
            u1.Text({ "Drag Numbers" });
            helpMarker("ctrl + click or double click drag number widgets to input a number, hold shift/alt while dragging to increase/decrease speed");
            u1.End();
            u1.PushConfig({
                ContentWidth = UDim.new(1, -120)
            });
            u1.DragNum({ "Drag Int" });
            u1.DragNum({ "Slide Float", 0.001, -10, 10 });
            u1.DragNum({ "Percentage", 1, 0, 100, "%d %%" });
            u1.PopConfig();
            u1.End();
        end,

        InputText = function() -- Line: 408, Name: InputText
            -- upvalues: u1 (copy)
            u1.Tree({ "Input Text" });
            local v45 = u1.InputText({ "Input Text Test", "Input Text here" });
            u1.Text({ "The text is: " .. v45.text.value });
            u1.End();
        end,

        MultiInput = function() -- Line: 417, Name: MultiInput
            -- upvalues: u1 (copy)
            u1.Tree({ "Multi-Component Input" });
            local v46 = u1.State(Vector2.new());
            local v47 = u1.State((Vector3.new()));
            local v48 = u1.State(UDim.new());
            local v49 = u1.State(UDim2.new());
            local v50 = u1.State(Color3.new());
            local v51 = u1.State(Rect.new(0, 0, 0, 0));
            u1.SeparatorText({ "Input" });
            u1.InputVector2({}, {
                number = v46
            });
            u1.InputVector3({}, {
                number = v47
            });
            u1.InputUDim({}, {
                number = v48
            });
            u1.InputUDim2({}, {
                number = v49
            });
            u1.InputRect({}, {
                number = v51
            });
            u1.SeparatorText({ "Drag" });
            u1.DragVector2({}, {
                number = v46
            });
            u1.DragVector3({}, {
                number = v47
            });
            u1.DragUDim({}, {
                number = v48
            });
            u1.DragUDim2({}, {
                number = v49
            });
            u1.DragRect({}, {
                number = v51
            });
            u1.SeparatorText({ "Slider" });
            u1.SliderVector2({}, {
                number = v46
            });
            u1.SliderVector3({}, {
                number = v47
            });
            u1.SliderUDim({}, {
                number = v48
            });
            u1.SliderUDim2({}, {
                number = v49
            });
            u1.SliderRect({}, {
                number = v51
            });
            u1.SeparatorText({ "Color" });
            u1.InputColor3({}, {
                color = v50
            });
            u1.InputColor4({}, {
                color = v50
            });
            u1.End();
        end,

        Tooltip = function() -- Line: 459, Name: Tooltip
            -- upvalues: u1 (copy)
            u1.PushConfig({
                ContentWidth = UDim.new(0, 250)
            });
            u1.Tree({ "Tooltip" });

            if u1.Text({ "Hover over me to reveal a tooltip" }).hovered() then
                u1.Tooltip({ "I am some helpful tooltip text" });
            end;

            local v52 = u1.State("Hello ");
            local v53 = u1.State(1);

            if u1.InputNum({ "# of repeat", 1, 1, 50 }, {
                number = v53
            }).numberChanged() then
                v52:set(string.rep("Hello ", v53:get()));
            end;

            if u1.Checkbox({ "Show dynamic text tooltip" }).isChecked.value then
                u1.Tooltip({ v52:get() });
            end;

            u1.End();
            u1.PopConfig();
        end,

        Plotting = function() -- Line: 479, Name: Plotting
            -- upvalues: u1 (copy)
            u1.Tree({ "Plotting" });
            local v54 = os.clock() * 15;
            local v55 = u1.State(0);
            local v56 = math.abs(v54 % 100 - 50) - 7.5;
            v55:set(math.clamp(v56, 0, 35) / 35);
            u1.ProgressBar({ "Progress Bar" }, {
                progress = v55
            });
            local ProgressBar = u1.ProgressBar;
            local v57 = {};
            local v58 = v55:get() * 1753;
            v57[1], v57[2] = "Progress Bar", `{math.floor(v58)}/1753`;
            ProgressBar(v57, {
                progress = v55
            });
            u1.End();
        end
    };
    local u60 = { "Basic", "Image", "Selectable", "Combo", "Tree", "CollapsingHeader", "Group", "Indent", "Input", "MultiInput", "InputText", "Tooltip", "Plotting" };

    local function recursiveTree() -- Line: 497
        -- upvalues: u1 (copy), recursiveTree (copy)
        if u1.Tree({ "Recursive Tree" }).state.isUncollapsed.value then
            recursiveTree();
        end;

        u1.End();
    end;

    local function recursiveWindow(p61) -- Line: 507
        -- upvalues: u1 (copy), recursiveWindow (copy)
        u1.Window({ "Recursive Window" }, {
            size = u1.State(Vector2.new(175, 100)),
            isOpened = p61
        });
        local v62 = u1.Checkbox({ "Recurse Again" });
        u1.End();

        if v62.isChecked.value then
            recursiveWindow(v62.isChecked);
        end;
    end;

    local function runtimeInfo() -- Line: 521
        -- upvalues: u1 (copy), u4 (copy), helpMarker (copy)
        local v63 = u1.Window({ "Runtime Info" }, {
            isOpened = u4
        });
        local _lastVDOM = u1.Internal._lastVDOM;
        local _states = u1.Internal._states;
        local v64 = u1.State(3);
        local v65 = u1.State(0);
        local v66 = u1.State(os.clock());
        u1.SameLine();
        u1.InputNum({
            [u1.Args.InputNum.Text] = "",
            [u1.Args.InputNum.Format] = "%d Seconds",
            [u1.Args.InputNum.Max] = 10
        }, {
            number = v64
        });

        if u1.Button({ "Disable" }).clicked() then
            u1.Disabled = true;
            task.delay(v64:get(), function() -- Line: 536
                -- upvalues: u1 (ref)
                u1.Disabled = false;
            end);
        end;

        u1.End();
        local os_clock_ret = os.clock();
        v65.value = v65.value + (os_clock_ret - v66.value - v65.value) * 0.2;
        v66.value = os_clock_ret;
        u1.Text({ string.format("Average %.3f ms/frame (%.1f FPS)", v65.value * 1000, 1 / v65.value) });
        u1.Text({ string.format("Window Position: (%d, %d), Window Size: (%d, %d)", v63.position.value.X, v63.position.value.Y, v63.size.value.X, v63.size.value.Y) });
        u1.SameLine();
        u1.Text({ "Enter an ID to learn more about it." });
        helpMarker("every widget and state has an ID which Iris tracks to remember which widget is which. below lists all widgets and states, with their respective IDs");
        u1.End();
        u1.PushConfig({
            ItemWidth = UDim.new(1, -150)
        });
        local value = u1.InputText({ "ID field" }, {
            text = u1.State(v63.ID)
        }).text.value;
        u1.PopConfig();
        u1.Indent();
        local v67 = _lastVDOM[value];
        local v68 = _states[value];

        if v67 then
            u1.Table({ 1 });
            u1.Text({ string.format("The ID, \"%s\", is a widget", value) });
            u1.NextRow();
            u1.Text({ string.format("Widget is type: %s", v67.type) });
            u1.NextRow();
            u1.Tree({ "Widget has Args:" }, {
                isUncollapsed = u1.State(true)
            });

            for i, v in v67.arguments do
                u1.Text({ i .. " - " .. tostring(v) });
            end;

            u1.End();
            u1.NextRow();

            if v67.state then
                u1.Tree({ "Widget has State:" }, {
                    isUncollapsed = u1.State(true)
                });

                for i, v in v67.state do
                    u1.Text({ i .. " - " .. tostring(v.value) });
                end;

                u1.End();
            end;

            u1.End();
        elseif v68 then
            u1.Table({ 1 });
            u1.Text({ string.format("The ID, \"%s\", is a state", value) });
            u1.NextRow();
            u1.Text({ string.format("Value is type: %s, Value = %s", typeof(v68.value), (tostring(v68.value))) });
            u1.NextRow();
            u1.Tree({ "state has connected widgets:" }, {
                isUncollapsed = u1.State(true)
            });

            for i, v in v68.ConnectedWidgets do
                u1.Text({ i .. " - " .. v.type });
            end;

            u1.End();
            u1.NextRow();
            u1.Text({ string.format("state has: %d connected functions", #v68.ConnectedFunctions) });
            u1.End();
        else
            u1.Text({ string.format("The ID, \"%s\", is not a state or widget", value) });
        end;

        u1.End();

        if u1.Tree({ "Widgets" }).isUncollapsed.value then
            local v69 = 0;
            local v70 = "";

            for _, v in _lastVDOM do
                v69 = v69 + 1;
                v70 = v70 .. "\n" .. v.ID .. " - " .. v.type;
            end;

            u1.Text({ "Number of Widgets: " .. v69 });
            u1.Text({ v70 });
        end;

        u1.End();

        if u1.Tree({ "States" }).isUncollapsed.value then
            local v71 = 0;
            local v72 = "";

            for i, v in _states do
                v71 = v71 + 1;
                v72 = v72 .. "\n" .. i .. " - " .. tostring(v.value);
            end;

            u1.Text({ "Number of States: " .. v71 });
            u1.Text({ v72 });
        end;

        u1.End();
        u1.End();
    end;

    local function debugPanel() -- Line: 645
        -- upvalues: u1 (copy), u8 (copy)
        u1.Window({ "Debug Panel" }, {
            isOpened = u8
        });
        u1.CollapsingHeader({ "Widgets" });
        u1.SeparatorText({ "GuiService" });
        u1.Text({ (`GuiOffset: {u1.Internal._utility.GuiOffset}`) });
        u1.Text({ (`MouseOffset: {u1.Internal._utility.MouseOffset}`) });
        u1.SeparatorText({ "UserInputService" });
        u1.Text({ (`MousePosition: {u1.Internal._utility.UserInputService:GetMouseLocation()}`) });
        u1.Text({ (`MouseLocation: {u1.Internal._utility.getMouseLocation()}`) });
        u1.Text({ (`Left Control: {u1.Internal._utility.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)}`) });
        u1.Text({ (`Right Control: {u1.Internal._utility.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)}`) });
        u1.End();
        u1.End();
    end;

    local function recursiveMenu() -- Line: 666
        -- upvalues: u1 (copy), recursiveMenu (copy)
        if u1.Menu({ "Recursive" }).state.isOpened.value then
            u1.MenuItem({ "New", Enum.KeyCode.N, Enum.ModifierKey.Ctrl });
            u1.MenuItem({ "Open", Enum.KeyCode.O, Enum.ModifierKey.Ctrl });
            u1.MenuItem({ "Save", Enum.KeyCode.S, Enum.ModifierKey.Ctrl });
            u1.Separator();
            u1.MenuToggle({ "Autosave" });
            u1.MenuToggle({ "Checked" });
            u1.Separator();
            u1.Menu({ "Options" });
            u1.MenuItem({ "Red" });
            u1.MenuItem({ "Yellow" });
            u1.MenuItem({ "Green" });
            u1.MenuItem({ "Blue" });
            u1.Separator();
            recursiveMenu();
            u1.End();
        end;

        u1.End();
    end;

    local function mainMenuBar() -- Line: 687
        -- upvalues: u1 (copy), recursiveMenu (copy), u2 (copy), u3 (copy), u6 (copy), u7 (copy), u4 (copy), u5 (copy), u8 (copy)
        u1.MenuBar();
        u1.Menu({ "File" });
        u1.MenuItem({ "New", Enum.KeyCode.N, Enum.ModifierKey.Ctrl });
        u1.MenuItem({ "Open", Enum.KeyCode.O, Enum.ModifierKey.Ctrl });
        u1.MenuItem({ "Save", Enum.KeyCode.S, Enum.ModifierKey.Ctrl });
        recursiveMenu();

        if u1.MenuItem({ "Quit", Enum.KeyCode.Q, Enum.ModifierKey.Alt }).clicked() then
            u2:set(false);
        end;

        u1.End();
        u1.Menu({ "Examples" });
        u1.MenuToggle({ "Recursive Window" }, {
            isChecked = u3
        });
        u1.MenuToggle({ "Windowless" }, {
            isChecked = u6
        });
        u1.MenuToggle({ "Main Menu Bar" }, {
            isChecked = u7
        });
        u1.End();
        u1.Menu({ "Tools" });
        u1.MenuToggle({ "Runtime Info" }, {
            isChecked = u4
        });
        u1.MenuToggle({ "Style Editor" }, {
            isChecked = u5
        });
        u1.MenuToggle({ "Debug Panel" }, {
            isChecked = u8
        });
        u1.End();
        u1.End();
    end;

    local function mainMenuBarExample() -- Line: 721
        -- upvalues: mainMenuBar (copy)
        mainMenuBar();
    end;

    local function u92() -- Line: 736
        -- upvalues: u1 (copy), helpMarker (copy), u5 (copy)
        local v73 = u1.State(1);
        local v89 = {
            { "Sizing", function() -- Line: 742
                    -- upvalues: u1 (ref), helpMarker (ref)
                    local u74 = u1.State({});
                    u1.SameLine();

                    if u1.Button({ "Update" }).clicked() then
                        u1.UpdateGlobalConfig(u74.value);
                        u74:set({});
                    end;

                    helpMarker("Update the global config with these changes.");
                    u1.End();

                    local function SliderInput(p75: string, p76: table) -- Line: 756
                        -- upvalues: u1 (ref), u74 (copy)
                        local v77 = u1[p75](p76, {
                            number = u1.WeakState(u1._config[p76[1]])
                        });

                        if v77.numberChanged() then
                            u74.value[p76[1]] = v77.number:get();
                        end;
                    end;

                    local function BooleanInput(p78: table) -- Line: 763
                        -- upvalues: u1 (ref), u74 (copy)
                        local v79 = u1.Checkbox(p78, {
                            isChecked = u1.WeakState(u1._config[p78[1]])
                        });

                        if v79.checked() or v79.unchecked() then
                            u74.value[p78[1]] = v79.isChecked:get();
                        end;
                    end;

                    u1.SeparatorText({ "Main" });
                    SliderInput("SliderVector2", {
                        "WindowPadding",
                        nil,
                        Vector2.zero,
                        Vector2.one * 20
                    });
                    SliderInput("SliderVector2", {
                        "WindowResizePadding",
                        nil,
                        Vector2.zero,
                        Vector2.one * 20
                    });
                    SliderInput("SliderVector2", {
                        "FramePadding",
                        nil,
                        Vector2.zero,
                        Vector2.one * 20
                    });
                    SliderInput("SliderVector2", {
                        "ItemSpacing",
                        nil,
                        Vector2.zero,
                        Vector2.one * 20
                    });
                    SliderInput("SliderVector2", {
                        "ItemInnerSpacing",
                        nil,
                        Vector2.zero,
                        Vector2.one * 20
                    });
                    SliderInput("SliderVector2", {
                        "CellPadding",
                        nil,
                        Vector2.zero,
                        Vector2.one * 20
                    });
                    SliderInput("SliderNum", { "IndentSpacing", 1, 0, 36 });
                    SliderInput("SliderNum", { "ScrollbarSize", 1, 0, 20 });
                    SliderInput("SliderNum", { "GrabMinSize", 1, 0, 20 });
                    u1.SeparatorText({ "Borders & Rounding" });
                    SliderInput("SliderNum", { "FrameBorderSize", 0.1, 0, 1 });
                    SliderInput("SliderNum", { "WindowBorderSize", 0.1, 0, 1 });
                    SliderInput("SliderNum", { "PopupBorderSize", 0.1, 0, 1 });
                    SliderInput("SliderNum", { "SeparatorTextBorderSize", 1, 0, 20 });
                    SliderInput("SliderNum", { "FrameRounding", 1, 0, 12 });
                    SliderInput("SliderNum", { "GrabRounding", 1, 0, 12 });
                    SliderInput("SliderNum", { "PopupRounding", 1, 0, 12 });
                    u1.SeparatorText({ "Widgets" });
                    SliderInput("SliderVector2", {
                        "DisplaySafeAreaPadding",
                        nil,
                        Vector2.zero,
                        Vector2.one * 20
                    });
                    SliderInput("SliderVector2", {
                        "SeparatorTextPadding",
                        nil,
                        Vector2.zero,
                        Vector2.one * 36
                    });
                    SliderInput("SliderUDim", {
                        "ItemWidth",
                        nil,
                        UDim.new(),
                        UDim.new(1, 200)
                    });
                    SliderInput("SliderUDim", {
                        "ContentWidth",
                        nil,
                        UDim.new(),
                        UDim.new(1, 200)
                    });
                    SliderInput("SliderNum", { "ImageBorderSize", 1, 0, 12 });
                    local v80 = u1.ComboEnum({ "WindowTitleAlign" }, {
                        index = u1.WeakState(u1._config.WindowTitleAlign)
                    }, Enum.LeftRight);

                    if v80.closed() then
                        u74.value.WindowTitleAlign = v80.index:get();
                    end;

                    BooleanInput({ "RichText" });
                    BooleanInput({ "TextWrapped" });
                    u1.SeparatorText({ "Config" });
                    BooleanInput({ "UseScreenGUIs" });
                    SliderInput("DragNum", { "DisplayOrderOffset", 1, 0 });
                    SliderInput("DragNum", { "ZIndexOffset", 1, 0 });
                    SliderInput("SliderNum", { "MouseDoubleClickTime", 0.1, 0, 5 });
                    SliderInput("SliderNum", { "MouseDoubleClickMaxDist", 0.1, 0, 20 });
                end },
            { "Colors", function() -- Line: 813
                    -- upvalues: u1 (ref), helpMarker (ref)
                    local v81 = u1.State({});
                    u1.SameLine();

                    if u1.Button({ "Update" }).clicked() then
                        u1.UpdateGlobalConfig(v81.value);
                        v81:set({});
                    end;

                    helpMarker("Update the global config with these changes.");
                    u1.End();

                    for _, v in { "Text", "TextDisabled", "WindowBg", "PopupBg", "Border", "BorderActive", "ScrollbarGrab", "TitleBg", "TitleBgActive", "TitleBgCollapsed", "MenubarBg", "FrameBg", "FrameBgHovered", "FrameBgActive", "Button", "ButtonHovered", "ButtonActive", "Image", "SliderGrab", "SliderGrabActive", "Header", "HeaderHovered", "HeaderActive", "SelectionImageObject", "SelectionImageObjectBorder", "TableBorderStrong", "TableBorderLight", "TableRowBg", "TableRowBgAlt", "NavWindowingHighlight", "NavWindowingDimBg", "Separator", "CheckMark" } do
                        local v82 = u1.InputColor4({ v }, {
                            color = u1.WeakState(u1._config[v .. "Color"]),
                            transparency = u1.WeakState(u1._config[v .. "Transparency"])
                        });

                        if v82.numberChanged() then
                            v81.value[v .. "Color"] = v82.color:get();
                            v81.value[v .. "Transparency"] = v82.transparency:get();
                        end;
                    end;
                end },
            { "Fonts", function() -- Line: 876
                    -- upvalues: u1 (ref), helpMarker (ref)
                    local v83 = u1.State({});
                    u1.SameLine();

                    if u1.Button({ "Update" }).clicked() then
                        u1.UpdateGlobalConfig(v83.value);
                        v83:set({});
                    end;

                    helpMarker("Update the global config with these changes.");
                    u1.End();
                    local v84 = {
                        ["Code (default)"] = Font.fromEnum(Enum.Font.Code),
                        ["Ubuntu (template)"] = Font.fromEnum(Enum.Font.Ubuntu),
                        Arial = Font.fromEnum(Enum.Font.Arial),
                        Highway = Font.fromEnum(Enum.Font.Highway),
                        Roboto = Font.fromEnum(Enum.Font.Roboto),
                        ["Roboto Mono"] = Font.fromEnum(Enum.Font.RobotoMono),
                        ["Noto Sans"] = Font.new("rbxassetid://12187370747"),
                        ["Builder Sans"] = Font.fromEnum(Enum.Font.BuilderSans),
                        ["Builder Mono"] = Font.new("rbxassetid://16658246179"),
                        Sono = Font.new("rbxassetid://12187374537")
                    };
                    u1.Text({ (`Current Font: {u1._config.TextFont.Family} Weight: {u1._config.TextFont.Weight} Style: {u1._config.TextFont.Style}`) });
                    u1.SeparatorText({ "Size" });
                    local v85 = u1.SliderNum({ "Font Size", 1, 4, 20 }, {
                        number = u1.WeakState(u1._config.TextSize)
                    });

                    if v85.numberChanged() then
                        v83.value.TextSize = v85.state.number:get();
                    end;

                    u1.SeparatorText({ "Properties" });
                    local v86 = u1.WeakState(u1._config.TextFont.Family);
                    local v87 = u1.ComboEnum({ "Font Weight" }, {
                        index = u1.WeakState(u1._config.TextFont.Weight)
                    }, Enum.FontWeight);
                    local v88 = u1.ComboEnum({ "Font Style" }, {
                        index = u1.WeakState(u1._config.TextFont.Style)
                    }, Enum.FontStyle);
                    u1.SeparatorText({ "Fonts" });

                    for i, v in v84 do
                        local Font_new_ret = Font.new(v.Family, v87.state.index.value, v88.state.index.value);
                        u1.SameLine();
                        u1.PushConfig({
                            TextFont = Font_new_ret
                        });

                        if u1.Selectable({ `{i} | "The quick brown fox jumps over the lazy dog."`, Font_new_ret.Family }, {
                            index = v86
                        }).selected() then
                            v83.value.TextFont = Font_new_ret;
                        end;

                        u1.PopConfig();
                        u1.End();
                    end;
                end }
        };
        u1.Window({ "Style Editor" }, {
            isOpened = u5
        });
        u1.Text({ "Customize the look of Iris in realtime." });
        local v90 = u1.State("Dark Theme");

        if u1.ComboArray({ "Theme" }, {
            index = v90
        }, { "Dark Theme", "Light Theme" }).closed() then
            if v90.value == "Dark Theme" then
                u1.UpdateGlobalConfig(u1.TemplateConfig.colorDark);
            elseif v90.value == "Light Theme" then
                u1.UpdateGlobalConfig(u1.TemplateConfig.colorLight);
            end;
        end;

        local v91 = u1.State("Classic Size");

        if u1.ComboArray({ "Size" }, {
            index = v91
        }, { "Classic Size", "Larger Size" }).closed() then
            if v91.value == "Classic Size" then
                u1.UpdateGlobalConfig(u1.TemplateConfig.sizeDefault);
            elseif v91.value == "Larger Size" then
                u1.UpdateGlobalConfig(u1.TemplateConfig.sizeClear);
            end;
        end;

        u1.SameLine();

        if u1.Button({ "Revert" }).clicked() then
            u1.UpdateGlobalConfig(u1.TemplateConfig.colorDark);
            u1.UpdateGlobalConfig(u1.TemplateConfig.sizeDefault);
        end;

        helpMarker("Reset Iris to the default theme and size.");
        u1.End();
        u1.SameLine();

        for i, v in ipairs(v89) do
            u1.RadioButton({ v[1], i }, {
                index = v73
            });
        end;

        u1.End();
        u1.Separator();
        v89[v73:get()][2]();
        u1.End();
    end;

    local function widgetEventInteractivity() -- Line: 986
        -- upvalues: u1 (copy)
        u1.CollapsingHeader({ "Widget Event Interactivity" });
        local v93 = u1.State(0);

        if u1.Button({ "Click to increase Number" }).clicked() then
            v93:set(v93:get() + 1);
        end;

        u1.Text({ "The Number is: " .. v93:get() });
        u1.Separator();
        local v94 = u1.State(false);
        local v95 = u1.State("clicked");
        u1.SameLine();
        u1.RadioButton({ "clicked", "clicked" }, {
            index = v95
        });
        u1.RadioButton({ "rightClicked", "rightClicked" }, {
            index = v95
        });
        u1.RadioButton({ "doubleClicked", "doubleClicked" }, {
            index = v95
        });
        u1.RadioButton({ "ctrlClicked", "ctrlClicked" }, {
            index = v95
        });
        u1.End();
        u1.SameLine();

        if u1.Button({ v95:get() .. " to reveal text" })[v95:get()]() then
            v94:set(not v94:get());
        end;

        if v94:get() then
            u1.Text({ "Here i am!" });
        end;

        u1.End();
        u1.Separator();
        local v96 = u1.State(0);
        u1.SameLine();

        if u1.Button({ "Click to show text for 20 frames" }).clicked() then
            v96:set(20);
        end;

        if v96:get() > 0 then
            u1.Text({ "Here i am!" });
        end;

        u1.End();
        local v97 = v96:get() - 1;
        v96:set((math.max(0, v97)));
        u1.Text({ "Text Timer: " .. v96:get() });
        local v98 = u1.Checkbox({ "Event-tracked checkbox" });
        u1.Indent();
        u1.Text({ "unchecked: " .. tostring(v98.unchecked()) });
        u1.Text({ "checked: " .. tostring(v98.checked()) });
        u1.End();
        u1.SameLine();

        if u1.Button({ "Hover over me" }).hovered() then
            u1.Text({ "The button is hovered" });
        end;

        u1.End();
        u1.End();
    end;

    local function widgetStateInteractivity() -- Line: 1056
        -- upvalues: u1 (copy)
        u1.CollapsingHeader({ "Widget State Interactivity" });
        local v99 = u1.Checkbox({ "Widget-Generated State" });
        u1.Text({ (`isChecked: {v99.state.isChecked.value}\n`) });
        local v100 = u1.State(false);
        local v101 = u1.Checkbox({ "User-Generated State" }, {
            isChecked = v100
        });
        u1.Text({ (`isChecked: {v101.state.isChecked.value}\n`) });
        local v102 = u1.Checkbox({ "Widget Coupled State" });
        local v103 = u1.Checkbox({ "Coupled to above Checkbox" }, {
            isChecked = v102.state.isChecked
        });
        u1.Text({ (`isChecked: {v103.state.isChecked.value}\n`) });
        local v104 = u1.State(false);
        u1.Checkbox({ "Widget and Code Coupled State" }, {
            isChecked = v104
        });

        if u1.Button({ "Click to toggle above checkbox" }).clicked() then
            v104:set(not v104:get());
        end;

        u1.Text({ (`isChecked: {v104.value}\n`) });
        local v105 = u1.State(true);
        local v107 = u1.ComputedState(v105, function(p106) -- Line: 1079
            return not p106;
        end);
        u1.Checkbox({ "ComputedState (dynamic coupling)" }, {
            isChecked = v105
        });
        u1.Checkbox({ "Inverted of above checkbox" }, {
            isChecked = v107
        });
        u1.Text({ (`isChecked: {v107.value}\n`) });
        u1.End();
    end;

    local function dynamicStyle() -- Line: 1089
        -- upvalues: u1 (copy), helpMarker (copy)
        u1.CollapsingHeader({ "Dynamic Styles" });
        local v108 = u1.State(0);
        u1.SameLine();

        if u1.Button({ "Change Color" }).clicked() then
            v108:set(math.random());
        end;

        local Text = u1.Text;
        local v109 = {};
        local v110 = v108:get() * 255;
        v109[1] = "Hue: " .. math.floor(v110);
        Text(v109);
        helpMarker("Using PushConfig with a changing value, this can be done with any config field");
        u1.End();
        u1.PushConfig({
            TextColor = Color3.fromHSV(v108:get(), 1, 1)
        });
        u1.Text({ "Text with a unique and changable color" });
        u1.PopConfig();
        u1.End();
    end;

    local function tablesDemo() -- Line: 1110
        -- upvalues: u1 (copy), helpMarker (copy)
        local v111 = u1.State(false);
        u1.CollapsingHeader({ "Tables & Columns" }, {
            isUncollapsed = v111
        });

        if v111.value == false then
            u1.End();

            return;
        end;

        u1.SameLine();
        u1.Text({ "Table using NextRow and NextColumn syntax:" });
        helpMarker("calling Iris.NextRow() in the outer loop, and Iris.NextColumn()in the inner loop");
        u1.End();
        u1.Table({ 3 });

        for i = 1, 4 do
            u1.NextRow();
            local v112 = i;

            for i2 = 1, 3 do
                u1.NextColumn();
                u1.Text({ (`Row: {v112}, Column: {i2}`) });
                local _ = i2;
            end;
        end;

        u1.End();
        u1.Text({ "" });
        u1.SameLine();
        u1.Text({ "Table using NextColumn only syntax:" });
        helpMarker("only calling Iris.NextColumn() in the inner loop, the result is identical");
        u1.End();
        u1.Table({ 2 });

        for i = 1, 4 do
            local v113 = i;

            for i2 = 1, 2 do
                u1.NextColumn();
                u1.Text({ (`Row: {v113}, Column: {i2}`) });
                local _ = i2;
            end;
        end;

        u1.End();
        u1.Separator();
        local v114 = u1.State(false);
        local v115 = u1.State(false);
        local v116 = u1.State(true);
        local v117 = u1.State(true);
        local v118 = u1.State(3);
        u1.Text({ "Table with Customizable Arguments" });
        u1.Table({
            [u1.Args.Table.NumColumns] = 4,
            [u1.Args.Table.RowBg] = v114.value,
            [u1.Args.Table.BordersOuter] = v115.value,
            [u1.Args.Table.BordersInner] = v116.value
        });

        for i = 1, v118:get() do
            local v119 = i;

            for i2 = 1, 4 do
                u1.NextColumn();
                local v120;

                if v117.value then
                    u1.Button({ (`Month: {v119}, Week: {i2}`) });
                    v120 = i2;
                else
                    u1.Text({ (`Month: {v119}, Week: {i2}`) });
                    v120 = i2;
                end;
            end;
        end;

        u1.End();
        u1.Checkbox({ "RowBg" }, {
            isChecked = v114
        });
        u1.Checkbox({ "BordersOuter" }, {
            isChecked = v115
        });
        u1.Checkbox({ "BordersInner" }, {
            isChecked = v116
        });
        u1.SameLine();
        u1.RadioButton({ "Buttons", true }, {
            index = v117
        });
        u1.RadioButton({ "Text", false }, {
            index = v117
        });
        u1.End();
        u1.InputNum({
            [u1.Args.InputNum.Text] = "Number of rows",
            [u1.Args.InputNum.Min] = 0,
            [u1.Args.InputNum.Max] = 100,
            [u1.Args.InputNum.Format] = "%d"
        }, {
            number = v118
        });
        u1.End();
    end;

    local function layoutDemo() -- Line: 1210
        -- upvalues: u1 (copy), helpMarker (copy)
        u1.CollapsingHeader({ "Widget Layout" });
        u1.Tree({ "Content Width" });
        local v121 = u1.State(50);
        local v122 = u1.State(Enum.Axis.X);
        u1.Text({ "The Content Width is a size property which determines the width of input fields." });
        u1.SameLine();
        u1.Text({ "By default the value is UDim.new(0.65, 0)" });
        helpMarker("This is the default value from Dear ImGui.\nIt is 65% of the window width.");
        u1.End();
        u1.Text({ "This works well, but sometimes we know how wide elements are going to be and want to maximise the space." });
        u1.Text({ "Therefore, we can use Iris.PushConfig() to change the width" });
        u1.Separator();
        u1.SameLine();
        u1.Text({ "Content Width = 150 pixels" });
        helpMarker("UDim.new(0, 150)");
        u1.End();
        u1.PushConfig({
            ContentWidth = UDim.new(0, 150)
        });
        u1.DragNum({ "number", 1, 0, 100 }, {
            number = v121
        });
        u1.ComboEnum({ "axis" }, {
            index = v122
        }, Enum.Axis);
        u1.PopConfig();
        u1.SameLine();
        u1.Text({ "Content Width = 50% window width" });
        helpMarker("UDim.new(0.5, 0)");
        u1.End();
        u1.PushConfig({
            ContentWidth = UDim.new(0.5, 0)
        });
        u1.DragNum({ "number", 1, 0, 100 }, {
            number = v121
        });
        u1.ComboEnum({ "axis" }, {
            index = v122
        }, Enum.Axis);
        u1.PopConfig();
        u1.SameLine();
        u1.Text({ "Content Width = -150 pixels from the right side" });
        helpMarker("UDim.new(1, -150)");
        u1.End();
        u1.PushConfig({
            ContentWidth = UDim.new(1, -150)
        });
        u1.DragNum({ "number", 1, 0, 100 }, {
            number = v121
        });
        u1.InputEnum({ "axis" }, {
            index = v122
        }, Enum.Axis);
        u1.PopConfig();
        u1.End();
        u1.Tree({ "Content Height" });
        local v123 = u1.State("a single line");
        local v124 = u1.State(50);
        local v125 = u1.State(Enum.Axis.X);
        local v126 = u1.State(0);
        local v127 = os.clock() * 15 % 100 - 50;
        local v128 = math.abs(v127) - 7.5;
        v126:set(math.clamp(v128, 0, 35) / 35);
        u1.Text({ "The Content Height is a size property that determines the minimum size of certain widgets." });
        u1.Text({ "By default the value is UDim.new(0, 0), so there is no minimum height." });
        u1.Text({ "We use Iris.PushConfig() to change this value." });
        u1.Separator();
        u1.SameLine();
        u1.Text({ "Content Height = 0 pixels" });
        helpMarker("UDim.new(0, 0)");
        u1.End();
        u1.InputText({ "text" }, {
            text = v123
        });
        u1.ProgressBar({ "progress" }, {
            progress = v126
        });
        u1.DragNum({ "number", 1, 0, 100 }, {
            number = v124
        });
        u1.ComboEnum({ "axis" }, {
            index = v125
        }, Enum.Axis);
        u1.SameLine();
        u1.Text({ "Content Height = 60 pixels" });
        helpMarker("UDim.new(0, 60)");
        u1.End();
        u1.PushConfig({
            ContentHeight = UDim.new(0, 60)
        });
        u1.InputText({ "text", nil, nil, true }, {
            text = v123
        });
        u1.ProgressBar({ "progress" }, {
            progress = v126
        });
        u1.DragNum({ "number", 1, 0, 100 }, {
            number = v124
        });
        u1.ComboEnum({ "axis" }, {
            index = v125
        }, Enum.Axis);
        u1.PopConfig();
        u1.Text({ "This property can be used to force the height of a text box." });
        u1.Text({ "Just make sure you enable the MultiLine argument." });
        u1.End();
        u1.End();
    end;

    local function windowlessDemo() -- Line: 1320
        -- upvalues: u1 (copy), helpMarker (copy)
        u1.PushConfig({
            ItemWidth = UDim.new(0, 150)
        });
        u1.SameLine();
        u1.TextWrapped({ "Windowless widgets" });
        helpMarker("Widgets which are placed outside of a window will appear on the top left side of the screen.");
        u1.End();
        u1.Button({});
        u1.Tree({});
        u1.InputText({});
        u1.End();
        u1.PopConfig();
    end;

    return function() -- Line: 1340
        -- upvalues: u1 (copy), u2 (copy), mainMenuBar (copy), widgetEventInteractivity (copy), widgetStateInteractivity (copy), recursiveTree (copy), dynamicStyle (copy), u60 (copy), u59 (copy), tablesDemo (copy), layoutDemo (copy), u3 (copy), recursiveWindow (copy), u4 (copy), runtimeInfo (copy), u8 (copy), debugPanel (copy), u5 (copy), u92 (ref), u6 (copy), windowlessDemo (copy), u7 (copy)
        local v129 = u1.State(false);
        local v130 = u1.State(false);
        local v131 = u1.State(false);
        local v132 = u1.State(true);
        local v133 = u1.State(false);
        local v134 = u1.State(false);
        local v135 = u1.State(false);
        local v136 = u1.State(false);
        local v137 = u1.State(false);

        if u2.value ~= false then
            debug.profilebegin("Iris/Demo/Window");
            local v138 = u1.Window({
                [u1.Args.Window.Title] = "Iris Demo Window",
                [u1.Args.Window.NoTitleBar] = v129.value,
                [u1.Args.Window.NoBackground] = v130.value,
                [u1.Args.Window.NoCollapse] = v131.value,
                [u1.Args.Window.NoClose] = v132.value,
                [u1.Args.Window.NoMove] = v133.value,
                [u1.Args.Window.NoScrollbar] = v134.value,
                [u1.Args.Window.NoResize] = v135.value,
                [u1.Args.Window.NoNav] = v136.value,
                [u1.Args.Window.NoMenu] = v137.value
            }, {
                size = u1.State(Vector2.new(600, 550)),
                position = u1.State(Vector2.new(100, 25)),
                isOpened = u2
            });

            if v138.state.isUncollapsed.value and v138.state.isOpened.value then
                debug.profilebegin("Iris/Demo/MenuBar");
                mainMenuBar();
                debug.profileend();
                u1.Text({ "Iris says hello. (" .. u1.Internal._version .. ")" });
                debug.profilebegin("Iris/Demo/Options");
                u1.CollapsingHeader({ "Window Options" });
                u1.Table({ 3, false, false, false });
                u1.NextColumn();
                u1.Checkbox({ "NoTitleBar" }, {
                    isChecked = v129
                });
                u1.NextColumn();
                u1.Checkbox({ "NoBackground" }, {
                    isChecked = v130
                });
                u1.NextColumn();
                u1.Checkbox({ "NoCollapse" }, {
                    isChecked = v131
                });
                u1.NextColumn();
                u1.Checkbox({ "NoClose" }, {
                    isChecked = v132
                });
                u1.NextColumn();
                u1.Checkbox({ "NoMove" }, {
                    isChecked = v133
                });
                u1.NextColumn();
                u1.Checkbox({ "NoScrollbar" }, {
                    isChecked = v134
                });
                u1.NextColumn();
                u1.Checkbox({ "NoResize" }, {
                    isChecked = v135
                });
                u1.NextColumn();
                u1.Checkbox({ "NoNav" }, {
                    isChecked = v136
                });
                u1.NextColumn();
                u1.Checkbox({ "NoMenu" }, {
                    isChecked = v137
                });
                u1.End();
                u1.End();
                debug.profileend();
                debug.profilebegin("Iris/Demo/Events");
                widgetEventInteractivity();
                debug.profileend();
                debug.profilebegin("Iris/Demo/States");
                widgetStateInteractivity();
                debug.profileend();
                debug.profilebegin("Iris/Demo/Recursive");
                u1.CollapsingHeader({ "Recursive Tree" });

                if u1.Tree({ "Recursive Tree" }).state.isUncollapsed.value then
                    recursiveTree();
                end;

                u1.End();
                u1.End();
                debug.profileend();
                debug.profilebegin("Iris/Demo/Style");
                dynamicStyle();
                debug.profileend();
                u1.Separator();
                debug.profilebegin("Iris/Demo/Widgets");
                u1.CollapsingHeader({ "Widgets" });

                for _, v in u60 do
                    debug.profilebegin((`Iris/Demo/Widgets/{v}`));
                    u59[v]();
                    debug.profileend();
                end;

                u1.End();
                debug.profileend();
                debug.profilebegin("Iris/Demo/Tables");
                tablesDemo();
                debug.profileend();
                debug.profilebegin("Iris/Demo/Layout");
                layoutDemo();
                debug.profileend();
            end;

            u1.End();
            debug.profileend();

            if u3.value then
                recursiveWindow(u3);
            end;

            if u4.value then
                runtimeInfo();
            end;

            if u8.value then
                debugPanel();
            end;

            if u5.value then
                u92();
            end;

            if u6.value then
                windowlessDemo();
            end;

            if u7.value then
                mainMenuBar();
            end;

            return v138;
        end;

        u1.Checkbox({ "Open main window" }, {
            isChecked = u2
        });
    end;
end;