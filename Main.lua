-- DungeonLootr Helper UI & Auto-Redeem All Codes (Fixed Version)
local Players = game:GetService("Players")
local GroupService = game:GetService("GroupService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local classesFolder = ReplicatedStorage:FindFirstChild("Classes")

-- ดึงข้อมูลผ่าน Knit Framework และ Services
local packages = ReplicatedStorage:WaitForChild("Packages")
local knitPkg = packages:WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit")
local Knit = require(knitPkg:WaitForChild("KnitClient"))

local CodesService = Knit.GetService("CodesService")
local SummoningService = Knit.GetService("SummoningService")

local selectedClasses = {}
local isAutoSpinning = false
local isAutoJoining = false
local currentSpinType = "Normal"

local GAME_CODES = {
	"RELEASE",
	"DUNGEON",
	"LOOTR",
	"UPDATE1",
	"SORRYFORBUGS",
	"10KLIKES"
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
	Size = UDim2.fromOffset(360, 600),
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
	Text = "Dungeon Lootr — Helper Hub",
	TextColor3 = COLORS.text,
	TextSize = 16,
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
	Text = "สถานะ: พร้อมใช้งาน",
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

local redeemAllButton = make("TextButton", {
	Name = "RedeemAllButton",
	Position = UDim2.fromOffset(0, 80),
	Size = UDim2.new(1, 0, 0, 32),
	BackgroundColor3 = Color3.fromRGB(200, 130, 30),
	Text = "🎁 กดรับโค้ดทั้งหมดอัตโนมัติ",
	TextColor3 = COLORS.text,
	TextSize = 11, -- แก้ไขการส่งค่า TextSize ให้ถูกต้อง
	Font = Enum.Font.GothamBold,
}, panel)
make("UICorner", { CornerRadius = UDim.new(0, 6) }, redeemAllButton)

local joinGroupButton = make("TextButton", {
	Name = "JoinGroupButton",
	Position = UDim2.fromOffset(0, 122),
	Size = UDim2.new(1, 0, 0, 28),
	BackgroundColor3 = COLORS.row,
	Text = "🔗 ออโต้จอยกลุ่ม (Auto Join Group)",
	TextColor3 = COLORS.text,
	TextSize = 11,
	Font = Enum.Font.GothamMedium,
}, panel)
make("UICorner", { CornerRadius = UDim.new(0, 6) }, joinGroupButton)

local spinTypeButton = make("TextButton", {
	Name = "SpinTypeButton",
	Position = UDim2.fromOffset(0, 156),
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
	Position = UDim2.fromOffset(0, 192),
	Size = UDim2.new(1, 0, 0, 20),
	BackgroundTransparency = 1,
	Text = "เลือก Class ที่ต้องการสุ่ม (ไม่ต้องวาร์ป):",
	TextColor3 = COLORS.muted,
	TextSize = 11,
	Font = Enum.Font.GothamMedium,
	TextXAlignment = Enum.TextXAlignment.Left,
}, panel)

local classScroll = make("ScrollingFrame", {
	Name = "ClassList",
	Position = UDim2.fromOffset(0, 216),
	Size = UDim2.new(1, 0, 1, -296),
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
	local active = player:GetAttribute("Active_Class")
	currentClassLabel.Text = "คลาสปัจจุบัน: " .. tostring(active or "ยังไม่เลือก")
end

local function refreshClasses()
	for _, child in ipairs(classScroll:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
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

redeemAllButton.Activated:Connect(function()
	hintLabel.Text = "กำลังส่งโค้ดทั้งหมดเข้าระบบ..."
	task.spawn(function()
		for _, code in ipairs(GAME_CODES) do
			pcall(function()
				CodesService:RedeemCode(code)
			end)
			task.wait(0.3)
		end
		hintLabel.Text = "กดรับโค้ดทั้งหมดเสร็จสิ้นแล้ว!"
	end)
end)

joinGroupButton.Activated:Connect(function()
	if isAutoJoining then return end
	isAutoJoining = true
	joinGroupButton.Text = "กำลังเปิดหน้าต่างกลุ่ม..."

	pcall(function()
		local groupId = 106484206883664
		if CodesService.GetGroupId then
			groupId = CodesService:GetGroupId()
		end
		GroupService:PromptJoinAsync(groupId)
	end)

	task.wait(2)
	joinGroupButton.Text = "🔗 ออโต้จอยกลุ่ม (Auto Join Group)"
	isAutoJoining = false
end)

autoSpinButton.Activated:Connect(function()
	isAutoSpinning = not isAutoSpinning
	if isAutoSpinning then
		autoSpinButton.Text = "⏹ หยุดสุ่ม Classes อัตโนมัติ"
		autoSpinButton.BackgroundColor3 = Color3.fromRGB(220, 70, 70)
		hintLabel.Text = "สถานะ: กำลังสุ่มแบบ " .. currentSpinType .. "..."
	else
		autoSpinButton.Text = "▶ เริ่มสุ่ม Classes อัตโนมัติ"
		autoSpinButton.BackgroundColor3 = Color3.fromRGB(60, 200, 100)
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
					SummoningService:Spin(currentSpinType)
				end)
			else
				hintLabel.Text = "สำเร็จ! ได้ Class ที่เลือกไว้แล้ว: " .. tostring(activeClass)
				isAutoSpinning = false
				autoSpinButton.Text = "▶ เริ่มสุ่ม Classes อัตโนมัติ"
				autoSpinButton.BackgroundColor3 = Color3.fromRGB(60, 200, 100)
			end
		end
		task.wait(0.2)
	end
end)

player:GetAttributeChangedSignal("Active_Class"):Connect(updateCurrentClass)
updateCurrentClass()
refreshClasses()