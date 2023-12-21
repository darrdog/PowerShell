
Describe 'Work Log-Entry' {
    It 'Given a new entry PesterTester in work directory' {
        Log-Entry -EntryName PesterTester -EntryPath work
        Test-Path -Path "$env:USERPROFILE\Documents\Work_Log\$(get-date -f yyyy-MM-dd) PesterTester" | Should -Be True
    }
}

Describe 'Training Log-Entry' {
    It 'Given a new entry for PesterTester to the Train directory' {
        Log-Entry -EntryName PesterTester -EntryPath Train
        Test-Path -Path "$env:USERPROFILE\Documents\Training_log\$(get-date -f yyyy-MM-dd) PesterTester" | Should -Be True
    }
}

<#comment#>