Clear-Host
###############################################################################################
# Variables
$Remote_repos_list = ("github-CGI-SEAL-Team-Bravo", "GIT--CGI-SEAL-Team-Bravo")
$Branch_Name = "LJ-Branch"
$Local_Repo_path = $env:SYSTEM_DEFAULTWORKINGDIRECTORY


##############################################################################################
# Set dafault local location for our Repository.
Set-Location -Path $Local_Repo_path | Out-Null

###############################################################################################
# Show local Rerpo path
Write-Host '
-----------------------------------------------------------------------------------------------
Local Repo path: ' -ForegroundColor  DarkMagenta
Get-Location

###############################################################################################
# List of remote repos in current workspace
Write-Host '
-----------------------------------------------------------------------------------------------
List of remote repos in current workspace: ' -ForegroundColor  DarkMagenta
git remote -v 

###############################################################################################
# Add to "push" potential any new files
git add . 

Write-Host '
----------------------------------------------------------------
Potentials new files were added to future commit. 
(by "git add .")' -ForegroundColor Green

###############################################################################################
# Get current date and time in specifivc format like: "2020-12-20--12:45--43"
$current_date = Get-Date -Format yyyy-MM-dd--hh-mm

Write-Host ('
----------------------------------------------------------------
Name of new commit: ' + $current_date + '
----------------------------------------------------------------') -ForegroundColor Cyan

git commit -am $current_date
Write-Host ('
----------------------------------------------------------------
New commit named ' + $current_date + ' was created.
(by "git commit -am ' + $current_date + ')') -ForegroundColor Cyan


###############################################################################################
# Push to all repos from list of $Remote_repos_list and branch $Branch_Name
foreach ($repo in $Remote_repos_list) {
    Write-Host ('
----------------------------------------------------------------
Repo name   : ' + $repo + '
Branch name : ' + $Branch_Name + '

Pushing new commit named ' + $current_date + ' to ' + $repo + '.
(by "git push ' + $repo + ' ' + $Branch_Name + ')') -ForegroundColor Yellow

    git push $repo $Branch_Name
}

###############################################################################################
# END
Write-Host '
-----------------------------------------------------------------------------------------------
End of pushing to all repos.   ' -ForegroundColor DarkMagenta