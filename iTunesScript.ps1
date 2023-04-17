param(
    [Parameter(Mandatory=$true)][string]$music_directory,
    [string]$prepend_pl_name
)

function AddSongsToPlaylist($folder, $playlist) {
    $mp3Files = Get-ChildItem -Path $folder -Include *.mp3,*.m4a -Recurse -File
    foreach ($file in $mp3Files) {
        $found = $false
        foreach ($song in $playlist.Tracks) {
            if ($song.Location -eq $file.FullName) {
                $found = $true
                break
            }
        }
        if (-not $found) {
            $playlist.AddFile($file.FullName)
        }
    }
}

if (-not (Test-Path $music_directory)) {
    Write-Host "Error: Specified directory does not exist" -ForegroundColor Red
    exit
}

$itunes = New-Object -ComObject iTunes.Application

function ProcessDirectory($directory, $depth) {
    if ($depth -eq 4) {
        return
    }

    $subdirectories = Get-ChildItem -Path $directory -Directory
    foreach ($subdir in $subdirectories) {
        $playlistName = $prepend_pl_name + $subdir.Name
        $playlist = $null

        for ($i = 1; $i -le $itunes.Sources.Item(1).Playlists.Count; $i++) {
            if ($itunes.Sources.Item(1).Playlists.Item($i).Name -eq $playlistName) {
                $playlist = $itunes.Sources.Item(1).Playlists.Item($i)
                break
            }
        }

        if ($playlist -eq $null) {
            $playlist = $itunes.CreatePlaylist($playlistName)
        }

        AddSongsToPlaylist $subdir.FullName $playlist
        ProcessDirectory $subdir.FullName ($depth + 1)
    }
}

ProcessDirectory $music_directory 0
