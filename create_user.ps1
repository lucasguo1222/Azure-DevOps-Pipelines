Write-Verbose “Get SID“
$objId=”75b66b4c-c5e7-4fda-81f3-0e96426a8698“
function ConvertTo-Sid {
param (
[string]$objectId
)
[guid]$guid = [System.Guid]::Parse($objectId)
foreach ($byte in $guid.ToByteArray()) {
$byteGuid += [System.String]::Format(“{0:X2}”, $byte)
}
return “0x” + $byteGuid
}
$SID=ConvertTo-Sid($objId)
Write-Verbose “Create SQL connectionstring”
$conn = New-Object System.Data.SqlClient.SQLConnection
$conn.ConnectionString = “Server=v-luguo.database.windows.net;Initial Catalog=lucasDB;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30”
$conn.AccessToken = $(sqlToken)

Write-Verbose "Connect to database and execute SQL script"
$conn.Open()
Write-Verbose "Opened the connection and start to query"
$query = "
create user lucasuser11 with password = 'Password001122!!'
"

Write-Host $query
$command = New-Object -TypeName System.Data.SqlClient.SqlCommand($query, $conn)
$Result = $command.ExecuteNonQuery()
$conn.Close()