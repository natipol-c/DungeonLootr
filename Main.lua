-- Main.lua
-- Safe, server-authorized helper UI for Roblox Studio.
-- Place this file as a LocalScript under StarterPlayerScripts.
-- It never fires private remotes, changes class ownership, bypasses travel,
-- auto-accepts group membership, or redeems codes without user confirmation.

local Players = game:GetService("Players")
local GroupService = game:GetService("GroupService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local classesFolder = ReplicatedStorage:FindFirstChild("Classes")
local selectedClasses = {}

local COLORS = {
	background = Color3.fromRGB(24, 27, 34),
	panel = Color3.fromRGB(34, 38, 48),
	row = Color3.fromRGB(45, 50, 63),
	accent = Color3.fromRGB(95, 170, 255),
	text = Color3.fromRGB(235, 239, 247),
	muted = Color3.fromRGB(165, 175, 193),
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
	Name = "ClassBrowser",
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.5),
	Size = UDim2.fromOffset(300, 430),
	BackgroundColor3 = COLORS.background,
	BorderSizePixel = 0,
}, gui)
make("UICorner", { CornerRadius = UDim.new(0, 10) }, panel)
make("UIPadding", {
	PaddingTop = UDim.new(0, 14),
	PaddingBottom = UDim.new(0, 14),
	PaddingLeft = UDim.new(0, 14),
	PaddingRight = UDim.new(0, 14),
}, panel)

local title = make("TextLabel", {
	Name = "Title",
	Size = UDim2.new(1, 0, 0, 28),
	BackgroundTransparency = 1,
	Text = "Dungeon Lootr — ข้อมูลสด",
	TextColor3 = COLORS.text,
	TextSize = 18,
	Font = Enum.Font.GothamBold,
	TextXAlignment = Enum.TextXAlignment.Left,
	Active = true,
}, panel)

local closeButton = make("TextButton", {
	Name = "CloseButton",
	AnchorPoint = Vector2.new(1, 0),
	Position = UDim2.new(1, 0, 0, 0),
	Size = UDim2.fromOffset(28, 28),
	BackgroundTransparency = 1,
	Text = "×",
	TextColor3 = COLORS.muted,
	TextSize = 22,
	Font = Enum.Font.GothamBold,
	ZIndex = 2,
}, panel)

local dragging = false
local dragInput
local dragStart
local startPosition

local function updateDrag(input)
	local delta = input.Position - dragStart
	panel.Position = UDim2.new(
		startPosition.X.Scale,
		startPosition.X.Offset + delta.X,
		startPosition.Y.Scale,
		startPosition.Y.Offset + delta.Y
	)
end

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
		updateDrag(input)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

closeButton.Activated:Connect(function()
	gui:Destroy()
end)

local status = make("TextLabel", {
	Name = "Status",
	Position = UDim2.fromOffset(0, 34),
	Size = UDim2.new(1, 0, 0, 22),
	BackgroundTransparency = 1,
	Text = "กำลังอ่านข้อมูล...",
	TextColor3 = COLORS.muted,
	TextSize = 12,
	Font = Enum.Font.Gotham,
	TextXAlignment = Enum.TextXAlignment.Left,
}, panel)

local currentClass = make("TextLabel", {
	Name = "CurrentClass",
	Position = UDim2.fromOffset(0, 58),
	Size = UDim2.new(1, 0, 0, 22),
	BackgroundTransparency = 1,
	TextColor3 = COLORS.accent,
	TextSize = 13,
	Font = Enum.Font.GothamMedium,
	TextXAlignment = Enum.TextXAlignment.Left,
}, panel)

local codeBox = make("TextBox", {
	Name = "CodeInput",
	Position = UDim2.fromOffset(0, 88),
	Size = UDim2.new(1, 0, 0, 34),
	BackgroundColor3 = COLORS.panel,
	PlaceholderText = "กรอกโค้ดเพื่อเติมลงช่องเกม",
	PlaceholderColor3 = COLORS.muted,
	Text = "",
	TextColor3 = COLORS.text,
	TextSize = 13,
	Font = Enum.Font.Gotham,
	ClearTextOnFocus = false,
}, panel)
make("UICorner", { CornerRadius = UDim.new(0, 6) }, codeBox)

local codeHint = make("TextLabel", {
	Name = "CodeHint",
	Position = UDim2.fromOffset(0, 124),
	Size = UDim2.new(1, 0, 0, 26),
	BackgroundTransparency = 1,
	Text = "ไม่มีรายการโค้ดสาธารณะในข้อมูลที่โหลดมา",
	TextColor3 = COLORS.muted,
	TextSize = 11,
	Font = Enum.Font.Gotham,
	TextXAlignment = Enum.TextXAlignment.Left,
}, panel)

