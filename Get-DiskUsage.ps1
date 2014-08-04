# Get-DiskUsage.ps1 (aliased to dfspace)
# Use Get-WMIObject to collect disk free info
# Can be used with remote systems
#
param ( [string]$computer = "." , [switch]$all)
# Formatting 
$size = @{ l = "Size (MB)"; e = { $_.size/1mb};      f = "{0:N}"}
$free = @{ l = "free (MB)"; e = { $_.freespace/1mb}; f = "{0:N}"} 
$perc = @{ l = "percent"; e = { 100.0 * ([double]$_.freespace/[double]$_.size)}; f="{0:f}" }
$name = @{ e = "name"; f = "{0,-20}" }
$fields = $name,$size,$free,$perc

# in case the user wants to see more than just local drives
$filter = "DriveType = '3'"
if ( $all ) { $filter = "" }

# go do the work by getting the information from the appropriate
# computer, and send it to format-table with the appropriate 
# fields and formatting info
get-wmiobject -class win32_logicaldisk -filter $filter -comp $computer | 
    format-table $fields -auto