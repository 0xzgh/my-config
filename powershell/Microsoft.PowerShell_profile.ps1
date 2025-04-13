
Set-Alias open explorer
Set-Alias grep rg
Set-Alias notepad "D:\Notepad3_6.23.203.2_x64_Portable\Notepad3.exe"

Invoke-Expression (& { (zoxide init powershell | Out-String) })
Invoke-Expression (&starship init powershell)



Set-Alias mysql "E:\Programs\MySQL\MySQL Server 8.0\bin\mysql.exe"
# 通用函数，接收驱动器字母作为参数
function Go-Drive {
    param (
        [string]$driveLetter
    )
    Set-Location "${driveLetter}:\"
}

# 使用函数来创建别名，导航到不同的驱动器
function c { Go-Drive "C" }
function d { Go-Drive "D" }
function e { Go-Drive "E" }

Function ipy {python -m IPython}
# Get process by port
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
# Get process by PID
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
function extract{
	C:\Users\15924\Downloads\Compressed\RePKG\RePKG.exe extract scene.pkg
}
# New File
function touch {New-Item "$args" -ItemType File}
# Terminal proxy
function setproxy {
$env:HTTP_PROXY="http://127.0.0.1:7897"
$env:HTTPS_PROXY="http://127.0.0.1:7897"

}
# Show proxy info
function showproxy {netsh winhttp show proxy}


# 更改默认ls行为，网格展示文件
Remove-Alias -Name ls
Set-Alias ls lsd




# 设置自动补全
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadlineOption -Color @{
    "ContinuationPrompt" = "`e[90m"     # Bright black
    "Emphasis" = '#14fc97'              # Yellow
    "Error" = "`e[31m"                  # Red
    "Selection" = "`e[100m"             # Bright black background
    "Default" = "`e[37m"                # White
    "Comment" = "`e[3;90m"              # Bright black italics
    "Keyword" = "`e[31m"                # Red
    "String" = "`e[33m"                 # Yellow
    "Operator" = "`e[31m"               # Red
    "Variable" = "`e[36m"               # Cyan
    #"Command" = "`e[38;2;219;112;147m"            # Gneen
    "Command" = "`e[38;2;219;112;147;1m"            # Gneen
    #"Command" = "e[1m"            # Gneen
    #"Parameter" = "`e[34;4m"              # Red
    "Parameter" = "`e[38;2;135;236;175;4m"             # Red
    "Type" = "`e[36m"                   # Cyan
    "Number" = "`e[35m"                 # Magenta
    "Member" = "`e[37m"                 # White
    "InlinePrediction" = '#757679'       # Bright black
}


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

