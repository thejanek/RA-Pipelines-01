Clear-Host
###############################################################################################
# Variables
$Remote_repos_list = ("ra-pipelines-01")
$Branch_Name = "testbranch02" #"master"
# $Local_Repo_path = $env:SYSTEM_DEFAULTWORKINGDIRECTORY
$Local_Repo_path = "C:\Users\ljankowski1\Documents\Programing\Repos\Labs\RA-pipelines-01"


##############################################################################################
# Set dafault local location for our Repository.
Set-Location -Path $Local_Repo_path | Out-Null

###############################################################################################
# Show local Rerpo path
Write-Host '
-----------------------------------------------------------------------------------------------
Local Repo path: ' -ForegroundColor  DarkMagenta | Out-Null
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
$current_date = ((Get-Date -Format yyyy-MM-dd--hh-mm) + "---" + (Get-Date).Ticks)

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
# Adding new Release - it is the same as tag so it is new tag name

# Getting list of tags (like: v1.30, v1.31, v1.32...)
$List_of_all_Tags = git tag

# Select last charcter of tak name
$Last_Tag_Name = $List_of_all_tags | Select-Object -Last 1 

# Select last characters after "." (like from "v2.10" it will be "10")
$Last_characters_from_Tag = $Last_Tag_Name.Split(".") | Select-Object -Last 1

# Convert to intiger (Int32)
$Last_characters_from_Tag_Int = [int]$Last_characters_from_Tag

# Add 1 to number 
$New_number = $Last_characters_from_Tag_Int + 1

# Current Tag Name
$New_Tag_Name = (($Last_Tag_Name.Split(".") | Select-Object -First 1) + "." + [string]$New_number) 

# Add new tag
    git tag $New_Tag_Name

###############################################################################################
# Push to all repos from list of $Remote_repos_list and branch $Branch_Name
foreach ($repo in $Remote_repos_list) {
    Write-Host ('
----------------------------------------------------------------
Repo Name               : ' + $repo + '
Branch Name             : ' + $Branch_Name + '
Release Name (Tag Name) : ' + $New_Tag_Name + '
Commit Name             : ' + $current_date + '

Pushing new commit named ' + $current_date + ' to ' + $repo + '.
(by "git push ' + $repo + ' ' + $Branch_Name + ' ' + $New_Tag_Name + ')') -ForegroundColor Yellow

    git push $repo $Branch_Name $New_Tag_Name
}

###############################################################################################
# END
Write-Host '
-----------------------------------------------------------------------------------------------
End of pushing to all repos.' -ForegroundColor DarkMagenta
