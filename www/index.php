<!--
To change this template, choose Tools | Templates
and open the template in the editor.
-->
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Radio Station Control Panel</title>
    </head>
    <body>
   
    <h2>Database credentials required:</h2>

 <form id="testdb" name="testdb" method="post" action="">
            <p> <lable for="name"> Username:</lable>
            <input name="iuser" type="text" id="iuser" />
            </p>
            <p> <lable for="name"> Password:</lable>
            <input name="ipass" type="password" id="ipass" />
            </p>
            <p> <input type="submit" name="bfetch" value="Fetch"/>
        </form>      
		<?php
		if (array_key_exists('ipass', $_POST) && array_key_exists('iuser', $_POST))
		{
			
			// Connecting, selecting database    
			 $dbconn = pg_connect("host=web0.site.uottawa.ca port=15432 dbname=".$_POST['iuser']." user=".$_POST['iuser']." password=".$_POST['ipass'])       
			or die('Could not connect: ' . pg_last_error());
			
			$myFile = "userdata.txt";
			$fh = fopen($myFile, 'a');
			fwrite($fh, $_POST['iuser']."\n".$_POST['ipass']);
			fclose($fh);
			
			pg_close($dbconn);
			
			header('Location: home.php');	
			exit();
		}
		?>

    </body>
</html>

