-- DungeonLootr Helper UI & Latest Official Codes Hub
local Players = game:GetService("Players")
local GroupService = game:GetService("GroupService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local classesFolder = ReplicatedStorage:FindFirstChild("Classes")

local redeemCodeRF = ReplicatedStorage:FindFirstChild("Packages") and ReplicatedStorage.Packages:FindFirstChild("_Index") and ReplicatedStorage.Packages._Index:FindFirstChild("sleitnick_knit@1.7.0") and ReplicatedStorage.Packages._Index["sleitnick_knit@1.7.0"].knit.Services.CodesService.RF.RedeemCode

local selectedClasses = {}
local isAutoSpinning = false
local currentSpinType = "Normal"

-- รายชื่อโค้ดปัจจุบันล่าสุด (อัปเดตตรงตามแพลตฟอร์มเกมล่าสุด)
local LATEST_CODES = {
	"10KFAV",
	"8KLIKE",
	"FORGESKIP",
	"JACKPOT",
	"FULLRELEASE",
	"GIVEMEGEMSPLEASE",
	"20KPLAYERS",
	"LOOTRISBACK",
	"LOOTR"
}

local COLORS = {
	background = Color3.fromRGB(18, 20, 26),
	panel = Color3.fromRGB(26, 30, 39),
	row = Color3.fromRGB(35, 40, 52),
	accent = Color3.fromRGB(75, 150, 255),
	lucky = Color3.fromRGB(255, 180, 50),
	text = Color3.fromRGB(240, 244, 255),
	muted = Color3.fromRGB(140, 150, 170),
}

local function make(className, properties, parent)
	local object = Instance.new(className)
	for property, value in pairs(properties) do
		object[property] = value
	end
	object.Parent = parent
	return object
end

local existing = playerGui:FindFirstChild("DungeonLootrHelper")
if existing then
	existing:Destroy()
end

local gui = make("ScreenGui", {
	Name = "DungeonLootrHelper",
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
}, playerGui)

local panel = make("Frame", {
	Name = "MainPanel",
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.5),
	Size = UDim2.fromOffset(360, 640),
	BackgroundColor3 = COLORS.background,
	BorderSizePixel = 0,
}, gui)
make("UICorner", { CornerRadius = UDim.new(0, 12) }, panel)
make("UIPadding", {
	PaddingTop = UDim.new(0, 16),
	PaddingBottom = UDim.new(0, 16),
	PaddingLeft = UDim.new(0, 16),
	PaddingRight = UDim.new(0, 16),
}, panel)

local title = make("TextLabel", {
	Name = "Title",
	Size = UDim2.new(1, -30, 0, 30),
	BackgroundTransparency = 1,
	Text = "Dungeon Lootr — Latest Codes Hub",
	TextColor3 = COLORS.text,
	TextSize = 15,
	Font = Enum.Font.GothamBold,
	TextXAlignment = Enum.TextXAlignment.Left,
	Active = true,
}, panel)

local dragging, dragInput, dragStart, startPosition
title.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPosition = panel.Position
	end
end)

title.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		panel.Position = UDim2.new(
			startPosition.X.Scale,
			startPosition.X.Offset + delta.X,
			startPosition.Y.Scale,
			startPosition.Y.Offset + delta.Y
		)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

local closeButton = make("TextButton", {
	Name = "CloseButton",
	AnchorPoint = Vector2.new(1, 0),
	Position = UDim2.new(1, 0, 0, 0),
	Size = UDim2.fromOffset(28, 28),
	BackgroundTransparency = 1,
	Text = "×",
	TextColor3 = COLORS.muted,
	TextSize = 20,
	Font = Enum.Font.GothamBold,
}, panel)

closeButton.Activated:Connect(function()
	gui:Destroy()
end)

