local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Função para conceder todas as GamePasses automaticamente
local function grantAllGamePasses()
    -- A lista de IDs das GamePasses que você deseja que sejam "de graça"
    local gamePassIds = {12345678, 23456789, 34567890}  -- Coloque os IDs das GamePasses aqui

    -- Concedendo cada GamePass para o jogador
    for _, gamePassId in ipairs(gamePassIds) do
        local success, message = pcall(function()
            Player:HasGamePass(gamePassId)
        end)

        if success then
            print("O jogador já possui a GamePass: " .. gamePassId)
        else
            -- Simula a compra do GamePass
            local successGrant = pcall(function()
                Player:GrantGamePass(gamePassId)
            end)

            if successGrant then
                print("GamePass " .. gamePassId .. " concedida com sucesso para o jogador!")
            else
                print("Erro ao conceder a GamePass " .. gamePassId)
            end
        end
    end
end

-- Função para criar a GUI do Hub
local function createHubGui()
    -- Criando a Interface
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "HubGui"
    ScreenGui.Parent = Player:WaitForChild("PlayerGui")

    -- MainFrame (com transparência)
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0.4, 0, 0.5, 0)
    MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MainFrame.BackgroundTransparency = 0.5  -- Definindo 50% de transparência
    MainFrame.Visible = false
    MainFrame.Parent = ScreenGui

    -- OpenButton (botão para abrir)
    local OpenButton = Instance.new("TextButton")
    OpenButton.Text = "Abrir Hub"
    OpenButton.Size = UDim2.new(0.2, 0, 0.1, 0)
    OpenButton.Position = UDim2.new(0, 0, 0.9, 0)
    OpenButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Cor preta
    OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Cor do texto branca
    OpenButton.Parent = ScreenGui

    -- CloseButton (botão para fechar)
    local CloseButton = Instance.new("TextButton")
    CloseButton.Text = "Fechar"
    CloseButton.Size = UDim2.new(0.2, 0, 0.1, 0)
    CloseButton.Position = UDim2.new(0.8, 0, 0, 0)
    CloseButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Cor preta
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Cor do texto branca
    CloseButton.Parent = MainFrame

    -- Botão para ajustar a Velocidade
    local SpeedButton = Instance.new("TextButton")
    SpeedButton.Text = "Ajustar Velocidade"
    SpeedButton.Size = UDim2.new(0.4, 0, 0.1, 0)
    SpeedButton.Position = UDim2.new(0.3, 0, 0.2, 0)
    SpeedButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Cor preta
    SpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Cor do texto branca
    SpeedButton.Parent = MainFrame

    -- Botão para ajustar o Poder de Pulo
    local JumpPowerButton = Instance.new("TextButton")
    JumpPowerButton.Text = "Ajustar Pulo"
    JumpPowerButton.Size = UDim2.new(0.4, 0, 0.1, 0)
    JumpPowerButton.Position = UDim2.new(0.3, 0, 0.35, 0)
    JumpPowerButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Cor preta
    JumpPowerButton.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Cor do texto branca
    JumpPowerButton.Parent = MainFrame

    -- Botão para pegar todos os itens
    local PickUpButton = Instance.new("TextButton")
    PickUpButton.Text = "Pegar Todos os Itens"
    PickUpButton.Size = UDim2.new(0.4, 0, 0.1, 0)
    PickUpButton.Position = UDim2.new(0.3, 0, 0.5, 0)
    PickUpButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Cor preta
    PickUpButton.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Cor do texto branca
    PickUpButton.Parent = MainFrame

    -- Botão para conceder GamePasses
    local GamePassButton = Instance.new("TextButton")
    GamePassButton.Text = "Conceder GamePasses"
    GamePassButton.Size = UDim2.new(0.4, 0, 0.1, 0)
    GamePassButton.Position = UDim2.new(0.3, 0, 0.65, 0)
    GamePassButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Cor preta
    GamePassButton.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Cor do texto branca
    GamePassButton.Parent = MainFrame

    -- Função para ajustar a velocidade
    local function adjustSpeed()
        local input = Instance.new("TextBox")
        input.Size = UDim2.new(0.3, 0, 0.1, 0)
        input.Position = UDim2.new(0.35, 0, 0.5, 0)
        input.Text = tostring(speed)
        input.Parent = MainFrame

        -- Aguarda o usuário digitar o valor
        input.FocusLost:Connect(function()
            local newSpeed = tonumber(input.Text)
            if newSpeed then
                speed = newSpeed
                Player.Character:WaitForChild("Humanoid").WalkSpeed = speed
            end
            input:Destroy()
        end)

        input:CaptureFocus()
    end

    -- Função para ajustar o poder de pulo
    local function adjustJumpPower()
        local input = Instance.new("TextBox")
        input.Size = UDim2.new(0.3, 0, 0.1, 0)
        input.Position = UDim2.new(0.35, 0, 0.65, 0)
        input.Text = tostring(jumpPower)
        input.Parent = MainFrame

        -- Aguarda o usuário digitar o valor
        input.FocusLost:Connect(function()
            local newJumpPower = tonumber(input.Text)
            if newJumpPower then
                jumpPower = newJumpPower
                Player.Character:WaitForChild("Humanoid").JumpPower = jumpPower
            end
            input:Destroy()
        end)

        input:CaptureFocus()
    end

    -- Ação dos Botões
    OpenButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = true
        OpenButton.Visible = false
    end)

    CloseButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
        OpenButton.Visible = true
    end)

    SpeedButton.MouseButton1Click:Connect(adjustSpeed)
    JumpPowerButton.MouseButton1Click:Connect(adjustJumpPower)
    PickUpButton.MouseButton1Click:Connect(pickUpAllItems)
    GamePassButton.MouseButton1Click:Connect(grantAllGamePasses)

    -- Configurações iniciais de velocidade e pulo
    local humanoid = Player.Character:WaitForChild("Humanoid")
    humanoid.WalkSpeed = speed
    humanoid.JumpPower = jumpPower
end

-- Quando o jogador morrer, recria o Hub
Player.CharacterAdded:Connect(function()
    -- Aguarda a criação do personagem e recria o Hub
    wait(1)  -- Aguarda um momento após o personagem ser criado
    createHubGui()
end)

-- Cria o Hub imediatamente quando o jogo começa
createHubGui()
