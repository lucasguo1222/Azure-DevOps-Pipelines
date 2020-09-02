
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
