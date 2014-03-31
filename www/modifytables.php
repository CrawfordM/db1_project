<!DOCTYPE html>
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
			
			$query1='select * from project.hostshow';
			$result1=pg_query($query1) or die('Query failed: ' . pg_last_error());
			
			echo "<p><h2> Hostshow table:</h2>\n";
			echo "contract_num, emp_num, show_num, host_start_year, host_start_month\n";
			echo "<table>\n";
			while ($line = pg_fetch_array($result1, null, PGSQL_ASSOC)) {
				echo "\t<tr>\n";
				foreach ($line as $col_value) {
					echo "\t\t<td>$col_value</td>\n";
				}
				echo "\t</tr>\n";
			}
			
			echo "</table></p>\n";
			echo " <form id=\"testdb\" name=\"testdb\" method=\"post\" action=\"\">\n
            <p> <lable for=\"name\"> Delete entry:</lable>\n
            <input name=\"idel1\" type=\"text\" id=\"idel1\" />\n
            </p>\n
            <p> <lable for=\"name\"> Add entry (comma-separated):</lable>\n
            <input name=\"iadd1\" type=\"text\" id=\"iadd1\" />\n
            </p>\n
            <p> <input type=\"submit\" name=\"bfetch\" value=\"Add/Delete\"/>\n
        </form>\n";
        
        	$query2='select * from project.song';
			$result2=pg_query($query2) or die('Query failed: ' . pg_last_error());
			
			echo "<p><h2> Song table:</h2>\n";
			echo "song_num, title, cancon, instrumental, album_num, performer_num\n";
			echo "<table>\n";
			while ($line = pg_fetch_array($result2, null, PGSQL_ASSOC)) {
				echo "\t<tr>\n";
				foreach ($line as $col_value) {
					echo "\t\t<td>$col_value</td>\n";
				}
				echo "\t</tr>\n";
			}
			
			echo "</table></p>\n";
			echo " <form id=\"testdb\" name=\"testdb\" method=\"post\" action=\"\">\n
            <p> <lable for=\"name\"> Delete entry:</lable>\n
            <input name=\"idel2\" type=\"text\" id=\"idel2\" />\n
            </p>\n
            <p> <lable for=\"name\"> Add entry (comma-separated):</lable>\n
            <input name=\"iadd2\" type=\"text\" id=\"iadd2\" />\n
            </p>\n
            <p> <input type=\"submit\" name=\"bfetch\" value=\"Add/Delete\"/>\n
        </form>\n";
			
			$query3='select * from project.guest';
			$result3=pg_query($query3) or die('Query failed: ' . pg_last_error());
			
			echo "<p><h2> Guest table:</h2>\n";
			echo "guest_num, first_name, last_name, descr, topic, rating, slot_num\n";
			echo "<table>\n";
			while ($line = pg_fetch_array($result3, null, PGSQL_ASSOC)) {
				echo "\t<tr>\n";
				foreach ($line as $col_value) {
					echo "\t\t<td>$col_value</td>\n";
				}
				echo "\t</tr>\n";
			}
			
			echo "</table></p>\n";
			echo " <form id=\"testdb\" name=\"testdb\" method=\"post\" action=\"\">\n
            <p> <lable for=\"name\"> Delete entry:</lable>\n
            <input name=\"idel3\" type=\"text\" id=\"idel3\" />\n
            </p>\n
            <p> <lable for=\"name\"> Add entry (comma-separated):</lable>\n
            <input name=\"iadd3\" type=\"text\" id=\"iadd3\" />\n
            </p>\n
            <p> <input type=\"submit\" name=\"bfetch\" value=\"Add/Delete\"/>\n
        </form>\n";
			
			$query4='';
			
			if (array_key_exists('idel1', $_POST))
			{
				$query4 .= "DELETE FROM project.hostshow WHERE contract_num = " . $_POST['idel1'];
			}
			
			if (array_key_exists('idel2', $_POST))
			{
				$query4 .= "DELETE FROM project.song WHERE song_num = " . $_POST['idel2'];
			}
			
			if (array_key_exists('idel3', $_POST))
			{
				$query4 .= "DELETE FROM project.guest WHERE guest_num = " . $_POST['idel3'];
			}
			
			//TODO: add functionality to add data to tables
			
			/*if (array_key_exists('iadd1', $_POST))
			{
				$query4 .= 
			}*/
			
			if($query4 != '')
			{
				$result4=pg_query($query4) or die('Query failed: ' . pg_last_error());
			}
			
			pg_free_result($result1);
			pg_free_result($result2);
			pg_free_result($result3);
			pg_free_result($result4);
			
			$page = $_SERVER['PHP_SELF'];
			$sec = "4";
			header("Refresh: $sec; url=$page");
			
			pg_close($dbconn);
		?>
</body>
</html>
