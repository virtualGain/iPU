# iPU
Powershell Script that updates itunes playlists based on folder

## Usage
Open a powershell prompt
cd ~
git clone https://github.com/virtualGain/iPU.git
modify the xml to your windows username
Register-ScheduledTask -Xml (Get-Content DailyTask.xml | Out-String) -TaskName "DailyiTunesPlaylistTask"
