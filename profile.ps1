New-Alias -Name n -Value nvim
Set-PSReadLineKeyHandler -Chord "Shift+Tab" -Function AcceptSuggestion
Set-PSReadLineKeyHandler -Chord "Ctrl+:" -Function ForwardWord
Set-PSReadLineKeyHandler -Key Tab -Function TabCompleteNext
Set-PSReadlineKeyHandler -Key Ctrl+p -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key Ctrl+n -Function HistorySearchForward

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\powerlevel10k_lean.omp.json" | Invoke-Expression
