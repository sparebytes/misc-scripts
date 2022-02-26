# About:
# Merges SQL Scripts into a single file ".\99_MergedScripts\99_Everything.sql"
# Requires Powershell 3 or above
################################################################


# Make sure we have the required version of powershell
if ($PSVersionTable.PSVersion.Major -lt 3)
{
  Write-Host ""
  Write-Host "---------------------------------------------------------------"
  Write-Host "You are running an ancient version of Powershell (v$($PSVersionTable.PSVersion.Major))."
  Write-Host "This script requires Powershell 3 or greater."
  Write-Host "Look for the latest version here:"
  Write-Host "https://technet.microsoft.com/en-us/scriptcenter"
  Write-Host ""
  Write-Host "The installer you need may look like this: Windows6.1-KB2819745-x64-MultiPkg.msu"
  Write-Host "---------------------------------------------------------------"
  Write-Host ""
  Write-Host "Press any key to continue ..."
  [void]$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
  exit;
}


# Basic Variables
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition;
$outFolder = $scriptPath + "\99_MergedScripts";
$outputEverythingFile = "$outFolder\99_Everything.sql";
$extenstion ="*.sql";
$blockTerminator = "GO";

# Map the folders to the files which will contain the merged scripts
$mergeMapping = [ordered]@{
  ($scriptPath + "\Functions") = "01_Functions.sql";
  ($scriptPath + "\Views") = "02_Views.sql";
  ($scriptPath + "\StoredProcedures") = "03_StoredProcedures.sql";
};

# Create $outFolder if it doesn't exist
$outFolderExistance = Test-Path -PathType Container $outFolder
if ($outFolderExistance -eq $false)
{
    New-Item $outFolder -type Directory
}

# Delete $outFolder\99__MergedEverything.sql
If (Test-Path $outputEverythingFile){
  Remove-Item $outputEverythingFile
}

# Function that takes a directory of scripts and combines them into a single file
function combine-scripts
{
  param( [string]$inputFolder, [string]$outputFile, [Parameter(Mandatory=$false)][string]$outputFile2 )

  Write-Host "";
  Write-Host "# $outputFile";
  Write-Host "# $inputFolder";

  [System.IO.DirectoryInfo]$directoryInfo = New-Object System.IO.DirectoryInfo($inputFolder);
  $rgFiles = $directoryInfo.GetFiles($extenstion);

  $builder = New-Object System.Text.StringBuilder;
  [void]$builder.AppendLine("");
  [void]$builder.AppendLine($blockTerminator);

  foreach ($fileInfo in $rgFiles)
  {
      [System.IO.FileStream]$fReader = $fileInfo.OpenRead();

      if (-not ($fileInfo -eq $null))
      {
          Write-Host "  - $($fileInfo.Name)";
          $reader = New-Object System.IO.StreamReader($fReader);
          [void]$builder.AppendLine("Print '# "+ $fileInfo.Name +"'");
          [void]$builder.AppendLine($reader.ReadToEnd());
          [void]$builder.AppendLine($blockTerminator);
      }
  }

  if (-NOT $inputFolder.EndsWith('\'))
  {
      $inputFolder = $inputFolder + '\';
  }

  $outputString = $builder.ToString();

  $outputString | Out-File -FilePath $outputFile -Encoding utf8

  if ($outputFile2)
  {
    $outputString | Out-File -FilePath $outputFile2 -Encoding utf8 -Append
  }
}

# Main Loop
foreach ($kv in $mergeMapping.GetEnumerator())
{
  combine-scripts -inputFolder $kv.Key -outputFile "$outFolder\$($kv.Value)" -outputFile2 $outputEverythingFile;
}