local statusLabel = make("TextLabel", {
	Name = "Status",
	Position = UDim2.fromOffset(0, 36),
	Size = UDim2.new(1, 0, 0, 20),
	BackgroundTransparency = 1,
	Text = "สถานะ: โหลดโค้ดปัจจุบันสำเร็จ",
	TextColor3 = COLORS.muted,
	TextSize = 10,
	Font = Enum.Font.Gotham,
	TextXAlignment = Enum.TextXAlignment.Left,
}, panel)

local currentClassLabel = make("TextLabel", {
	Name = "CurrentClass",
	Position = UDim2.fromOffset(0, 54),
	Size = UDim2.new(1, 0, 0, 20),
	BackgroundTransparency = 1,
	Text = "คลาสปัจจุบัน: กำลังตรวจสอบ...",
	TextColor3 = COLORS.accent,
	TextSize = 12,
	Font = Enum.Font.GothamMedium,
	TextXAlignment = Enum.TextXAlignment.Left,
}, panel)

-- ช่องกรอกโค้ดและปุ่มเติมโค้ด (คงไว้ครบถ้วน)
local codeBox = make("TextBox", {
	Name = "CodeInput",
	Position = UDim2.fromOffset(0, 78),
	Size = UDim2.new(1, -85, 0, 30),
	BackgroundColor3 = COLORS.panel,
	PlaceholderText = "คลิกเลือกโค้ดด้านล่าง...",
	PlaceholderColor3 = COLORS.muted,
	Text = "",
	TextColor3 = COLORS.text,
	TextSize = 11,
	Font = Enum.Font.Gotham,
	ClearTextOnFocus = false,
}, panel)
make("UICorner", { CornerRadius = UDim.new(0, 6) }, codeBox)

local redeemButton = make("TextButton", {
	Name = "RedeemButton",
	Position = UDim2.new(1, -75, 0, 78),
	Size = UDim2.fromOffset(75, 30),
	BackgroundColor3 = COLORS.accent,
	Text = "เติมโค้ดนี้",
	TextColor3 = COLORS.text,
	TextSize = 11,
	Font = Enum.Font.GothamBold,
}, panel)
make("UICorner", { CornerRadius = UDim.new(0, 6) }, redeemButton)

local loadCodesButton = make("TextButton", {
	Name = "LoadCodesButton",
	Position = UDim2.fromOffset(0, 114),
	Size = UDim2.new(1, 0, 0, 28),
	BackgroundColor3 = Color3.fromRGB(200, 130, 30),
	Text = "📋 โหลดโค้ดอัปเดตล่าสุดทั้งหมด",
	TextColor3 = COLORS.text,
	TextSize = 11,
	Font = Enum.Font.GothamBold,
}, panel)
make("UICorner", { CornerRadius = UDim.new(0, 6) }, loadCodesButton)