local list = make("ScrollingFrame", {
	Name = "ClassList",
	Position = UDim2.fromOffset(0, 158),
	Size = UDim2.new(1, 0, 1, -202),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ScrollBarThickness = 4,
	CanvasSize = UDim2.new(),
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, panel)
make("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.Name }, list)

local joinButton = make("TextButton", {
	Name = "JoinGroup",
	Position = UDim2.new(0, 0, 1, -34),
	Size = UDim2.new(1, 0, 0, 30),
	BackgroundColor3 = COLORS.row,
	Text = "ขอเข้ากลุ่ม (ต้องยืนยันเอง)",
	TextColor3 = COLORS.text,
	TextSize = 12,
	Font = Enum.Font.GothamMedium,
}, panel)
make("UICorner", { CornerRadius = UDim.new(0, 6) }, joinButton)

local function updateCurrentClass()
	local active = player:GetAttribute("Active_Class")
	currentClass.Text = "คลาสปัจจุบัน: " .. (active or "ยังไม่เลือก")
end

local function clearRows()
	for _, child in ipairs(list:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end
end

local function updateSelectionText()
	local selected = {}
	for className in pairs(selectedClasses) do
		table.insert(selected, className)
	end
	table.sort(selected)
	codeHint.Text = #selected == 0
		and "คลิกคลาสเพื่อเลือก (เลือกไว้เพื่อดูข้อมูลเท่านั้น)"
		or "เลือกแล้ว: " .. table.concat(selected, ", ")
end

local function refreshClasses()
	clearRows()
	if not classesFolder then
		status.Text = "ไม่พบ ReplicatedStorage.Classes"
		return
	end

	local count = 0
	for _, classObject in ipairs(classesFolder:GetChildren()) do
		if classObject.Name ~= "Class_Data" then
			count += 1
			local row = make("TextButton", {
				Name = classObject.Name,
				Size = UDim2.new(1, -4, 0, 30),
				BackgroundColor3 = COLORS.row,
				Text = "  " .. classObject.Name,
				TextColor3 = COLORS.text,
				TextSize = 12,
				Font = Enum.Font.Gotham,
				TextXAlignment = Enum.TextXAlignment.Left,
			}, list)
			make("UICorner", { CornerRadius = UDim.new(0, 6) }, row)
			row.Activated:Connect(function()
				selectedClasses[classObject.Name] = not selectedClasses[classObject.Name] or nil
				row.TextColor3 = selectedClasses[classObject.Name] and COLORS.accent or COLORS.text
				updateSelectionText()
			end)
		end
	end
	status.Text = string.format("คลาสที่อ่านได้: %d • อัปเดตสด", count)
end

local function promptJoinGroup()
	local groupId = ReplicatedStorage:GetAttribute("DungeonLootrGroupId")
	if typeof(groupId) ~= "number" then
		codeHint.Text = "ผู้พัฒนาเกมยังไม่ได้ตั้ง DungeonLootrGroupId"
		return
	end
	local ok, result = pcall(function()
		return GroupService:PromptJoinAsync(groupId)
	end)
	if not ok then
		codeHint.Text = "เปิดหน้าขอเข้ากลุ่มไม่สำเร็จ"
	elseif result == Enum.GroupMembershipStatus.Joined or result == Enum.GroupMembershipStatus.AlreadyMember then
		codeHint.Text = "เข้ากลุ่มแล้ว"
	else
		codeHint.Text = "ยังไม่ได้เข้ากลุ่ม — การยืนยันเป็นของผู้ใช้"
	end
end

codeBox:GetPropertyChangedSignal("Text"):Connect(function()
	-- เติมข้อความเท่านั้น ไม่ส่งหรือแลกรหัสอัตโนมัติ
	codeHint.Text = codeBox.Text == "" and "กรอกโค้ดในช่องของเกมด้วยตนเองหลังตรวจสอบแล้ว" or "พร้อมคัดลอก: " .. codeBox.Text
end)
joinButton.Activated:Connect(promptJoinGroup)
player:GetAttributeChangedSignal("Active_Class"):Connect(updateCurrentClass)

if classesFolder then
	classesFolder.ChildAdded:Connect(refreshClasses)
	classesFolder.ChildRemoved:Connect(refreshClasses)
end

updateCurrentClass()
refreshClasses()
