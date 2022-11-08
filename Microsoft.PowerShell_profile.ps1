
Set-Alias notepad D:\Notepad2_zh-Hans_x64_v4.22.01r4056\Notepad2.exe
Set-Alias nc E:\Download\netcat-win32-1.12\nc64.exe
Set-Alias codex D:\Programs\VSCodeInsiders\bin\code-insiders.cmd
Set-Alias hugo D:\Programs\hugo_0.93.2_Windows-64bit\hugo.exe
Set-Alias nvim "D:\Programs\Neovim\bin\nvim.exe"
Set-Alias upx "D:\Programs\upx-3.96-win64\upx.exe"

Function ipy {python -m IPython}
# 查找端口进程
Function port{
	param(
	  [Parameter()]
      [Alias('Temp')]
      [int]
      $p
	)
	#netstat -ano|findstr $p
	Get-Process -Id (Get-NetTCPConnection -LocalPort $p).OwningProcess
	
}
# 查找进程pid
Function task{
	param(
	  [Parameter()]
      [Alias('Temp')]
      [int]
      $p
	)
	tasklist|findstr $p}
# git clone
function gcl {
	git clone --recursive $args
}
# 新建文件
function touch {New-Item "$args" -ItemType File}
# 终端代理
function setproxy {netsh winhttp set proxy "127.0.0.1:7890"}
# 检查代理
function showproxy {netsh winhttp show proxy}
# 编辑PowershellShell配置文件
function profile {
  notepad $profile
}
# 函数示例：温度转换
function 2C {
  param (
      [Parameter()]
      [Alias('Temp')]
      [int]
      $Temperature
  )

  ($Temperature - 30) / 2
}
# 命令行查词
function dict{
	param (
      [Parameter()]
      [Alias('Temp')]
      [String]
      $word
      )
      python E:\vscode-python\mdict-query\cmd.py $word	
}
function fact {
  irm -Uri https://uselessfacts.jsph.pl/random.json?language=en | Select -ExpandProperty text
}
# 随机joke
function joke {
  irm https://icanhazdadjoke.com/ -Headers @{accept = 'application/json'} | select -ExpandProperty joke
}

# 快速跳转zoxide配置
# For zoxide v0.8.0+
Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
})

# 更改默认ls行为，网格展示文件
Remove-Alias -Name ls
function ls {
	Get-ChildItem | Format-Wide
}

# 启用starship
Invoke-Expression (&starship init powershell)



#oh-my-posh init pwsh | Invoke-Expression
#& ([ScriptBlock]::Create((oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\aliens.omp.json" --print) -join "`n"))


# 导入图标
Import-Module -Name Terminal-Icons
# 设置自动补全
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
# 提示颜色
Set-PSReadLineOption -Colors @{ InlinePrediction = '#757679'}

# This custom binding makes `RightArrow` behave similarly - accepting the next word instead of the entire suggestion text.
Set-PSReadLineKeyHandler -Key RightArrow `
                         -BriefDescription ForwardCharAndAcceptNextSuggestionWord `
                         -LongDescription "Move cursor one character to the right in the current editing line and accept the next word in suggestion when it's at the end of current editing line" `
                         -ScriptBlock {
    param($key, $arg)

    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

    if ($cursor -lt $line.Length) {
        [Microsoft.PowerShell.PSConsoleReadLine]::ForwardChar($key, $arg)
    } else {
        [Microsoft.PowerShell.PSConsoleReadLine]::AcceptNextSuggestionWord($key, $arg)
    }
}

# This is an example of a macro that you might use to execute a command.
# This will add the command to history.
#Set-PSReadLineKeyHandler -Key Ctrl+b `
#                         -BriefDescription BuildCurrentDirectory `
#                         -LongDescription "Build the current directory" `
#                         -ScriptBlock {
#    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
#    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("msbuild")
#    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
#}

# Ctrl+RightArrow接受整条建议
Set-PSReadLineKeyHandler -Key Ctrl+RightArrow `
                         -BriefDescription ForwardCharAndAcceptNextSuggestionWord `
                         -LongDescription "accept line" `
                         -ScriptBlock {
    param($key, $arg)

    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptSuggestion()

    #if ($cursor -lt $line.Length) {
    #    [Microsoft.PowerShell.PSConsoleReadLine]::ForwardChar($key, $arg)
    #} else {
    #    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptNextSuggestionWord($key, $arg)
    #}
}
# Ctrl+LeftArrow删除该行
Set-PSReadLineKeyHandler -Key Ctrl+LeftArrow `
                         -BriefDescription ForwardCharAndAcceptNextSuggestionWord `
                         -LongDescription "accept line" `
                         -ScriptBlock {
    param($key, $arg)

    #$line = $null
    #$cursor = $null
    #[Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
}
#Set-PSReadlineOption -Color @{
#    "ContinuationPrompt" = "`e[90m"     # Bright black
#    "Emphasis" = "`e[33m"               # Yellow
#    "Error" = "`e[31m"                  # Red
#    "Selection" = "`e[100m"             # Bright black background
#    "Default" = "`e[37m"                # White
#    "Comment" = "`e[3;90m"              # Bright black italics
#    "Keyword" = "`e[31m"                # Red
#    "String" = "`e[33m"                 # Yellow
#    "Operator" = "`e[31m"               # Red
#    "Variable" = "`e[36m"               # Cyan
#    "Command" = "`e[32m"                # Gneen
#    "Parameter" = "`e[34m"              # Red
#    "Type" = "`e[36m"                   # Cyan
#    "Number" = "`e[35m"                 # Magenta
#    "Member" = "`e[37m"                 # White
#    "InlinePrediction" = "`e[90m"       # Bright black
#}

cls

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