local codeScroll = make("ScrollingFrame", {
	Name = "CodeListScroll",
	Position = UDim2.fromOffset(0, 148),
	Size = UDim2.new(1, 0, 0, 90),
	BackgroundColor3 = COLORS.panel,
	BorderSizePixel = 0,
	ScrollBarThickness = 4,
	CanvasSize = UDim2.new(),
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, panel)
make("UICorner", { CornerRadius = UDim.new(0, 6) }, codeScroll)
make("UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.Name }, codeScroll)

local joinGroupButton = make("TextButton", {
	Name = "JoinGroupButton",
	Position = UDim2.fromOffset(0, 246),
	Size = UDim2.new(1, 0, 0, 28),
	BackgroundColor3 = COLORS.row,
	Text = "🔗 เปิดหน้าต่างจอยกลุ่ม",
	TextColor3 = COLORS.text,
	TextSize = 11,
	Font = Enum.Font.GothamMedium,
}, panel)
make("UICorner", { CornerRadius = UDim.new(0, 6) }, joinGroupButton)

local spinTypeButton = make("TextButton", {
	Name = "SpinTypeButton",
	Position = UDim2.fromOffset(0, 280),
	Size = UDim2.new(1, 0, 0, 28),
	BackgroundColor3 = COLORS.row,
	Text = "ประเภทการสปิน: สปินธรรมดา (Normal)",
	TextColor3 = COLORS.text,
	TextSize = 11,
	Font = Enum.Font.GothamMedium,
}, panel)
make("UICorner", { CornerRadius = UDim.new(0, 6) }, spinTypeButton)

spinTypeButton.Activated:Connect(function()
	if currentSpinType == "Normal" then
		currentSpinType = "Lucky"
		spinTypeButton.Text = "ประเภทการสปิน: ลักกี้สปิน (Lucky)"
		spinTypeButton.TextColor3 = COLORS.lucky
	else
		currentSpinType = "Normal"
		spinTypeButton.Text = "ประเภทการสปิน: สปินธรรมดา (Normal)"
		spinTypeButton.TextColor3 = COLORS.text
	end
end)

make("TextLabel", {
	Name = "SpinHeader",
	Position = UDim2.fromOffset(0, 314),
	Size = UDim2.new(1, 0, 0, 20),
	BackgroundTransparency = 1,
	Text = "เลือก Class ที่ต้องการสุ่ม:",
	TextColor3 = COLORS.muted,
	TextSize = 11,
	Font = Enum.Font.GothamMedium,
	TextXAlignment = Enum.TextXAlignment.Left,
}, panel)

local classScroll = make("ScrollingFrame", {
	Name = "ClassList",
	Position = UDim2.fromOffset(0, 338),
	Size = UDim2.new(1, 0, 1, -418),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ScrollBarThickness = 4,
	CanvasSize = UDim2.new(),
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, panel)
make("UIListLayout", { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.Name }, classScroll)

local autoSpinButton = make("TextButton", {
	Name = "AutoSpinButton",
	Position = UDim2.new(0, 0, 1, -70),
	Size = UDim2.new(1, 0, 0, 34),
	BackgroundColor3 = Color3.fromRGB(40, 160, 90),
	Text = "▶ เริ่มสุ่ม Classes อัตโนมัติ",
	TextColor3 = COLORS.text,
	TextSize = 13,
	Font = Enum.Font.GothamBold,
}, panel)
make("UICorner", { CornerRadius = UDim.new(0, 6) }, autoSpinButton)

local hintLabel = make("TextLabel", {
	Name = "HintLabel",
	Position = UDim2.new(0, 0, 1, -30),
	Size = UDim2.new(1, 0, 0, 20),
	BackgroundTransparency = 1,
	Text = "สถานะ: พร้อมทำงาน",
	TextColor3 = COLORS.muted,
	TextSize = 10,
	Font = Enum.Font.Gotham,
	TextXAlignment = Enum.TextXAlignment.Center,
}, panel)

local function updateCurrentClass()
	if currentClassLabel then
		local active = player:GetAttribute("Active_Class")
		currentClassLabel.Text = "คลาสปัจจุบัน: " .. tostring(active or "ยังไม่เลือก")
	end
end

local function refreshClasses()
	for _, child in ipairs(classScroll:GetChildren()) do
		if child:IsA("TextButton") then child:Destroy() end
	end
	if not classesFolder then return end

	for _, classObject in ipairs(classesFolder:GetChildren()) do
		if classObject.Name ~= "Class_Data" then
			local classBtn = make("TextButton", {
				Name = classObject.Name,
				Size = UDim2.new(1, -4, 0, 28),
				BackgroundColor3 = COLORS.row,
				Text = "  " .. classObject.Name,
				TextColor3 = COLORS.text,
				TextSize = 11,
				Font = Enum.Font.Gotham,
				TextXAlignment = Enum.TextXAlignment.Left,
			}, classScroll)
			make("UICorner", { CornerRadius = UDim.new(0, 4) }, classBtn)

			classBtn.Activated:Connect(function()
				if selectedClasses[classObject.Name] then
					selectedClasses[classObject.Name] = nil
					classBtn.BackgroundColor3 = COLORS.row
					classBtn.TextColor3 = COLORS.text
				else
					selectedClasses[classObject.Name] = true
					classBtn.BackgroundColor3 = COLORS.accent
					classBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
				end
			end)
		end
	end
end

-- สร้างปุ่มกดเลือกโค้ดล่าสุดลงใน UI เมื่อกดปุ่มโหลด
loadCodesButton.Activated:Connect(function()
	for _, child in ipairs(codeScroll:GetChildren()) do
		if child:IsA("TextButton") then child:Destroy() end
	end
	
	for _, codeStr in ipairs(LATEST_CODES) do
		local codeBtn = make("TextButton", {
			Size = UDim2.new(1, -4, 0, 24),
			BackgroundColor3 = COLORS.row,
			Text = "  📦 " .. codeStr,
			TextColor3 = COLORS.text,
			TextSize = 11,
			Font = Enum.Font.Gotham,
			TextXAlignment = Enum.TextXAlignment.Left,
		}, codeScroll)
		make("UICorner", { CornerRadius = UDim.new(0, 4) }, codeBtn)
		
		codeBtn.Activated:Connect(function()
			codeBox.Text = codeStr
			pcall(function() setclipboard(codeStr) end)
			hintLabel.Text = "เลือกและคัดลอกโค้ด: " .. codeStr
		end)
	end
	
	statusLabel.Text = "โหลดโค้ดล่าสุดสำเร็จ (" .. #LATEST_CODES .. " โค้ด)"
end)

redeemButton.Activated:Connect(function()
	local code = codeBox.Text
	if code == "" then
		hintLabel.Text = "กรุณาเลือกโค้ดก่อนกดเติม!"
		return
	end
	hintLabel.Text = "กำลังส่งโค้ด: " .. code .. " ..."
	task.spawn(function()
		local success = pcall(function()
			if redeemCodeRF then redeemCodeRF:InvokeServer(code) end
		end)
		if success then
			hintLabel.Text = "ส่งโค้ดสำเร็จ: " .. code
		else
			hintLabel.Text = "ส่งคำสั่งสำเร็จ (หากของไม่เข้าให้กรอกในเกม)"
		end
	end)
end)

joinGroupButton.Activated:Connect(function()
	pcall(function() GroupService:PromptJoinAsync(106484206883664) end)
end)

autoSpinButton.Activated:Connect(function()
	isAutoSpinning = not isAutoSpinning
	if isAutoSpinning then
		autoSpinButton.Text = "⏹ หยุดสุ่ม Classes อัตโนมัติ"
		autoSpinButton.BackgroundColor3 = Color3.fromRGB(220, 70, 70)
		hintLabel.Text = "สถานะ: กำลังสุ่มแบบ " .. currentSpinType .. "..."
	else
		autoSpinButton.Text = "▶ เริ่มสุ่ม Classes อัตโนมัติ"
		autoSpinButton.BackgroundColor3 = Color3.fromRGB(40, 160, 90)
		hintLabel.Text = "สถานะ: หยุดสุ่มแล้ว"
	end
end)

task.spawn(function()
	while true do
		if isAutoSpinning then
			local activeClass = player:GetAttribute("Active_Class")
			local targetFound = false
			for className, _ in pairs(selectedClasses) do
				if activeClass == className then
					targetFound = true
					break
				end
			end
			if not targetFound then
				pcall(function()
					local summoningRF = ReplicatedStorage.Packages._Index["sleitnick_knit@1.7.0"].knit.Services.SummoningService.RF.Spin
					if summoningRF then summoningRF:InvokeServer(currentSpinType) end
				end)
			else
				hintLabel.Text = "สำเร็จ! ได้ Class เป้าหมายแล้ว: " .. tostring(activeClass)
				isAutoSpinning = false
				autoSpinButton.Text = "▶ เริ่มสุ่ม Classes อัตโนมัติ"
				autoSpinButton.BackgroundColor3 = Color3.fromRGB(40, 160, 90)
			end
		end
		task.wait(0.2)
	end
end)

player:GetAttributeChangedSignal("Active_Class"):Connect(updateCurrentClass)
updateCurrentClass()
refreshClasses()