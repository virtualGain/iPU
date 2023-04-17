# iPU
Powershell Script that updates itunes playlists based on folder

## Usage
Open a powershell prompt

  cd ~
  
  git clone https://github.com/virtualGain/iPU.git
  
<<<<<<< HEAD
set up a daily task to run the script
=======
modify the xml to your windows username!

  cd iPU

  Register-ScheduledTask -Xml (Get-Content DailyTask.xml | Out-String) -TaskName "DailyiTunesPlaylistTask"
>>>>>>> 3d67bcca4e86c89de4411cb608f725683e1ef09b
