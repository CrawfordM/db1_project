<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
<title>Change tables</title>
</head>
	
<body>
		<?php
			
			$fh = fopen("./userdata.txt", "r");
			$user = fgets($fh);
			$pass = fgets($fh);
			fclose($fh);
			
			 // Connecting, selecting database    
			 $dbconn = pg_connect("host=web0.site.uottawa.ca port=15432 dbname=".$user." user=".$user." password=".$pass)        
			or die('Could not connect: ' . pg_last_error()); 
			
			$query='select * from project.hostshow';
			$result=pg_query($query) or die('Query failed: ' . pg_last_error());
			
			echo "<h> Hostshow table:</h>\n";
			echo "<table>\n";
			while ($line = pg_fetch_array($result, null, PGSQL_ASSOC)) {
				echo "\t<tr>\n";
				foreach ($line as $col_value) {
					echo "\t\t<td>$col_value</td>\n";
				}
				echo "\t</tr>\n";
			}
			echo "</table>\n";
			
			
			pg_free_result($result);
			
			pg_close($dbconn);
		?>
</body>
</html>
